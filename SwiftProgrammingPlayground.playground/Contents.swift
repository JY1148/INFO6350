import UIKit

var greeting = "Hello, playground"
greeting = "Hello, Ashish"
print(greeting)

//Basic Data Types
let intValue = 5
let doubleVal : Double = 5.0
let str : String = "Hello I am a string"
let boolValue : Bool = true

// Multiple variables at same time + optional
var x,y,z : Int?

var optionalInt : Int?

let 🙏 = "Namaste"
print(🙏)
let name = "Ashish"
print("Hello \(name)")

print("Int minimum value = \(UInt64.max)")
print("Int maximum value = \(Int.max)")

var doubleMaxInt : Double = 9223372036854775807
doubleMaxInt = doubleMaxInt * 2
print(doubleMaxInt)

let binaryVal = 0b0111
print(binaryVal)
let octalVal = 0o237
let hexaVal = 0xE
print(hexaVal)
print(octalVal)

//Tuple values (Key value)
let tupleValue = (404, "Not Found")
print(tupleValue.0)
print(tupleValue.1)

let (id, status) = (200, "OK")
print(id)
print(status)

let tripleValue = (234, "Abcd", true)
print(tripleValue.0)
print(tripleValue.1)
print(tripleValue.2)

//Optionals
var strName : String?

//strName = "Ashish"

//print(strName!)

if strName != nil {
    print(strName!)
}

if let name = strName{
    print(name)
}

var iValue : Int?

func sampleFunctionForGuard(strVal : String?){
    
    guard let name = strName else {return}
    
    print(name)
}
