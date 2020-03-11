//
//  Complex+OverloadedOperatorsTests.swift
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

class Complex_OverloadedOperatorsTests: XCTestCase {

    // MARK: - Tests

    func testTwoComplexNumbers_multiply_returnExpectedCompleNumber() {
        // Given
        let lhs = Complex(real: 3, imag: -1)
        let rhs = Complex(real: 1, imag: 4)

        // When
        let result = (lhs * rhs)

        // Then
        let expectedResult = Complex(real: 7, imag: 11)
        XCTAssertEqual(result, expectedResult)
    }

    static var allTests = [
        ("testTwoComplexNumbers_multiply_returnExpectedCompleNumber",
         testTwoComplexNumbers_multiply_returnExpectedCompleNumber)
    ]
}
