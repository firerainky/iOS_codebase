//
//  Test.swift
//  POPDemo
//
//  Created by Zheng Kanyan on 2021/3/10.
//

import Foundation

extension Int {
    func arc4random() -> Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}
