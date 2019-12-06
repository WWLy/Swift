//: [Previous](@previous)

import Foundation

// 初始化器: 分为指定初始化器 和 便捷初始化器
// 类 结构体和枚举都可以设置初始化器
// 每个类至少要有一个指定初始化器, 一般只有一个指定初始化器, 另外的用便捷初始化器
// 默认初始化器是类的指定初始化器

// 便捷初始化器最终需要调用自己的指定初始化器
// 指定初始化器需要调用父类的初始化器, 不能调用自身的指定初始化器

class Person {
    var age: Int
    var name: String
    init(age: Int) {
        self.age = age
        self.name = ""
    }
    convenience init() {
        self.init(age: 0)
    }
    convenience init(name: String) {
        self.init()
        self.name = name;
    }
}

class Student: Person {
    var score: Int
    
    init(age: Int, score: Int) {
        // 需要先初始化自己的属性 再调用父类的初始化器
        self.score = age
        super.init(age: age)
//        super.init()
        
        self.score = 11
    }
    
    convenience init() {
        self.init(age: 0, score: 0)
    }
}

var stu = Student()
print(stu.score)


// 整个过程分为两部分: 1. 确保初始化所有属性  2. 安全检查

// 子类如果没有自定义指定初始化器, 会自动继承父类的指定初始化器
// 如果子类提供了父类的所有指定初始化器的实现(可以是继承, 也可以是重写), 就可以使用父类的便捷初始化器
class Teacher: Person {
    convenience init() {
        self.init(age: 0)
    }
}

var tea1 = Teacher(name: "Jack")
print(tea1.name)


// 如果用 required 修饰, 则所有子类也必须实现, 并用 required 修饰, 不需要 override


// 可失败初始化器 init?
class Person1 {
    var name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        } else {
            self.name = name
        }
    }
    // deinit 反初始化器, 不接收参数, 类似 dealloc
    deinit {
        
    }
}


var p1: Person1.Type = Person1.self
p1.self
var p2 = Person()
type(of: p2) == Person.self
