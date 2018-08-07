//
//  MyColor.swift
//  Buc
//
//  Created by Admin on 3/21/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class MyColor: UIColor {
    
    class func customYellowColor() -> UIColor {
        return UIColor(red: 229.0/255.0, green: 163.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    }
    
    class func customLightYellowColor() -> UIColor {
        return UIColor(red: 252.0/255.0, green: 182.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    }
    class func customGreenColor() -> UIColor {
        return UIColor(red: 85.0/255.0, green: 238.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    }
    
    class func customRedColor() -> UIColor {
        return UIColor(red: 176.0/255.0, green: 0.0/255.0, blue: 9.0/255.0, alpha: 1.0)
    }
    
    class func customBlueColor() -> UIColor {
        return UIColor(red: 37.0/255.0, green: 141.0/255.0, blue: 193.0/255.0, alpha: 1.0)
    }
    
    class func lyftPinkColor() -> UIColor {
        return UIColor(red: 225.0 / 255.0, green: 0.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0)
    }
    
    class func lyftGrayColor() -> UIColor {
        return UIColor(red: 51.0/255.0, green: 61.0/255.0, blue: 71.0/255.0, alpha: 1.0)
    }
    class func customGenColor() ->UIColor {
        return UIColor(red: 202.0 / 255.0, green: 0.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
    }
    class func lyftLightGrayColor() -> UIColor {
        return UIColor(red: 77.0/255.0, green: 94.0/255.0, blue: 107.0/255.0, alpha: 1.0)
    }
    
    class func matrixRedColor() -> UIColor {
        return UIColor(red: 183.0/255.0, green: 56.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    
    class func matrixBlueColor() -> UIColor {
        return UIColor(red: 67.0/255.0, green: 106.0/255.0, blue: 174.0/255.0, alpha: 1.0)
    }
    
    class func matrixGreenColor() -> UIColor {
        return UIColor(red: 139.0/255.0, green: 177.0/255.0, blue: 69.0/255.0, alpha: 1.0)
    }
    class func matrixOrangeColor() -> UIColor {
        return UIColor(red: 236.0/255.0, green: 133.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    }
    class func customBorderColor() -> UIColor {
        return UIColor(red: 105/255.0, green: 55/255.0, blue: 145/255.0, alpha: 1.0)
    }
    class func customdayunselectColor() -> UIColor {
        return UIColor(red: 143/255.0, green: 104/255.0, blue: 173/255.0, alpha: 1.0)
    }
    class func customcheckedColor() -> UIColor {
        return UIColor(red: 99/255.0, green: 99/255.0, blue: 99/255.0, alpha: 1.0)
    }
    class func customminusedColor() -> UIColor {
        return UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0)
    }
    
    class func customPinkColor() -> UIColor {
        return UIColor(red: 164/255.0, green: 118/255.0, blue: 200/255.0, alpha: 1.0)
    }
    class func customGreenButtonColor() -> UIColor {
        return UIColor(red: 0/255.0, green: 204/255.0, blue: 51/255.0, alpha: 1.0)
    }
    class func customCircleFillColor() -> UIColor {
        return UIColor(red: 100/255.0, green: 49/255.0, blue: 142/255.0, alpha: 1.0)
    }
    class func customButtonBorderColor() -> UIColor {
        return UIColor(red: 169/255.0, green: 121/255.0, blue: 214/255.0, alpha: 1.0)
    }
    class func customGuestButtonBorderColor() -> UIColor {
        return UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
    }
    class func customWalletButtonTextColor() -> UIColor {
        return UIColor(red: 191/255.0, green: 191/255.0, blue: 191/255.0, alpha: 1.0)
    }
    class func customWalletButtonBackgroundColor() -> UIColor {
        return UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0)
    }
    class func LabelColor1() -> UIColor {
        return UIColor(red: 40/255.0, green: 41/255.0, blue: 45/255.0, alpha: 1.0)
    }
    class func LabelColor2() -> UIColor {
        return UIColor(red: 200/255.0, green: 200/255.0, blue: 206/255.0, alpha: 1.0)
    }
    class func LabelColor3() -> UIColor {
        return UIColor(red: 86/255.0, green: 102/255.0, blue: 117/255.0, alpha: 1.0)
    }
    class func MarkLabelCategory0() -> UIColor {
        return UIColor(red: 101/255.0, green: 49/255.0, blue: 143/255.0, alpha: 1.0)
    }
    class func MarkLabelCategory1() -> UIColor {
        return UIColor(red: 160/255.0, green: 194/255.0, blue: 60/255.0, alpha: 1.0)
    }
    class func MarkLabelCategory2() -> UIColor {
        return UIColor(red: 147/255.0, green: 41/255.0, blue: 116/255.0, alpha: 1.0)
    }
    class func ClaimedDealTitle() -> UIColor {
        return UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1.0)
    }
    class func CusBarDetailBackground() -> UIColor {
        return UIColor(red: 100/255.0, green: 36/255.0, blue: 144/255.0, alpha: 1.0)
    }
}
extension UIColor{
    func HexToColor(_ hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
