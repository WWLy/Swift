//: [Previous](@previous)

import Foundation
import UIKit

class Person {
    
}

struct MyError : Error {
    let msg: String
}

enum SomeError : Error {
    case error1(String)
    case error2(Int, Int)
    case error3
}

func tempFunc0(_ a: Int, _ b: Int) throws -> Int? {
    if b == 0 {
//        throw MyError(msg: "除数不能为 0")
        throw SomeError.error1("除数不能为 0")
//        return nil
    }
    return a / b;
}

func tempFunc1(_ a: Int, _ b: Int) throws -> Int? {
    if b == 0 {
//        throw MyError(msg: "除数不能为 0")
        throw SomeError.error2(a, b)
//        return nil
    }
    return a / b;
}

//tempFunc0(num1: 20, num2: 0)

//try tempFunc0(20, 0)

do {
    print("1")
    try tempFunc0(20, 0)
    print("2")
} catch let error as MyError {
    print("3")
    print("MyError: \(error)")
    print("4")
} catch let SomeError.error2(a, b) {
    print(a, b)
} catch let error as SomeError {
    print("0 \(error)")
}

do {
    print("5")
    try tempFunc1(20, 0)
    print("6")
} catch is MyError {
    print("7")
    print("MyError")
    print("8")
} catch let error {
    print("9 \(error)")
}

// try 抛出error之后作用域内的代码都不会再执行

// 可以使用try! try? 来调用函数, 就不用处理error了

func test() {
    print((try? tempFunc0(20, 0) ?? 12) as Any)
}
test()


// rethrows: 函数本身不会抛出错误, 但调用闭包参数抛出错误, 函数会上抛错误
func test1(num1: Int, num2: Int, _ fn: (Int, Int) throws -> Int) rethrows {
    print(try fn(num1, num2))
}

try test1(num1: 10, num2: 1) { (a, b) -> Int in
    return a + b
}

//try test1(num1: 10, num2: 0) { (a, b) -> Int in
//    return a / b
//}


// defer: 用来定义以任何方式离开代码块前必须执行的代码
// defer 语句将延迟到当前作用域结束之前执行
// defer 语句的执行和定义顺序相反


// fatalError: 直接关闭程序, 不能通过 do-catach 捕获
func test2(_ num: Int) -> Int {
    if (num >= 0) {
        return 1
    }
    fatalError("num 不能小于0")
}
test2(0)
