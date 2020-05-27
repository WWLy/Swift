//: [Previous](@previous)

import Foundation

/*
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
 
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        var cur = ListNode(0)
        let pre = cur
        var temp = 0
        while (l1 != nil || l2 != nil) {
            let x = l1?.val ?? 0
            let y = l2?.val ?? 0
            var sum = x + y + temp
            temp = sum / 10
            sum = sum % 10
            cur.next = ListNode(sum)
            
            cur = cur.next!
            if l1 != nil {
                l1 = l1!.next
            }
            if l2 != nil {
                l2 = l2!.next
            }
        }
        if temp == 1 {
            cur.next = ListNode(temp)
        }
        return pre.next
    }
}

let l1 = ListNode(2)
let l2 = ListNode(4)
let l3 = ListNode(3)
l1.next = l2
l2.next = l3

let l10 = ListNode(5)
let l11 = ListNode(6)
let l12 = ListNode(4)
l10.next = l11
l11.next = l12


let res = Solution().addTwoNumbers(l1, l10)

