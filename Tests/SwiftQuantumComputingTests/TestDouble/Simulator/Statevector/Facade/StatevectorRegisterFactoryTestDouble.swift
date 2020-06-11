//
//  StatevectorRegisterFactoryTestDouble.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 30/12/2018.
//  Copyright © 2018 Enrique de la Torre. All rights reserved.
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

@testable import SwiftQuantumComputing

// MARK: - Main body

final class StatevectorRegisterFactoryTestDouble {

    // MARK: - Internal properties

    private (set) var makeRegisterCount = 0
    private (set) var lastMakeRegisterState: Vector?
    var makeRegisterResult: StatevectorRegister?
    var makeRegisterError = MakeRegisterError.stateCountHasToBeAPowerOfTwo

    private (set) var makeRegisterStateCount = 0
    private (set) var lastMakeRegisterStateState: CircuitStatevector?
    var makeRegisterStateResult = StatevectorRegisterTestDouble()
}

// MARK: - StatevectorRegisterFactory methods

extension StatevectorRegisterFactoryTestDouble: StatevectorRegisterFactory {
    func makeRegister(state: Vector) -> Result<StatevectorRegister, MakeRegisterError> {
        makeRegisterCount += 1

        lastMakeRegisterState = state

        if let makeRegisterResult = makeRegisterResult {
            return .success(makeRegisterResult)
        }

        return .failure(makeRegisterError)
    }

    func makeRegister(state: CircuitStatevector) -> StatevectorRegister {
        makeRegisterStateCount += 1

        lastMakeRegisterStateState = state

        return makeRegisterStateResult
    }
}
