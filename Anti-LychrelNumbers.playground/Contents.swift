import UIKit

var number = 295
var sum = 0
var counter = 1
var antiNumbers : [Int] = []

//print(Int.max > 8829154950594410388)
//print(8829154950594410388 + 8830144950594519288)

func isPalindrome(_ p1: String, _ p2: String) -> Bool {
    p1 + "-" + p2
    return p1 == p2
}

func reversedNum(_ n: Int) -> String {
    let numString = String(n)
    return String(numString.reversed())
}

func sumNums(_ n : Int) {
    
    let reversed = reversedNum(n)
    sum = n + Int(reversed)!
    print("\(n) + \(reversed) = \(sum)")
    
    if counter < 30 {
        if !isPalindrome(String(sum), reversedNum(sum)) {
            counter += 1
            sumNums(sum)
        }
    } else {
        print("lych")
    }
    
    if counter == 0 {
        antiNumbers.append(n)
    }
    
    return
}

//sumNums(number)

for testNum in 100...200 {
counter = 0
    sumNums(testNum)
}

print(antiNumbers)
print(antiNumbers.count)

//if counter == 30 {
//    print("si anti")
//}
