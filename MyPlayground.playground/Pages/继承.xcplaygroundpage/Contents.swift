//: [Previous](@previous)

import Foundation

class Animal {
    func speak() {
        
    }
    subscript(index: Int) -> Int {
        return index
    }
}

class Cat : Animal {
    override func speak() {
        
    }
}

// 被 class 修饰的类型方法和下标, 允许被子类重写
// 被 static 修饰的类型方法和下标, 不允许被子类重写

// 重写实例属性:
// 子类可以重写父类的属性为计算属性
// 子类不可以重写父类的属性为存储属性
// 只能重写 var, 不能重写 let
// 子类重写后的属性权限(读写权限)不能小于父类的重写权限
// 从父类继承来的存储属性都会分配内存空间, 需要使用 super 关键字访问

class Circle {
    var radius: Int = 0
    var diameter: Int {
        set {
            print("Circle set diameter")
            radius = newValue / 2
        }
        get {
            print("Circle get diameter")
            return radius * 2
        }
    }
}

class SubCircle : Circle {
    override var radius: Int {
        set {
            print("SubCircle set radius")
            super.radius = newValue
        }
        get {
            print("SubCircle get radius")
            return super.radius
        }
    }
    override var diameter: Int {
        set {
            print("SubCircle set diameter")
            super.diameter = newValue
        }
        get {
            print("SubCircle get diameter")
            return super.diameter
        }
    }
}

var subCircle = SubCircle()
subCircle.radius = 2
print(subCircle.diameter)


// 重写类型属性:
class Circle1 {
    class var radius: Int {
        set {
            print("Circle setRaius", newValue)
        }
        get {
            print("Circle getRadius")
            return 20
        }
    }
}

class SubCircle1 : Circle1 {
    override static var radius: Int {
        willSet {
            print("SubCircle willSetRadius", newValue)
        }
        didSet {
            print("SubCircle didSetRadius", oldValue, radius)
        }
    }
}
SubCircle1.radius = 11
