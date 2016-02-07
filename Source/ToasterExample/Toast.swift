//
//  Toast.swift
//
//  Created by @cocotutch on 31/01/2016.
//  Copyright © 2016 @cocotutch. All rights reserved.
//
//  Made with love in Melbourne, Australia.
//

import Foundation
import UIKit

class Toast: UIView {
    private let screenSize: CGRect = UIScreen.mainScreen().bounds
    private let keyWindow: UIWindow = UIApplication.sharedApplication().keyWindow!
    private var label: ToastTextLabel?
    private var iconImageView: UIImageView?
    private var messageText: String?
    private var animated: Bool? = true
    private var timer: NSTimer? = nil
    
    // I can only do so much!
    private var toastIcon: ToastIcon? = .Bang
    private var duration: ToastDuration? = .Short
    private var gravity: ToastGravity? = .Top
    private var severity: ToastSeverity? = .Info
    private var style: ToastStyle? = .Brief
    
    var code: Int = 53 // IMPORTANT!
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(withDuration duration: ToastDuration, gravity: ToastGravity, severity: ToastSeverity, style: ToastStyle, message: String? = nil, code: Int, animated: Bool) {
        super.init(frame: .zero)
        
        self.duration = duration
        self.gravity = gravity
        self.severity = severity
        self.messageText = message
        self.style = style
        self.animated = animated
        self.code = code
        
        setup()
    }
    
    init(severity: ToastSeverity, message: String? = nil, code: Int, animated: Bool) {
        super.init(frame: .zero)
        
        self.duration = .Short
        self.gravity = .Top
        self.severity = severity
        self.messageText = message
        self.animated = animated
        self.code = code
        
        setup()
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("These objects cannot be used with Interface Builder.")
    }
    
    private func setup() {
        frame = getStyle()
        backgroundColor = getSeverity()
        getImageView()
        getLabel()
    }
    
    private func getImageView() {
        iconImageView = UIImageView(frame: CGRect(x: 5.0, y: 0.0, width: 40.0, height: 40.0))
        iconImageView?.center = CGPointMake(iconImageView!.center.x, frame.size.height/2)
        iconImageView?.image = getIcon()
        iconImageView?.layer.magnificationFilter = kCAFilterNearest
        addSubview(iconImageView!)
    }
    
    private func getLabel() {
        guard let iconImageView = iconImageView else { return }
        
        label = ToastTextLabel(frame: CGRect(x: iconImageView.frame.origin.x+iconImageView.frame.size.width+5, y: 0.0, width: screenSize.size.width-((iconImageView.frame.size.width)+20), height: getStyle().size.height))
        label?.backgroundColor = UIColor.clearColor()
        label?.font = UIFont.boldSystemFontOfSize(14)
        label?.textColor = getSeverity() == UIColor.whiteColor() ? UIColor.blackColor() : UIColor.whiteColor()
        label?.text = messageText
        label?.numberOfLines = getStyle().size.height > round(screenSize.height/14.0) ? 0 : 2
        label?.sizeToFit()
        label?.center = CGPointMake(label!.center.x, frame.size.height/2)
        
        addSubview(label!)
    }
    
    private func getDuration() -> Double {
        switch duration! {
        case .Short:
            return 2.0 // SEC
        case .Normal:
            return 5.0
        case .Long:
            return 10.0
        }
    }
    
    private func getGravity() -> CGFloat {
        switch gravity! {
        case .Top:
            return screenSize.origin.y+UIApplication.sharedApplication().statusBarFrame.size.height // Y
        case .Bottom:
            return screenSize.height-getStyle().size.height
        }
    }
    
    private func getStyle() -> CGRect {
        var rect: CGRect = .zero
        switch style! {
            case .Brief:
                rect.size.height = round(screenSize.height/12.0)
        }
        
        rect.size.width = screenSize.width
        
        return rect
    }
    
    private func getSeverity() -> UIColor {
        let divisor: CGFloat = 255.0
        switch severity! {
        case .Info:
            return UIColor.whiteColor()
        case .Warning:
            return UIColor(red: 255.0/divisor, green: 210.0/divisor, blue: 0.0/divisor, alpha: 1.0)
        case .Error:
            return UIColor(red: 255.0/divisor, green: 148.0/divisor, blue: 148.0/divisor, alpha: 1.0)
        }
    }
    
    private func getIcon() -> UIImage? {
        switch severity! {
        case .Warning:
            return UIImage(named: "triangle_bang.png")
        case .Error:
            return UIImage(named: "triangle_bang.png")
        case .Info:
            return UIImage(named: "toast_generic.png")
        }
    }
    
    deinit {
        iconImageView = nil
        label = nil
        timer = nil
        messageText = nil
    }
}

extension Toast {
    func show() {        
        frame.origin.y = gravity == .Top ? -(frame.size.height * 3) : screenSize.size.height+(3 * frame.size.height)
        keyWindow.addSubview(self)
        
        print(iconImageView?.image)
        
        if animated == true {
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { [weak self] in
                guard let weakSelf = self else { fatalError("No Self!") }
                weakSelf.frame.origin.y = weakSelf.getGravity()
                }, completion: { [weak self] finished in
                    guard let weakSelf = self else { fatalError() }
                    weakSelf.timer = NSTimer(timeInterval: weakSelf.getDuration(), target: weakSelf, selector: "hide", userInfo: nil, repeats: false)
                    
                    if let timer = weakSelf.timer {
                        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
                    }
            })
        } else {
            frame.origin.y = getGravity()
            
            timer = NSTimer(timeInterval: getDuration(), target: self, selector: "hide", userInfo: nil, repeats: false)
            
            if let timer = timer {
                NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
            }
        }
    }
    
    func hide() {
        guard let timer = timer else { return }
        timer.invalidate()
        
        if animated == true {
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { [weak self] in
                guard let weakSelf = self else { fatalError("No self!") }
                weakSelf.frame.origin.y = weakSelf.gravity == .Top ? -(weakSelf.frame.size.height * 3) : weakSelf.screenSize.size.height
                }, completion: { [weak self] finished in
                    self?.removeFromSuperview()
            })
        } else {
            removeFromSuperview()
        }
    }
}