//
//  String+Extension.swift
//  EmojiArt
//
//  Created by Zheng Kanyan on 2021/2/17.
//

import Foundation

extension String {
    func madeUnique(to names: [String]) -> String {
        var index = 1
        var currentName = self + String(index)
        while names.contains(currentName) {
            index += 1
            currentName = self + String(index)
        }
        return currentName
    }
}
