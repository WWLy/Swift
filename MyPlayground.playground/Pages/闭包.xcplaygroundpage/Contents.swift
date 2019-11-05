import Foundation

// 闭包可以定义函数
func sum(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}

var fn = {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
}
fn(10, 20)

var fn2 = {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
}(10, 20)
print(fn2)


// 闭包表达式的简写
func exec(v1: Int, v2: Int, fn:(Int, Int) -> Int) {
    print(fn(v1, v2))
}

exec(v1: 10, v2: 20, fn: {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
})

// 编译器智能推断类型
exec(v1: 10, v2: 20, fn: {
    v1, v2 in return v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    v1, v2 in v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    $0 + $1
})

exec(v1: 10, v2: 20, fn: +)


// 尾随闭包
exec(v1: 10, v2: 20) {
    v1, v2 in v1 + v2
}


var arr = [10, 1, 29, 16, 99]
arr.sort()
print(arr)

func cmp(i1: Int, i2: Int) -> Bool {
    return i1 > i2
}

arr.sort(by: cmp)
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort(by: {
    (i1: Int, i2: Int) in return i1 > i2
})
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort(by: {
    i1, i2 in return i1 > i2
})
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort(by: {
    i1, i2 in i1 > i2
})
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort(by: {
    $0 > $1
})
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort(by: >)
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort() {$0 > $1}
print(arr)

arr = [10, 1, 29, 16, 99]
arr.sort {$0 > $1}
print(arr)

// 闭包内存在堆空间
// 闭包会捕获外层的局部变量/常量, 拷贝一份到堆空间
// plus 和 minus 访问的是相同的堆空间, 只捕获一次
typealias Fn = (Int) -> (Int, Int)
func getFns() -> (Fn, Fn) {
    var num1 = 0
    var num2 = 0
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1, num2)
    }
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1, num2)
    }
    return (plus, minus)
}

let (p, m) = getFns()
print(p(1))
print(m(1))
print(p(3))
print(m(2))


func getFirstPosition(_ n1: Int, _ n2: Int) -> Int {
    return n1 > 0 ? n1 : n2
}

func getFirstPosition1(_ n1: Int, _ n2: () -> Int) -> Int {
    return n1 > 0 ? n1 : n2()
}
getFirstPosition1(10, { 20 })
// 自动闭包 @autoclosure, 只支持无参类型, 会自动封装为闭包
func getFirstPosition2(_ n1: Int, _ n2: @autoclosure() -> Int) -> Int {
    return n1 > 0 ? n1 : n2()
}
getFirstPosition2(10, 20)
