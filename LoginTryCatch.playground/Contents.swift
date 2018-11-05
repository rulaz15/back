import UIKit

var email = "correo@dominio.com"
var password = "hello"

enum LoginError : Error {
    case incompleteForm
    case invalidEmail
    case invalidPassword
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}



func login() throws {
    
    if (email.isEmpty) || (password.isEmpty) {
        throw LoginError.incompleteForm
    }
    
    if !isValidEmail(testStr: email) {
        throw LoginError.invalidEmail
    }
    
    if password.count < 4 {
        throw LoginError.invalidPassword
    }
    
//    //Todo bien
//    oki()
}

func oki() {
    print("oktl!!")
}

func dotry(){
    do {
        try login()
        
        //Todo bien
        oki()
        
    } catch LoginError.incompleteForm {
        print("campos vacios")
    } catch LoginError.invalidEmail {
        print("correo mal")
    } catch LoginError.invalidPassword {
        print("contraseña mal")
    } catch {
        print("idk")
    }
}

dotry()

var decimalBase = 1
for _ in 0..<8 {
    decimalBase *= 10
}

decimalBase
