import UIKit


func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

func swapTwoValues<N>(_ a: inout N, _ b: inout N) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var valOne = "onee"
var valTwo = "two"
swapTwoValues(&valOne, &valTwo)
print(valOne, valTwo)

////////////////////////////////////////////////////////////////////////

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}


var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

print(stackOfStrings)

let fromTheTop = stackOfStrings.pop()
print(fromTheTop)
fromTheTop
print(stackOfStrings)
