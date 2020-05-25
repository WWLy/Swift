//: [Previous](@previous)

import Foundation

// 方法分为实例方法和类型方法
// 类型方法用 class 或 static 修饰, 通过类型调用
class Car {
    static var count = 0
    
    init() {
        Car.count += 1
    }
    
    class func getCount() -> Int {
        return self.count
    }
}

// mutating, 值类型中实例方法修改属性需要增加 mutating
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    // @discardableResult 可以消除函数调用后返回值未被使用的警告
    @discardableResult func getX() -> Double {
        return x
    }
}

var p = Point()
p.moveBy(deltaX: 1.0, deltaY: 1.0)
p.getX()


// subscript 下标, 可以给任意类型(枚举, 结构体, 类)增加下标
// 语法类似计算属性, 本质就是方法
// 可以接收多个参数, 并且任意类型
class Point1 {
    var x = 0.0, y = 0.0
    subscript(index: Int) -> Double {
        set {
            if index == 0 {
                x = newValue
            } else if index == 1 {
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
}

var p1 = Point1()
p1[0] = 11.1
p1[1] = 22.2
print(p1.x, p1.y)


struct Student: Comparable {
    static func < (lhs: Student, rhs: Student) -> Bool {
        return true
    }
    
    var age: Int
    static func ask() {
        print("ask")
    }
}

let s1 = Student(age: 18)
Student.ask()

