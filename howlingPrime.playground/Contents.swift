
import UIKit

//A howling prime is a prime number if the sum of its digits is also prime
//113 true
//89 true
//19 false

var num = 89


var primes = [Int]()
var howlingNumbers : [Int] = []



func isPrime(number: Int) -> Bool {
//    let maxDivider = Int(sqrt(Double(number)))
//    return number > 1 && !(2...maxDivider).contains { number % $0 == 0 }
    return number > 1 && !(2..<number).contains { number % $0 == 0 }

}

func isHowlingPrime(num: Int) -> Bool {
    
    let nestedInts = [num].flatMap { String($0).compactMap{ Int(String($0)) } }
    
    var sum = 0
    
    for n in nestedInts {
        sum += n
    }
    
//    print("""
//        -------------------------------
//        num: \(num)
//        sum: \(sum)
//        """)
    return isPrime(number: sum) && isPrime(number: num)
}

for n in 1...200 {
    if isPrime(number: n) {
        primes.append(n)
    }
}

print(primes)

for prime in primes {
    if isHowlingPrime(num: prime) {
        howlingNumbers.append(prime)
    }
}


print(howlingNumbers)
