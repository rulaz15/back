import UIKit

class triangle {
    var sideLength = 0.0
    
    var perimeter : Double {
        get {
            return 3.0 * sideLength
        }
        
        set {
            sideLength = newValue / 3.0
        }
    }
}

let t = triangle()
t.perimeter
//t.perimeter = 100  // set
//t.sideLength = 33.3333333333334
//print(t.perimeter) // get
//print(t.sideLength)




//DIDSET - WILLSET
//willSet is called just before the value is stored.
//didSet is called immediately after the new value is stored.

//class StepCounter {
//    var totalSteps: Int = 0 {
//        willSet(newTotalSteps) {
//            print("About to set totalSteps to \(newTotalSteps)")
//        }
//        didSet {
//            totalSteps = totalSteps + 1
//            if totalSteps > oldValue  {
//                print("Added \(totalSteps - oldValue) steps")
//            }
//        }
//    }
//}
//let stepCounter = StepCounter()
//stepCounter.totalSteps = 200
//// About to set totalSteps to 200
//// Added 200 steps
//stepCounter.totalSteps = 360
//// About to set totalSteps to 360
//// Added 160 steps
//stepCounter.totalSteps = 896
//// About to set totalSteps to 896
//// Added 536 steps

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}


var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")


player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

let arry = Array(repeating: 0, count: 5)

assert(2<3, "mas de 6")

let pupName: String? = "Alice"
//// Continue only if pupName != nil
//assert(pupName != nil, "pupName variable is nil")
//assert(!(pupName?.isEmpty)!)
//// ** Success: Continuing execution...
//// Continue only if pupName == "Belle"
//
//assert(pupName == "Belle", "Belle?!?! D:")
//
//if (pupName != "Belle") {
//    assertionFailure("I thought this was Belle?")
//}
//// ** Failure: End Execution (But only if we are compiled for Debugging)
//
//
//precondition(pupName == "Belle", "Belle?!?! Precondition")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

matrix

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 99

testScores
