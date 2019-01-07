//
//  CircuitViewPosition+PositionView.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 15/09/2018.
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

extension CircuitViewPosition {

    // MARK: - Internal methods

    func makePositionView(size: CGSize) -> PositionView {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        switch self {
        case .qubit(let index):
            let view = QubitPositionView(frame: frame)
            view.showIndex(index)

            return view
        case .lineHorizontal:
            return LineHorizontalPositionView(frame: frame)
        case .crossedLines:
            return CrossedLinesPositionView(frame: frame)
        case .hadamard:
            return HadamardPositionView(frame: frame)
        case .not:
            return NotPositionView(frame: frame)
        case .phaseShift(let radians):
            let view = PhaseShiftPositionView(frame: frame)
            view.showRadians(radians)

            return view
        case .controlledNotDown:
            return ControlledNotDownPositionView(frame: frame)
        case .controlledNotUp:
            return ControlledNotUpPositionView(frame: frame)
        case .controlUp:
            return ControlUpPositionView(frame: frame)
        case .controlDown:
            return ControlDownPositionView(frame: frame)
        case .matrix:
            return MatrixPositionView(frame: frame)
        case .matrixTop(let inputs):
            let view = MatrixTopPositionView(frame: frame)
            view.showInputs(inputs)

            return view
        case .matrixBottom:
            return MatrixBottomPositionView(frame: frame)
        case .matrixMiddleConnected:
            return MatrixMiddleConnectedPositionView(frame: frame)
        case .matrixMiddleUnconnected:
            return MatrixMiddleUnconnectedPositionView(frame: frame)
        }
    }
}
