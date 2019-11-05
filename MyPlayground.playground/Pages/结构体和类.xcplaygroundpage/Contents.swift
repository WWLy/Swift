//: [Previous](@previous)

import Foundation

struct Point {
    var x = 10
    var y = 11
    func show() {
        print("x=\(x), y=\(y)")
    }
}

let p = Point()
p.show()
