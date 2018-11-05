import UIKit

var i = "holo"

print("o" ~= i)

let x = 10

switch x {
case let a where x > 0:
    print("positive", a)
case let a where x < 0:
    print("negative", a)
case 0:
    print("zero")
default:
    fatalError("Should be unreachable")
}

func isEven<T: BinaryInteger>(_ a: T) -> Bool {
    return a % 2 == 0
}

switch isEven(x) {
case true: print("even")
case false: print("odd")
}
