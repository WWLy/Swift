import UIKit

var num_1: Int?
print(num_1)

let num_2 = Int("123")
print(num_2)
if num_2 != nil {
    print("转换成功")
} else {
    print("转换失败")
}

// 可选项绑定
if let num_3 = Int("123") {
    print("转换成功: \(num_3)")
} else {
    print("转换失败")
}

let nums_1 = ["10", "20", "abc", "-20", "10"]
var index_1 = 0
var sum_1 = 0
while let num = Int(nums_1[index_1]), num > 0 {
    sum_1 += num
    index_1 += 1
}
print(sum_1)


let a_1: Int? = nil
let b_1: Int? = 2
// 等价于 if a_1 != nil || b_1 != nil
if let c_1 = a_1 ?? b_1 {
    print(c_1)
}

let a_2: Int? = 1
let b_2: Int? = 2
// 等价于 if a_2 != nil && b_2 != nil
if let c_2 = a_2, let d_2 = b_2 {
    print(c_2, d_2)
}


func login(_ info: [String : String]) {
    let username: String
    if let tmp = info["username"] {
        username = tmp
    } else {
        print("请输入用户名")
        return
    }
    
    let password: String
    if let tmp = info["password"] {
        password = tmp
    } else {
        print("请输入密码")
        return
    }
    
    print("用户名: \(username), 密码: \(password)")
}

// guard 后的条件为 false 时执行大括号内容
func login_new(_ info: [String : String]) {
    guard let username = info["username"] else {
        print("请输入用户名")
        return
    }
    
    guard let password = info["password"] else {
        print("请输入密码")
        return
    }
    print("用户名: \(username), 密码: \(password)")
}

login_new(["password" : "123456"])
login(["username" : "jack"])
login(["username" : "jack", "password": "123456"])


// 隐式解包, 如果能确保一直有值
//let num_3: Int? = 3
//let num_4: Int = num_3!
//print(num_4)
let num_3: Int! = 3
let num_4: Int = num_3
print(num_4)

// 多重可选项
let num_5: Int? = 10
let num_6: Int?? = num_5
let num_7: Int?? = 10
print(num_6!!)
