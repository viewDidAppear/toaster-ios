//
//  Toaster.swift
//
//  Created by @cocotutch on 31/01/2016.
//  Copyright © 2016 @cocotutch. All rights reserved.
//
//  Made with love in Melbourne, Australia.
//

import Foundation
import UIKit

struct Toaster {
    static var sharedInstance = Toaster()
    private var toastsArray: [Toast] = []
    
    private init() {}
    
    func getToasts() -> [Toast] {
        return toastsArray
    }
    
    mutating func load(withToasts toasts: [Toast]) {
        for (_, toast) in toasts.enumerate() {
            toastsArray.append(toast)
        }
    }
    
    func popToast(withDuration duration: ToastDuration, gravity: ToastGravity, severity: ToastSeverity, style: ToastStyle, message: String?, code: Int, animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            let toast = Toast(withDuration: duration, gravity: gravity, severity: severity, style: style, message: message, code: code, animated: animated)
            toast.show()
        })
    }
    
    func pop(withErrorCode code: Int) {
        dispatch_async(dispatch_get_main_queue(), {
            
            for (_, object) in self.toastsArray.enumerate() {
                if let toast = object as? Toast {
                    if toast.code == code {
                        toast.show()
                    }
                }
            }
        })
    }
}

protocol Slot {
    func popToast(withDuration duration: ToastDuration, gravity: ToastGravity, severity: ToastSeverity, style: ToastStyle, message: String?, code: Int, animated: Bool)
    func pop(withErrorCode code: Int)
}

extension UIViewController: Slot {
    func popToast(withDuration duration: ToastDuration, gravity: ToastGravity, severity: ToastSeverity, style: ToastStyle, message: String?, code: Int, animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            let toast = Toast(withDuration: duration, gravity: gravity, severity: severity, style: style, message: message, code: code, animated: animated)
            toast.show()
        })
    }
    
    func pop(withErrorCode code: Int) {
        dispatch_async(dispatch_get_main_queue(), {
            let toasts = Toaster.sharedInstance.getToasts()
            
            for (_, object) in toasts.enumerate() {
                if let toast = object as? Toast {
                    if toast.code == code {
                        toast.show()
                    }
                }
            }
        })
    }
}

enum ToastIcon {
    case Bang // Errors and warnings
    case Intero // You really should end this style with a '?' mark.
    case General // General statements
}

enum ToastGravity {
    case Top
    case Bottom
}

enum ToastSeverity {
    case Warning
    case Error
    case Info
}

enum ToastDuration {
    case Short
    case Normal
    case Long
}

enum ToastStyle {
    case Brief // Expand this to add bigger styles. I've kept it small because that's all I needed!
}