//
//  Toast.swift
//  Buc
//
//  Created by Admin on 3/14/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
class Toast {
    class func toast(_ message: String) {
        JLToast.makeText(message).show()
    }
    
    class func toastDelay(_ message: String, delay: Double) {
        JLToast.makeText(message, delay: delay, duration:JLToastDelay.LongDelay).show()
    }
    
    class func toastDuration(_ message: String) {
        JLToast.makeText(message, duration: JLToastDelay.ShortDelay).show()
    }
}
