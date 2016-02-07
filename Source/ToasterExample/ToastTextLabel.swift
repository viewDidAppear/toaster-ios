//
//  ToastTextLabel.swift
//  Muzik7
//
//  Created by Ben Deckys on 7/02/2016.
//  Copyright © 2016 Ben Deckys. All rights reserved.
//

import Foundation
import UIKit

class ToastTextLabel : UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftInset = 5
        rightInset = 5
        topInset = 5
        bottomInset = 5
    }
    
    @IBInspectable var topInset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var leftInset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var bottomInset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var rightInset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)))
    }
    
    override func intrinsicContentSize() -> CGSize {
        var parentSize: CGSize = super.intrinsicContentSize()
        parentSize.width += leftInset+rightInset
        parentSize.height += topInset+bottomInset
        return parentSize
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var parentSize: CGSize = super.sizeThatFits(size)
        parentSize.width += leftInset+rightInset
        parentSize.height += topInset+bottomInset
        return parentSize
    }
    
}