//
//  Matrix+Permutation.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 11/05/2020.
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

import Foundation

// MARK: - Main body

extension Matrix {

    // MARK: - Internal class methods

    enum MakePermutationError: Error {
        case doNotPassAnEmptyPermutation
        case doNotRepeatIndexesInPermutation
        case doNotUseNegativeIndexesInPermutation
    }

    static func makePermutation(permutation: [Int]) throws -> Matrix {
        let count = permutation.count
        guard count > 0 else {
            throw MakePermutationError.doNotPassAnEmptyPermutation
        }

        guard count == Set(permutation).count else {
            throw MakePermutationError.doNotRepeatIndexesInPermutation
        }

        guard permutation.filter({ $0 < 0 }).isEmpty else {
            throw MakePermutationError.doNotUseNegativeIndexesInPermutation
        }

        return try! Matrix.makeMatrix(rowCount: count, columnCount: count) { row, col in
            return col == permutation[row] ? Complex.one : Complex.zero
        }
    }
}
