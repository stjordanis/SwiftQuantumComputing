# Quantum circuit simulator in Swift

[![CI Status](https://github.com/indisoluble/SwiftQuantumComputing/workflows/build/badge.svg?branch=master)](https://github.com/indisoluble/SwiftQuantumComputing/actions?query=branch%3Amaster)
[![codecov](https://codecov.io/gh/indisoluble/SwiftQuantumComputing/branch/master/graph/badge.svg)](https://codecov.io/gh/indisoluble/SwiftQuantumComputing)
[![Version](https://img.shields.io/cocoapods/v/SwiftQuantumComputing.svg)](http://cocoapods.org/pods/SwiftQuantumComputing)
![platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)
[![Documentation](https://indisoluble.github.io/SwiftQuantumComputing/badge.svg)](https://indisoluble.github.io/SwiftQuantumComputing)

A quantum circuit simulator written in Swift and accelerated with [Accelerate.framework](https://developer.apple.com/documentation/accelerate) in iOS/macOS and [BLAS](http://www.netlib.org/blas/) in Linux.

Along side the simulator there is a genetic algorithm to automatically generate circuits as well as others useful algorithms for quantum computing.

The code written so far is mostly based on the content of: [Quantum Computing for Computer Scientists](https://www.amazon.com/Quantum-Computing-Computer-Scientists-Yanofsky/dp/0521879965), with a few tips from [Automatic Quantum Computer Programming: A Genetic Programming Approach](https://www.amazon.com/Automatic-Quantum-Computer-Programming-Approach/dp/038736496X). It is also inspired by [IBM Qiskit](https://github.com/Qiskit/qiskit-terra).

## Usage

### Build & use a quantum circuit

```swift
import SwiftQuantumComputing // for macOS
//: 1. Compose a list of quantum gates. Insert them in the same order
//:    you want them to appear in the quantum circuit
let matrix = Matrix([[Complex.one, Complex.zero, Complex.zero, Complex.zero],
                     [Complex.zero, Complex.one, Complex.zero, Complex.zero],
                     [Complex.zero, Complex.zero, Complex.zero, Complex.one],
                     [Complex.zero, Complex.zero, Complex.one, Complex.zero]])
let gates = [
    Gate.hadamard(target: 3),
    Gate.controlledMatrix(matrix: matrix, inputs: [3, 4], control: 1),
    Gate.controlledNot(target: 0, control: 3),
    Gate.matrix(matrix: matrix, inputs: [3, 2]),
    Gate.not(target: 1),
    Gate.oracle(truthTable: ["01", "10"], target: 3, controls: [0, 1]),
    Gate.phaseShift(radians: 0.25, target: 0)
]
//: 2. (Optional) Draw the quantum circuit to see how it looks
let drawer = MainDrawerFactory().makeDrawer()
drawer.drawCircuit(gates)
//: 3. Build the quantum circuit with the list of gates
let circuit = MainCircuitFactory().makeCircuit(gates: gates)
//: 4. Use the quantum circuit
print("Statevector: \(circuit.statevector())\n")
print("Probabilities: \(circuit.probabilities())\n")
print("Summarized probabilities: \(circuit.summarizedProbabilities())\n")
let groupedProbs = circuit.groupedProbabilities(byQubits: [1, 0], summarizedByQubits: [4, 3, 2])
print("Grouped probabilities: \(groupedProbs)")
print("Unitary: \(circuit.unitary())\n")
```

Check full code in [Circuit.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Usage/Circuit.playground/Contents.swift).

### Draw a quantum circuit

![Draw a quantum circuit](https://raw.githubusercontent.com/indisoluble/SwiftQuantumComputing/master/Images/Drawer.jpg)

Check full code in [Drawer.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Usage/Drawer.playground/Contents.swift).

### Use a genetic algorithm to automatically generate a quantum circuit

```swift
import SwiftQuantumComputing // for macOS
//: 1. Define a configuration for the genetic algorithm
let config = GeneticConfiguration(depth: (1..<50),
                                  generationCount: 2000,
                                  populationSize: (2500..<6500),
                                  tournamentSize: 7,
                                  mutationProbability: 0.2,
                                  threshold: 0.48,
                                  errorProbability: 0.000000000000001)
//: 2. Also the uses cases, i.e. the circuit outputs you want to get
//:    when the oracle is configured with the different truth tables
let cases = [
    GeneticUseCase(emptyTruthTableQubitCount: 1, circuitOutput: "00"),
    GeneticUseCase(truthTable: ["0", "1"], circuitOutput: "00"),
    GeneticUseCase(truthTable: ["0"], circuitOutput: "10"),
    GeneticUseCase(truthTable: ["1"], circuitOutput: "10")
]
//: 3. And which gates can be used to find a solution
let gates: [ConfigurableGate] = [HadamardGate(), NotGate()]
//: 4. Now, run the genetic algorithm to find/evolve a circuit that solves
//:    the problem modeled with the use cases
let evolvedCircuit = MainGeneticFactory().evolveCircuit(configuration: config,
                                                        useCases: cases,
                                                        gates: gates)
print("Solution found. Fitness score: \(evolvedCircuit.eval)")

for useCase in cases {
//: 5. (Optional) Draw the solution (check `Sources` folder in Playground for the source code)
    let evolvedGates = configureEvolvedGates(in: evolvedCircuit, with: useCase)
    drawCircuit(with: evolvedGates, useCase: useCase)
//: 6. (Optional) Check how well the solution found meets each use case
//:    (check `Sources` folder in Playground for the source code)
    let probs = probabilities(in: evolvedGates, useCase: useCase)
    print(String(format: "Use case: [%@]. Input: %@ -> Output: %@. Probability: %.2f %%",
                 useCase.truthTable.truth.joined(separator: ", "),
                 useCase.circuit.input,
                 useCase.circuit.output,
                 (probs[useCase.circuit.output] ?? 0.0) * 100))
}
```

Check full code in [Genetic.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Usage/Genetic.playground/Contents.swift).

## Other examples

Check following playgrounds for more examples:

* [BernsteinVaziraniAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Example/BernsteinVaziraniAlgorithm.playground/Contents.swift) - Bernstein–Vazirani algorithm.
* [DeutschAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Example/DeutschAlgorithm.playground/Contents.swift) - Deutsch's algorithm.
* [DeutschJozsaAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Example/DeutschJozsaAlgorithm.playground/Contents.swift) - Deutsch-Jozsa algorithm.
* [GroverAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Example/GroverAlgorithm.playground/Contents.swift) - Grover's algorithm.
* [ShorAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Example/ShorAlgorithm.playground/Contents.swift) - Shor's Algorithm.
* [SimonPeriodicityAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Example/SimonPeriodicityAlgorithm.playground/Contents.swift) - Simon's periodicity algorithm.

## Other algorithms

### Euclidean Algorithm: Find greatest common divisor of two integers

```swift
import SwiftQuantumComputing // for macOS
//: 1. Define two integers
let a = 252
let b = 105
//: 2. Use Euclidean solver to find greatest common divisor of these integers
let gcd = EuclideanSolver.findGreatestCommonDivisor(a, b)
print("Greatest common divisor of \(a) & \(b): \(gcd)")
```

Check full code in [EuclideanAlgorithm.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Usage/EuclideanAlgorithm.playground/Contents.swift).

### Continued Fractions: Find an approximation to a given rational number

```swift
import SwiftQuantumComputing // for macOS
//: 1. Define rational value to approximate
let value = Rational(numerator: 15, denominator: 11)
//: 2. And a limit or maximum difference between approximation and original value
let limit = Rational(numerator: 1, denominator: 33)
//: 3. Use Continued Fractions solver to find a solution
let approximation = ContinuedFractionsSolver.findApproximation(of: value,
                                                               differenceBelowOrEqual: limit)
print("Approximation for \(value) (limit: \(limit)): \(approximation)")
```

Check full code in [ContinuedFractions.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Usage/ContinuedFractions.playground/Contents.swift).

### Gaussian Elimination: Solve a system of XOR equations

```swift
import SwiftQuantumComputing // for macOS
//: 1. Define system of XOR equations:
//:    * `x6 ^      x4 ^      x2 ^ x1      = 0`
//:    * `          x4 ^                x0 = 0`
//:    * `x6 ^ x5 ^           x2 ^      x0 = 0`
//:    * `          x4 ^ x3 ^      x1 ^ x0 = 0`
//:    * `     x5 ^      x3 ^           x0 = 0`
//:    * `          x4 ^ x3 ^      x1      = 0`
//:    * `     x5 ^ x4 ^      x2 ^ x1 ^ x0 = 0`
let equations = [
    "1010110",
    "0010001",
    "1100101",
    "0011011",
    "0101001",
    "0011010",
    "0110111"
]
//: 2. Build Gaussian elimination solver
let solver = MainXorGaussianEliminationSolverFactory().makeSolver()
//: 3. Use solver
print("Solutions: \(solver.findActivatedVariablesInEquations(equations))")
```

Check full code in [XorGaussianElimination.playground](https://github.com/indisoluble/SwiftQuantumComputing/tree/master/Playground/Usage/XorGaussianElimination.playground/Contents.swift).

## Documentation

Documentation for the project can be found [here](https://indisoluble.github.io/SwiftQuantumComputing).

## Linux

As mentioned above, this package depends on [BLAS](http://www.netlib.org/blas/) if running on Linux, more exactly, [Ubuntu](https://www.ubuntu.com).

This dependency is reflected in `Package.swift` with [CBLAS-Linux](https://github.com/indisoluble/CBLAS-Linux), which in turn expects to find the following file: `/usr/include/x86_64-linux-gnu/cblas-netlib.h`. So, after installing [BLAS](http://www.netlib.org/blas/) (in case it is not already there):

```
sudo apt-get install libblas-dev
```

Check `cblas-netlib.h` is in the expected location.
