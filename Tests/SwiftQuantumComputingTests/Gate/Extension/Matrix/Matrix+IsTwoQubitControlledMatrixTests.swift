//
//  Matrix+IsTwoQubitControlledMatrixTests.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 12/05/2020.
//  Copyright © 2020 Enrique de la Torre. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest

@testable import SwiftQuantumComputing

// MARK: - Main body

class Matrix_IsTwoQubitControlledMatrixTests: XCTestCase {

    // MARK: - Tests

    func testMatrixWithThreeRows_isTwoQubitControlledMatrix_returnFalse() {
        // Given
        let matrix = try! Matrix([
            [Complex.zero],
            [Complex.zero],
            [Complex.zero]
        ])

        // Then
        XCTAssertFalse(matrix.isTwoQubitControlledMatrix())
    }

    func testMatrixWithFiveRows_isTwoQubitControlledMatrix_returnFalse() {
        // Given
        let matrix = try! Matrix([
            [Complex.zero],
            [Complex.zero],
            [Complex.zero],
            [Complex.zero],
            [Complex.zero]
        ])

        // Then
        XCTAssertFalse(matrix.isTwoQubitControlledMatrix())
    }

    func testMatrixWithFourRowsAndThreeColumns_isTwoQubitControlledMatrix_returnFalse() {
        // Given
        let matrix = try! Matrix([
            [Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero]
        ])

        // Then
        XCTAssertFalse(matrix.isTwoQubitControlledMatrix())
    }

    func testMatrixWithFourRowsAndFiveColumns_isTwoQubitControlledMatrix_returnFalse() {
        // Given
        let matrix = try! Matrix([
            [Complex.zero, Complex.zero, Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero, Complex.zero, Complex.zero]
        ])

        // Then
        XCTAssertFalse(matrix.isTwoQubitControlledMatrix())
    }

    func testTwoQubitNotControlledMatrix_isTwoQubitControlledMatrix_returnFalse() {
        // Given
        let matrix = try! Matrix([
            [Complex.zero, Complex.one, Complex.zero, Complex.zero],
            [Complex.one, Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.one, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero, Complex.one]
        ])

        // Then
        XCTAssertFalse(matrix.isTwoQubitControlledMatrix())
    }

    func testTwoQubiControlledMatrix_isTwoQubitControlledMatrix_returnTrue() {
        // Then
        XCTAssertTrue(Matrix.makeControlledNot().isTwoQubitControlledMatrix())
    }

    static var allTests = [
        ("testMatrixWithThreeRows_isTwoQubitControlledMatrix_returnFalse",
         testMatrixWithThreeRows_isTwoQubitControlledMatrix_returnFalse),
        ("testMatrixWithFiveRows_isTwoQubitControlledMatrix_returnFalse",
         testMatrixWithFiveRows_isTwoQubitControlledMatrix_returnFalse),
        ("testMatrixWithFourRowsAndThreeColumns_isTwoQubitControlledMatrix_returnFalse",
         testMatrixWithFourRowsAndThreeColumns_isTwoQubitControlledMatrix_returnFalse),
        ("testMatrixWithFourRowsAndFiveColumns_isTwoQubitControlledMatrix_returnFalse",
         testMatrixWithFourRowsAndFiveColumns_isTwoQubitControlledMatrix_returnFalse),
        ("testTwoQubitNotControlledMatrix_isTwoQubitControlledMatrix_returnFalse",
         testTwoQubitNotControlledMatrix_isTwoQubitControlledMatrix_returnFalse),
        ("testTwoQubiControlledMatrix_isTwoQubitControlledMatrix_returnTrue",
         testTwoQubiControlledMatrix_isTwoQubitControlledMatrix_returnTrue)
    ]
}
