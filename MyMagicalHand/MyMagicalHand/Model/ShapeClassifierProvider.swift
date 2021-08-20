//
//  ShapeClassifierProvider.swift
//  MyMagicalHand
//
//  Created by 김찬우 on 2021/08/19.
//

import UIKit
import CoreML
import Vision
import ImageIO

class ShapeClassifierProvider {
    var resultTexts: [String]?
    var classificationRequest: VNCoreMLRequest?

    func classificationRequestwithCompletion(completion: @escaping () -> Void) -> VNCoreMLRequest {
        var classificationRequest: VNCoreMLRequest = {
            do {
                let model = try VNCoreMLModel(for: ShapeClassifier().model)

                let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                    self?.processClassifications(for: request, error: error, completion: {
                        completion()
                    })
                })
                request.imageCropAndScaleOption = .centerCrop
                return request
            } catch {
                fatalError("Failed to load Vision ML model: \(error)")
            }
        }()

        return classificationRequest
    }

    func updateClassifications(for image: UIImage, completion: @escaping () -> Void) {
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)) else {
            return
        }

        guard let pixelBuffer = image.toCVPixelBuffer() else { return }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation)

        do {
            try handler.perform([self.classificationRequestwithCompletion(completion: {
                completion()
            })])
        } catch {
            print("Failed to perform classification.\n\(error.localizedDescription)")
        }
    }

    func processClassifications(for request: VNRequest, error: Error?, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                return
            }

            guard let classifications = results as? [VNClassificationObservation] else {
                return
            }

            if !classifications.isEmpty {
                let topClassification = classifications[0]
                let percentage = String(format: "%.1f", topClassification.confidence * 100)
                let result = String(topClassification.identifier) + "처럼 보이네요"
                self.resultTexts = [percentage, result]
            }
            completion()
        }
    }
}
