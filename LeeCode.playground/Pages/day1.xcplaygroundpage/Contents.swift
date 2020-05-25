import UIKit

/*
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。
 */

class Solution_0 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let count = nums.count
        var allCount = 0
        for i in 0..<(count-1) {
            let num1 = nums[i]
            for j in (i+1)..<(count) {
                allCount += 1
                let num2 = nums[j]
                if num1 + num2 == target {
                    print(allCount)
                    return [i, j]
                }
            }
        }
        print(allCount)
        return [0, 0]
    }
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        let count = nums.count
        var dict: [Int : Int] = [:]
        var allCount = 0
        for i in 0..<(count) {
            allCount += 1
            let num = nums[i]
            let temp = target - num
            if dict[num] != nil {
                print(allCount)
                return [dict[num]!, i]
            }
            dict[temp] = i
        }
        print(allCount)
        return [0, 0]
    }
}

Solution_0().twoSum([2, 7, 11, 15], 26)
Solution_0().twoSum1([2, 7, 11, 15], 26)


/*
 给你一个整数数组 nums
 请你找出数组中乘积最大的连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。
 */
class Solution_1 {
    func maxProduct(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var allValue = nums[0]
        
        let count = nums.count
        
        // 全是正数 直接相乘
        // 全是负数, 判断负数数量, 偶数则直接相乘, 奇数 1 直接返回, 3 及以上取 0..<(count-1) 和 1..<count 中的大者
        // 正负混合, 判断负数数量, 偶数则直接相乘, 奇数 1 则左右分割取大者, 3 及以上则根据负数分割, 取 (数量 - 1) 个值中的最大者
        // 全是 0 返回 0
        // 若包含 0, 则根据 0 分割, 计算区间的最大值, 若都 < 0, 则返回 0
        
        // 0 的数量
        var count_0 = 0
        // 负数的数量
        var count_1 = 0
        
        var start_1 = -1
        var end_1 = -1
        
        for i in 0..<count {
            let num = nums[i]
            if num == 0 {
                count_0 += 1
            } else if num < 0 {
                count_1 += 1
                if start_1 == -1 {
                    start_1 = i
                }
                end_1 = i
            }
        }
        
        var res: (Int, Int, Int) = (0, 0 , 0)
        
        // 全是正数
        if count_0 == 0 && count_1 == 0 {
            for i in 1..<count {
                let num = nums[i]
                allValue = allValue * num
            }
            res = (0, count-1, allValue)
        }
        // 全是负数
        else if (count_0 == 0 && count_1 == count) {
            if count_1 % 2 == 0 {
                for i in 1..<count {
                    let num = nums[i]
                    allValue = allValue * num
                }
                res = (0, count-1, allValue)
            } else {
                if count == 1 {
                    res = (0, count, allValue)
                } else {
                    var temp1 = nums[0]
                    var temp2 = nums[1]
                    for i in 1..<(count-1) {
                        let num1 = nums[i]
                        let num2 = nums[i+1]
                        temp1 = temp1 * num1
                        temp2 = temp2 * num2
                    }
                    if temp1 >= temp2 {
                        allValue = temp1
                        res = (0, count-2, allValue)
                    } else {
                        allValue = temp2
                        res = (1, count-1, allValue)
                    }
                }
            }
        }
        // 正负混合
        else if (count_0 == 0) {
            // 负数个数为偶数
            if (count_1 % 2 == 0) {
                for i in 1..<count {
                    let num = nums[i]
                    allValue = allValue * num
                }
                res = (0, count-1, allValue)
            } else if count_1 == 1 {
                var start = 0
                var tempNums: [Int] = []
                for i in 0..<count {
                    let num = nums[i]
                    if num > 0 {
                        tempNums.append(num)
                    } else {
                        let tempNum = maxProduct(tempNums)
                        if allValue < tempNum {
                            allValue = tempNum
                            res = (start, i, allValue)
                        }
                        tempNums = []
                        start = i + 1
                    }
                    if i == count-1 && tempNums.count > 0 {
                        let tempNum = maxProduct(tempNums)
                        if allValue < tempNum {
                            allValue = tempNum
                            res = (start, i, allValue)
                        }
                    }
                }
            } else {
                var temp1 = 0
                var temp2 = 0
                var temp3 = 0
                var temp4 = 0
                print(start_1, end_1)
                for i in 0..<count {
                    let num = nums[i]
                    if i == 0 {
                        temp1 = num
                    } else if i < start_1 {
                        temp1 = temp1 * num
                    }
                    
                    if i == (start_1 + 1) {
                        temp2 = num
                    } else if i > (start_1 + 1) {
                        temp2 = temp2 * num
                    }
                    
                    if i == 0 {
                        temp3 = num
                    } else if i < end_1 {
                        temp3 = temp3 * num
                    }
                    
                    if i == (end_1 + 1) {
                        temp4 = num
                    } else if i > (end_1 + 1) {
                        temp4 = temp4 * num
                    }
                }
                print(temp1, temp2, temp3, temp4)
                if temp1 > temp2 && temp1 > temp3 && temp1 > temp4 {
                    allValue = temp1
                    res = (0, start_1-1, allValue)
                } else if temp2 > temp3 && temp2 > temp4 {
                    allValue = temp2
                    res = (start_1+1, count-1, allValue)
                } else if temp3 > temp4 {
                    allValue = temp3
                    res = (0, end_1-1, allValue)
                } else {
                    allValue = temp4
                    res = (end_1+1, count-1, allValue)
                }
            }
        }
        // 全是 0
        else if (count_0 == count) {
            res = (0, 0, 0)
        }
        // 包含 0
        else if (count_0 > 0) {
            var tempNums: [Int] = []
            var start = 0
            for i in 0..<count {
                let num = nums[i]
                if num != 0 {
                    tempNums.append(num)
                } else {
                    let tempNum = maxProduct(tempNums)
                    if allValue < tempNum && tempNum > 0 {
                        allValue = tempNum
                        res = (start, i, allValue)
                    } else if allValue < 0 {
                        allValue = 0
                        res = (start, i, 0)
                    }
                    start = i + 1
                    tempNums = []
                }
                if i == count-1 && tempNums.count > 0 {
                    let tempNum = maxProduct(tempNums)
                    if allValue < tempNum && tempNum > 0 {
                        allValue = tempNum
                        res = (start, i, allValue)
                    } else if allValue < 0 {
                        allValue = 0
                        res = (start, i, 0)
                    }
                }
            }
        }
        print(res)
        return allValue
    }
    
    func maxProduct1(_ nums: [Int]) -> Int {
        if nums.count <= 0 {
            return 0
        }

        var maxValue = Int.min

        var imax = 1
        var imin = 1

        for i in 0..<nums.count {
            let value = nums[i]
            if value < 0 { //如果当前是负数, 大小 转换一下, min的乘积肯定会比max大
                let tmp = imax
                imax = imin
                imin = tmp
            }
            imax = max(imax * value, value) //如果是0的情况 累计和当前值比 当前值大
            imin = min(imin * value, value)
            maxValue = max(maxValue, imax) //比较当前计算最大值和上次的最大值
        }

        return maxValue
    }
}

Solution_1().maxProduct1([0, -2, -1])
