//: [Previous](@previous)

import Foundation

var a = 10;
var b = 20;

func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}
swapValues(&a, &b)
print(a, b)

protocol Stackable {
    associatedtype Element : Equatable
}

class Stack<E : Equatable> : Stackable {
    typealias Element = E
}


func equal<S1 : Stackable, S2: Stackable>(_ s1: S1, _ s2: S2) -> Bool
    where S1.Element == S2.Element, S1.Element : Hashable {
        return false
}

var s1 = Stack<Int>()
var s2 = Stack<Int>()
var s3 = Stack<String>()

equal(s1, s2)
//equal(s1, s3)
