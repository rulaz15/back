import UIKit

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"


class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        let random = generator.random()
        let sidesDouble = Double(sides)
        return Int(random * sidesDouble) + 1
    }
}

let sides = 24
let myDice = Dice(sides: sides, generator: LinearCongruentialGenerator())
var numsInDice = Set<Int>()
var count = 0
while numsInDice.count != sides {
    numsInDice.insert(myDice.roll())
    count += 1
}
count
print(numsInDice.sorted())
