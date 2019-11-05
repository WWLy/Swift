import UIKit

//var _name: String? = "Hello, [playground"
//
//let index = _name?.firstIndex(of: "[") ?? _name?.endIndex
//let temp = _name?[..<index ?? _name?.endIndex]

let temp = ["": "123"]
print(temp.enumerated())

let point = (1, -1)
switch point {
case (_, 1):
    print("1")
case (1, -1):
    print("2")
case (1, _):
    print("3")
default:
    print("0")
}

switch point {
case let (x, 1):
    print(x)
case let (x, -1):
    print(x)
case let (x, y):
    print(x, y)
}


var numbers = [10, 20, 30]
var sum = 0
for num in numbers where num > 0 {
    sum += num
}
print(sum)


outer: for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("i == \(i), k == \(k)")
    }
}

func sum(v1: Int, v2: Int) -> Int {
    // 只有一行表达式的时候可以省略 return
    return v1 + v2
}
sum(v1: 1, v2: 2)

func calculate(v1: Double, v2: Double) -> (sum: Double, difference: Double, average: Double) {
    return (v1 + v2, v1 - v2, (v1 + v2) / 2)
}
let res = calculate(v1: 3, v2: 4)
print(res.average)


//func goToWork(time: String) {
//    print(time)
//}
//goToWork("08:00")

// 可以在形参前面加标签名来使方法更明确, 如果用"_"作为标签名相当于省略形参
func goToWork(at time: String = " ") {
    print(time)
}
goToWork(at: "08:00")


// 可变参数
func sum(numbers: Int...) -> Int {
    var total = 0
    for num in numbers {
        total = num + total;
    }
    return total
}
sum(numbers: 1, 2, 3)

// 输入输出参数, 地址传递
var num = 10
func add(num: inout Int) {
    num += 10
}
add(num: &num)
print(num)

func exchange(v1: inout Int, v2: inout Int) {
    (v1, v2) = (v2, v1)
}
var num1 = 2
var num2 = 3
exchange(v1: &num1, v2: &num2)
print("num1: \(num1), num2: \(num2)")


// 函数
func add(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

func math(add: (Int, Int) -> Int, num1: Int, num2: Int) {
    print(add(num1, num2))
}

math(add: add, num1: 2, num2: 4)


typealias Date = (year: Int, month: Int, day: Int)
func testDate(_ date: Date) {
    print(date.0)
    print(date.year)
}
testDate((2019, 10, 10))


func forward(_ forward: Bool) -> (Int) -> Int {
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    return forward ? next : previous
}
forward(true)(3)
forward(false)(3)


// 枚举

//enum Direction {
//    case north
//    case sourth
//    case east
//    case west
//}

enum Direction: Int {
    case north, sourth, east, west
}
var temp1 = Direction.north
temp1 = .sourth
temp1.rawValue


enum Date1 {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}
var date = Date1.digit(year: 2020, month: 10, day: 10)
date = .string("2020-10-10")
switch date {
case let .digit(year, month, day):
    print(year, month, day)
case let .string(value):
    print(value)
}


enum Password {
    case number(Int, Int, Int, Int)
    case other
}
var pwd = Password.number(2, 4, 4, 1)
MemoryLayout.size(ofValue: pwd)
MemoryLayout.size(ofValue: Password.other)
MemoryLayout<Password>.size
MemoryLayout<Password>.stride
MemoryLayout<Password>.alignment
/**
 枚举类型如果没有关联值, 则只占用 1 个字节
 如果有关联值, 则占用 占用内存最大的关联值 + 存储成员值的 1 个字节 + 内存对齐所需的额外字节
 */

