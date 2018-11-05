import UIKit

//1.       10
//        /   \
//       5     14
//      /     /  \
//     1     11  20

//2.
class Node {
    let value : Int
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: Int, leftChild: Node?, rightChild: Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

//left branch
let oneNode = Node(value: 1, leftChild: nil, rightChild: nil)
let fiveNode = Node(value: 10, leftChild: oneNode, rightChild: nil)

//right branch
let elevenNode = Node(value: 11, leftChild: nil, rightChild: nil)
let twenyNode = Node(value: 20, leftChild: nil, rightChild: nil)
let fourteenNode = Node(value: 14, leftChild: elevenNode, rightChild: twenyNode)

let tenRootNode = Node(value: 10, leftChild: fiveNode, rightChild: fourteenNode)

//3.
//Interviewr's question: Implement a search algorithm that searches through this tree for a particular searchValue
func search(node: Node?, searchValue: Int) -> Bool {
    
    if node == nil {
        return false
    }
    
    if node?.value == searchValue {
        return true
    } else if searchValue < node!.value {
        return search(node: node?.leftChild, searchValue: searchValue)
    } else {
        return search(node: node?.rightChild, searchValue: searchValue)
    }
}

search(node: tenRootNode, searchValue: 0)

//4.
//What is the point of all this?

//eficiencia
let list = [1,5,10,11,14,20]
let index = list.index(where: {$0 == 0})
