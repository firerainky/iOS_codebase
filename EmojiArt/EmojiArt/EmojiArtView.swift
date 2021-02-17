//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Zheng Kanyan on 2021/2/8.
//

import UIKit

class EmojiArtView: UIView {
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}
