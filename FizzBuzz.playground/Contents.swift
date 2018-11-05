import UIKit

let numbers = [1,2,3,4,5]

var nums = [Int]()

for i in 1...1000 {
    nums.append(i)
}

for num in nums {
    if num % 15 == 0 { //num % 3 == 0 && num % 5 == 0 {
        print("\(num) fizzbuzz")
    } else if num % 3 == 0 {
        print("\(num) fizz")
    } else if num % 5 == 0 {
        print("\(num) buzz")
    } else {
        print(num)
    }
}
