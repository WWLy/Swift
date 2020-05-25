//: [Previous](@previous)

import Foundation

protocol CustomA {
    func run()
    
    func run1()
    
    func run2()
}

extension CustomA {
    func run1() {
        print("run1")
    }
    
    func run2() {
        print("run2")
    }
}

class Person: CustomA {
    
    func run() {
        print("run")
    }
}

extension Person {
    func run1() {
        print("p_run1")
    }
}

let per = Person()
per.run()
per.run1()
per.run2()



enum Season:Int {
    case spring
    case summer
    case autumn
    case winter
}
if let season = Season(rawValue: 3) {
    switch season{
    case .spring:
        print("spring")
    case .summer:
        print("summer")
    case .autumn:
        print("autumn")
    case .winter:
        print("winter")
    }
} else {
    print("凉凉")
}


struct Point {
    var x = 10
    var y = 11
    func show() {
        print("x=\(x), y=\(y)")
    }
}

let p = Point()
p.show()
