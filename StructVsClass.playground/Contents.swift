import UIKit

class HumanClass {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var humanClassObject = HumanClass(name: "yon")
humanClassObject.name

let newHumanClassObject = humanClassObject

humanClassObject.name = "yoni"
newHumanClassObject.name

struct HumanStruct {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var structObject = HumanStruct(name: "Yon")
let newStructObject = structObject

structObject.name = "Yoni"
newStructObject.name


