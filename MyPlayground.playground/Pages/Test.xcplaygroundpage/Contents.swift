//: [Previous](@previous)

import Foundation

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var i = 0
        for num in nums {
            if num == target {
                return i
            }
            i += 1
        }
        return -1
    }
}

let s = Solution()
let nums = [4,5,6,7,0,1,2]
let target = 0
s.search(nums, target)
