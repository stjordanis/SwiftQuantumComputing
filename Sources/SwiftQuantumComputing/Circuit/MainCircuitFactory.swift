//
//  MainCircuitFactory.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 26/01/2019.
//  Copyright © 2019 Enrique de la Torre. All rights reserved.
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

/// Conforms `MainCircuitFactory`. Use to create new `Circuit` instances
public struct MainCircuitFactory {

    // MARK: - Public init methods

    /// Initialize a `MainCircuitFactory` instance
    public init() {}
}

// MARK: - CircuitFactory methods

extension MainCircuitFactory: CircuitFactory {

    /// Check `CircuitFactory.makeCircuit(gates:)`
    public func makeCircuit(gates: [Gate]) -> Circuit {
        let matrixFactory = SimulatorCircuitMatrixFactoryAdapter()

        let unitaryGateFactory = UnitaryGateFactoryAdapter(matrixFactory: matrixFactory)
        let unitarySimulator = UnitarySimulatorFacade(gateFactory: unitaryGateFactory)

        let statevectorRegisterFactory = StatevectorRegisterFactoryAdapter(matrixFactory: matrixFactory)
        let statevectorSimulator = StatevectorSimulatorFacade(registerFactory: statevectorRegisterFactory)

        return CircuitFacade(gates: gates,
                             unitarySimulator: unitarySimulator,
                             statevectorSimulator: statevectorSimulator)
    }
}
