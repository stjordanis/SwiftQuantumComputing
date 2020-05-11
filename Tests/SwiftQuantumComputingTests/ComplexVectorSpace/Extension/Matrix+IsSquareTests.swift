//
//  Matrix+IsSquareTests.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 15/03/2020.
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

class Matrix_IsSquareTests: XCTestCase {

    // MARK: - Tests

    func testNonSquareMatrix_isSquare_returnFalse() {
        // Given
        let complex = Complex.zero
        let matrix = try! Matrix([[complex], [complex]])

        // Then
        XCTAssertFalse(matrix.isSquare)
    }

    func testSquareMatrix_isSquare_returnTrue() {
        // Given
        let complex = Complex.zero
        let matrix = try! Matrix([[complex, complex], [complex, complex]])

        // Then
        XCTAssertTrue(matrix.isSquare)
    }

    static var allTests = [
        ("testNonSquareMatrix_isSquare_returnFalse", testNonSquareMatrix_isSquare_returnFalse),
        ("testSquareMatrix_isSquare_returnTrue", testSquareMatrix_isSquare_returnTrue),
    ]
}
