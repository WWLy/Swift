//: [Previous](@previous)

import Foundation

// 属性分为存储属性和计算属性

// 存储属性类似成员变量
// 结构体和类可以定义存储属性, 枚举不可以, 因为枚举只占用 1 个字节, 只保存了 case
struct Point {
    var x: Float
    var y: Float
}
var p = Point(x: 10, y: 14)
MemoryLayout.stride(ofValue: p)

// 计算属性本质就是方法
