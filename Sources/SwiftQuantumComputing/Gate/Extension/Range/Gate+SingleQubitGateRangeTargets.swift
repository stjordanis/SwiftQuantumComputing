//
//  Gate+SingleQubitGateRangeTargets.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 21/12/2019.
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

extension Gate {

    // MARK: - Public class methods

    /// Produces a list of `Gate.hadamard(target:)`, each gate on one of the `targets`
    public static func hadamard(targets: Range<Int>) -> [Gate] {
        return hadamard(targets: Array(targets))
    }

    /// Produces a list of `Gate.hadamard(target:)`, each gate on one of the `targets`
    public static func hadamard(targets: ClosedRange<Int>) -> [Gate] {
        return hadamard(targets: Array(targets))
    }

    /// Produces a list of `Gate.hadamard(target:)`, each gate on one of the `targets`
    public static func hadamard(targets: Int...) -> [Gate] {
        return hadamard(targets: targets)
    }

    /// Produces a list of `Gate.not(target:)`, each gate on one of the `targets`
    public static func not(targets: Range<Int>) -> [Gate] {
        return not(targets: Array(targets))
    }

    /// Produces a list of `Gate.not(target:)`, each gate on one of the `targets`
    public static func not(targets: ClosedRange<Int>) -> [Gate] {
        return not(targets: Array(targets))
    }

    /// Produces a list of `Gate.not(target:)`, each gate on one of the `targets`
    public static func not(targets: Int...) -> [Gate] {
        return not(targets: targets)
    }
}
