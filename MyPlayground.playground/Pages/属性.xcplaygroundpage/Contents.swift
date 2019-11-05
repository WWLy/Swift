//: [Previous](@previous)

import UIKit

// 属性分为存储属性和计算属性

// 存储属性类似成员变量
// 结构体和类可以定义存储属性, 枚举不可以, 因为枚举只占用 1 个字节, 只保存了 case
struct Point {
    var x: Float
    var y: Float
}
var p = Point(x: 10, y: 14)
MemoryLayout.stride(ofValue: p)

// 计算属性本质就是方法, 不占用实例的内存
struct Circle {
    // 存储属性
    var radius: Double
    // 计算属性
    var diameter: Double {
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
}
var c = Circle(radius: 10)
print(c.diameter)
c.diameter = 30
print(c.radius)
MemoryLayout.stride(ofValue: c)


// 在创建 结构体或者类 实例的时候, 必须为所有的存储属性设置一个初始值
// 1. 可以在初始化器中设置初始值
// 2. 可以在定义属性的时候设置初始值

// 只读计算属性: 只有 get, 没有 set
struct Circle1 {
    // 存储属性
    let radius: Double
    // 计算属性, 只能用 var, 不能用 let
    var diameter: Double {
        get {
            radius * 2
        }
    }
    // 简写
    var diameter1: Double { radius * 2 }
}

// 枚举原始值 rawValue 的本质就是只读计算属性
enum Season: Int {
    case spring = 1, summer, autumn, winter
    
    var rawValue: Int {
        switch self {
            case .spring:
                return 11
            case .summer:
                return 22
            case .autumn:
                return 33
            case .winter:
                return 44
        }
    }
}

var s = Season.summer
print(s.rawValue)


// 延迟存储属性 lazy, 第一次用到的时候才会初始化
// 必须是 var, 因为 let 声明的属性必须在实例初始化完成之前赋值
// 线程不安全, 多线程访问不能保证只初始化一次
class Car {
    init() {
        print("Car init")
    }
    func run() {
        print("Car is running")
    }
}

class Person1 {
    lazy var car = Car()
    init() {
        print("Person init")
    }
    func goOut() {
        car.run()
    }
}

let p1 = Person1()
p1.goOut()


func getMoney() -> Int {
    return 10 + 20
}
class Person2 {
    lazy var money: Int = getMoney()
    // 延迟属性 + 闭包表达式, 与 money 属性定义一致
    lazy var money1: Int = {
        return 10 + 20
    }()
}

print("--------------")

// 属性观察器, 只能给 lazy var 的存储属性添加属性观察器
// 在初始化器中赋值不会触发
struct Circle2 {
    var radius: Double = 1.0 {
        willSet {
            print("willSet", newValue)
        }
        didSet {
            print("didSet", oldValue, radius)
        }
    }
    init() {
        self.radius = 10
        print("Circle init")
    }
}
var c2 = Circle2()
c2.radius = 20


// 计算属性和属性观察器都可以用在全局变量和局部变量上

// inout 本质: 引用传递 (地址传递)
// 1. 如果实参有物理内存地址, 且没有设置属性观察器,
// 则直接将实参的内存地址传入函数进行修改 (实参进行引用传递)
// 2. 如果实参是计算属性 或 设置了属性观察器,
// 则采用 Copy In Copy Out 的做法, 先复制实参的值, 产生副本(创建临时局部变量) -- get
// 将副本的内存地址传入函数 (副本进行引用传递), 在函数内部修改副本的值
// 函数返回后, 再将副本的值传给实参, 覆盖实参的值
