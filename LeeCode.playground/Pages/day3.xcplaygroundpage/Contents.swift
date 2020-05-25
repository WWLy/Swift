//: [Previous](@previous)

import Foundation

/*
 给你一个字符串 s ，请你返回满足以下条件的最长子字符串的长度：每个元音字母，即 'a'，'e'，'i'，'o'，'u' ，在子字符串中都恰好出现了偶数次
 
 输入：s = "leetcodeisgreat"
 输出：5
 解释：最长子字符串是 "leetc" ，其中包含 2 个 e
 */

class Solution {
    let map: [Character:Int] = ["a":0,"e": 1,"i":2,"o":3,"u":4]
    func findTheLongestSubstring(_ s: String) -> Int {
        var maxLength = 0
        var firstIndexOfCounter = [Int8:Int]()
        var counter: Int8 = 0
        firstIndexOfCounter[0] = -1
        var i = 0
        for ch in s {
            
            if let index = map[ch] {
                counter ^= (1 << index)
            }
            if let first =  firstIndexOfCounter[counter] {
                maxLength = max(maxLength, i - first)
            } else {
                firstIndexOfCounter[counter] = i
            }
            i += 1
        }
        return maxLength
    }
}

Solution().findTheLongestSubstring("aasssssssssssss")
