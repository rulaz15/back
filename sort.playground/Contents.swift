import UIKit

var nums = [Int]()
for _ in 0...Int.random(in: 10...20) {
    let num = Int.random(in: 0...100)
    nums.append(num)
}

let sortedNumsShort     = nums.sorted(by: >)
print(sortedNumsShort)

let sortedNums          = nums.sorted(by: {$0 > $1})
print(sortedNums)

let sortedNumsM         = nums.sorted(by: {v1, v2 in v1 > v2})
print(sortedNumsM)

let sortedNumsLong      = nums.sorted { (v1, v2) -> Bool in
    return v1 > v2
}
print(sortedNumsLong)
