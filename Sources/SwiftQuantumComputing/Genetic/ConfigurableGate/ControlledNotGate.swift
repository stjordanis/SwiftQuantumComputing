//
//  ControlledNotGate.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 15/12/2018.
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

// MARK: - Main body

/// A quantum gate used on genetic programming: ControlledNot
public struct ControlledNotGate {

    // MARK: - Public init methods

    /// Initialize a `ControlledNotGate` instance
    public init() {}
}

// MARK: - ConfigurableGate methods

extension ControlledNotGate: ConfigurableGate {

    /// Check `ConfigurableGate.makeFixed(inputs:)`
    public func makeFixed(inputs: [Int]) throws -> Gate {
        guard inputs.count > 1 else {
            throw EvolveCircuitError.gateInputCountIsBiggerThanUseCaseCircuitQubitCount(gate: self)
        }

        return .controlledNot(target: inputs[0], control: inputs[1])
    }
}
