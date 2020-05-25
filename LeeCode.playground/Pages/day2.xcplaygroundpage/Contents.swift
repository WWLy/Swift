//: [Previous](@previous)

import Foundation

/*
 给定一个非空字符串 s，最多删除一个字符。判断是否能成为回文字符串
 */
class Solution {
    func validPalindrome(_ s: String) -> Bool {
        let chars = Array(s)
        var fixed = false

        func validPalindrome(_ left: Int, _ right: Int) -> Bool {
            if left >= right { return true }
            if chars[left] == chars[right] { return validPalindrome(left + 1, right - 1) }
            if fixed { return false }
            fixed = true
            return validPalindrome(left + 1, right) || validPalindrome(left, right - 1)
        }

        return validPalindrome(0, chars.count - 1)
    }
}

Solution().validPalindrome("ab")
