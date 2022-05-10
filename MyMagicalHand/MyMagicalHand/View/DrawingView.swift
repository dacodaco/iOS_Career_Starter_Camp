//
//  DrawingView.swift
//  MyMagicalHand
//
//  Created by 김찬우 on 2021/08/10.
//

import UIKit

class DrawingView: UIView {
    typealias ButtonAction = () -> Void

    var resultText: String?
    lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var canvasView: UIImageView = {
        let drawingView = UIImageView()
        drawingView.backgroundColor = .white
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        return drawingView
    }()

    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var resultButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .leading
        button.setTitle("결과보기", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .trailing
        button.setTitle("지우기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "예비 글씨"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var percentageToMatch: UILabel = {
        let label = UILabel()
        label.text = "10% 예비 글씨"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure() {
        self.addSubview(containerView)
        self.translatesAutoresizingMaskIntoConstraints = false

        containerView.addArrangedSubview(canvasView)
        containerView.addArrangedSubview(labelStackView)
        containerView.addArrangedSubview(resultLabel)
        containerView.addArrangedSubview(percentageToMatch)

        labelStackView.addArrangedSubview(resultButton)
        labelStackView.addArrangedSubview(deleteButton)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            canvasView.heightAnchor.constraint(equalTo: canvasView.widthAnchor)
        ])
    }
}
