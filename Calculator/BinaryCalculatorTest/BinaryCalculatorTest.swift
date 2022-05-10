//
//  BinaryCalculatorTest.swift
//  BinaryCalculatorTest
//
//  Created by ysp on 2021/04/02.
//

import XCTest
@testable import Calculator
class BinaryCalculatorTest: XCTestCase {
    
    var binaryCalculator = BinaryCalculator()
    
    override func setUpWithError() throws {
        binaryCalculator = BinaryCalculator()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        test_convertType_11_입력()
        test_convertType_음수_11_입력()
        test_andOperate_양의정수_두개()
        test_nandOperate_양의정수_두개()
        test_orOperate_양의정수_두개()
        test_norOperate_양의정수_두개()
        test_xorOperate_양의정수_두개()
        test_bitNotOperate_양의정수_한개()
        test_bitShiftOperate_양의정수_한개()
        test_calculate()
    }
    
    func test_convertType_11_입력() {
        XCTAssertEqual(try binaryCalculator.convertType(inputNumber: "11"), 3)
    }
    
    func test_convertType_음수_11_입력() {
        XCTAssertEqual(try binaryCalculator.convertType(inputNumber: "-11"), -3)
    }
    
    func test_andOperate_양의정수_두개() {
        XCTAssertEqual(binaryCalculator.andOperate(with: 29, and: 24), 24)
    }
    
    func test_nandOperate_양의정수_두개() {
        XCTAssertEqual(binaryCalculator.nandOperate(with: 29, and: 24), -25)
    }
    
    func test_orOperate_양의정수_두개() {
        XCTAssertEqual(binaryCalculator.orOperate(with: 29, and: 24), 29)
    }
    
    func test_norOperate_양의정수_두개() {
        XCTAssertEqual(binaryCalculator.norOperate(with: 29, and: 24), -30)
    }
    
    func test_xorOperate_양의정수_두개() {
        XCTAssertEqual(binaryCalculator.xorOperate(with: 29, and: 24), 5)
    }
    
    func test_bitNotOperate_양의정수_한개() {
        XCTAssertEqual(binaryCalculator.bitNotOperate(for: 126), -127)
    }
    
    func test_bitShiftOperate_양의정수_한개() {
        XCTAssertEqual(binaryCalculator.bitShiftOperate(for: -127, isRight: false), -254)
    }
    
    func test_calculate() {
        binaryCalculator = BinaryCalculator()
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "+", operatedNumber: 0b10101, operatingNumber: 2), 23)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "-", operatedNumber: 1, operatingNumber: 1), 0)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "&", operatedNumber: 0b10101, operatingNumber: 2), 0)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "~&", operatedNumber: 0b10101, operatingNumber: 2), -1)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "|", operatedNumber: 0b10101, operatingNumber: 2), 23)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "~|", operatedNumber: 0b10101, operatingNumber: 2), -24)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "^|", operatedNumber: 0b10101, operatingNumber: 2), 23)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "~", operatedNumber: 0b10101, operatingNumber: 2), -22)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: ">>", operatedNumber: 0b10101, operatingNumber: 2), 10)
        XCTAssertEqual(try binaryCalculator.calculate(operateSign: "<<", operatedNumber: 0b10101, operatingNumber: 2), 42)
    }
}


