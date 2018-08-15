//
//  SplashViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import JSONJoy
import SwiftHTTP
import CoreLocation
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}

struct DeviceType
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPHONE_8          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 750.0
    static let IS_IPHONE_8P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1080.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct Version{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
}
class SplashViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    var button_size : CGFloat = 0
    var bar_name_size : CGFloat = 0
    var deal_name_size : CGFloat = 0
    var comment_size : CGFloat = 0
    var description_size : CGFloat = 0
    var edit_box_size : CGFloat = 0
    var small_comment_size : CGFloat = 0
    var big_comment_size : CGFloat = 0
    var sub_button_size : CGFloat = 0
    var title_size : CGFloat = 0
    var count_size : CGFloat = 0
    var address_item : CGFloat = 0
    var bottom_labelfont : CGFloat = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    var scale_value : Int = 0
    var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D()
    let locationTracker = LocationTracker(threshold: 10.0)
    
    var winkImageView_width: CGFloat = 0
    var winkImageView_height: CGFloat = 0
    var readImageView_width:CGFloat = 0
    var readImageView_height:CGFloat = 0
    var walletImageView_width: CGFloat = 0
    var walletImageView_height: CGFloat = 0
    var check_width : CGFloat = 0
    var check_height : CGFloat = 0
    var open_time : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Common.deviceVersion = UIDevice.current.modelName
        
        button_size = 20
        bar_name_size = 26
        deal_name_size = 23
        comment_size = 14
        description_size = 18
        edit_box_size = 18
        small_comment_size = 12
        big_comment_size = 19
        sub_button_size = 14
        title_size = 20
        count_size = 43
        bottom_labelfont = 11
        width = 70
        height = 70
        scale_value = 8
        winkImageView_width = 17
        winkImageView_height = 17
        readImageView_width = 17
        readImageView_height = 17
        walletImageView_width = 17
        walletImageView_height = 17
        check_width = 12
        check_height = 12
        open_time = 28
        Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
        Common.fontsizeModel = [Font(button_size,
                                     bar_name_size,
                                     deal_name_size,
                                     comment_size,
                                     description_size,
                                     edit_box_size,
                                     small_comment_size,
                                     big_comment_size,
                                     sub_button_size,
                                     title_size,
                                     count_size,bottom_labelfont,scale_value,open_time)]
        
        
        if DeviceType.IS_IPHONE_5 {
            button_size = 15
            bar_name_size = 19
            deal_name_size = 16
            comment_size = 12
            description_size = 12
            edit_box_size = 15
            small_comment_size = 10
            big_comment_size = 14
            sub_button_size = 13
            title_size = 15
            count_size = 35
            bottom_labelfont = 8
            width = 55
            height = 55
            scale_value = 8
            winkImageView_width = 15
            winkImageView_height = 15
            readImageView_width = 15
            readImageView_height = 15
            walletImageView_width = 15
            walletImageView_height = 15
            check_width = 8
            check_height = 8
            open_time = 20
            
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,bar_name_size,deal_name_size,comment_size,description_size, edit_box_size,small_comment_size,big_comment_size,sub_button_size,title_size,count_size,bottom_labelfont,scale_value,open_time)]
        }
        else if DeviceType.IS_IPHONE_6 {
            button_size = 18
            bar_name_size = 23
            deal_name_size = 20
            comment_size = 14
            description_size = 16
            edit_box_size = 17
            small_comment_size = 12
            big_comment_size = 16
            sub_button_size = 14
            title_size = 18
            count_size = 38
            bottom_labelfont = 10
            width = 65
            height = 65
            scale_value = 8
            winkImageView_width = 17
            winkImageView_height = 17
            readImageView_width = 17
            readImageView_height = 17
            walletImageView_width = 17
            walletImageView_height = 17
            check_width = 11
            check_height = 11
            open_time = 35
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        }
        else if DeviceType.IS_IPHONE_6P {
            button_size = 20
            bar_name_size = 25
            deal_name_size = 21
            comment_size = 14
            description_size = 16
            edit_box_size = 18
            small_comment_size = 12
            big_comment_size = 17
            sub_button_size = 14
            title_size = 20
            count_size = 43
            bottom_labelfont = 10
            width = 70
            height = 70
            scale_value = 8
            winkImageView_width = 17
            winkImageView_height = 17
            readImageView_width = 17
            readImageView_height = 17
            walletImageView_width = 17
            walletImageView_height = 17
            check_width = 12
            check_height = 12
            open_time = 27
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        }
        else if DeviceType.IS_IPHONE_7 {
            button_size = 20
            bar_name_size = 26
            deal_name_size = 22
            comment_size = 14
            description_size = 17
            edit_box_size = 18
            small_comment_size = 12
            big_comment_size = 18
            sub_button_size = 14
            title_size = 20
            count_size = 43
            bottom_labelfont = 11
            width = 75
            height = 75
            scale_value = 8
            winkImageView_width = 17
            winkImageView_height = 17
            readImageView_width = 17
            readImageView_height = 17
            walletImageView_width = 17
            walletImageView_height = 17
            check_width = 12
            check_height = 12
            open_time = 28
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
            
        }
        else if DeviceType.IS_IPHONE_7P {
            button_size = 20
            bar_name_size = 26
            deal_name_size = 23
            comment_size = 14
            description_size = 18
            edit_box_size = 18
            small_comment_size = 12
            big_comment_size = 19
            sub_button_size = 14
            title_size = 20
            count_size = 43
            bottom_labelfont = 11
            width = 70
            height = 70
            scale_value = 8
            winkImageView_width = 17
            winkImageView_height = 17
            readImageView_width = 17
            readImageView_height = 17
            walletImageView_width = 17
            walletImageView_height = 17
            check_width = 12
            check_height = 12
            open_time = 28
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        } else if DeviceType.IS_IPAD {
            button_size = 25
            bar_name_size = 36
            deal_name_size = 26
            comment_size = 19
            description_size = 20
            edit_box_size = 20
            small_comment_size = 17
            big_comment_size = 23
            sub_button_size = 17
            title_size = 25
            count_size = 55
            bottom_labelfont = 14
            width = 80
            height = 80
            scale_value = 10
            winkImageView_width = 17
            winkImageView_height = 17
            readImageView_width = 17
            readImageView_height = 17
            walletImageView_width = 17
            walletImageView_height = 17
            check_width = 17
            check_height = 17
            open_time = 38
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        } else if DeviceType.IS_IPAD_PRO_9_7 {
            button_size = 28
            bar_name_size = 38
            deal_name_size = 26
            comment_size = 19
            description_size = 20
            edit_box_size = 23
            small_comment_size = 17
            big_comment_size = 26
            sub_button_size = 23
            title_size = 28
            count_size = 55
            bottom_labelfont = 16
            width = 100
            height = 100
            scale_value = 11
            winkImageView_width = 18
            winkImageView_height = 18
            readImageView_width = 18
            readImageView_height = 18
            walletImageView_width = 18
            walletImageView_height = 18
            check_width = 30
            check_height = 30
            open_time = 40
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        } else if DeviceType.IS_IPAD_PRO_12_9 {
            button_size = 25
            bar_name_size = 38
            deal_name_size = 26
            comment_size = 19
            description_size = 20
            edit_box_size = 20
            small_comment_size = 17
            big_comment_size = 23
            sub_button_size = 17
            title_size = 25
            count_size = 55
            bottom_labelfont = 16
            width = 120
            height = 120
            scale_value = 12
            winkImageView_width = 18
            winkImageView_height = 18
            readImageView_width = 18
            readImageView_height = 18
            walletImageView_width = 18
            walletImageView_height = 18
            check_width = 30
            check_height = 30
            open_time = 40
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        } else {
            button_size = 20
            bar_name_size = 26
            deal_name_size = 23
            comment_size = 14
            description_size = 18
            edit_box_size = 18
            small_comment_size = 12
            big_comment_size = 19
            sub_button_size = 14
            title_size = 20
            count_size = 43
            bottom_labelfont = 11
            width = 70
            height = 70
            scale_value = 8
            winkImageView_width = 17
            winkImageView_height = 17
            readImageView_width = 17
            readImageView_height = 17
            walletImageView_width = 17
            walletImageView_height = 17
            check_width = 12
            check_height = 12
            open_time = 28
            Common.imageSize = [ImageSize(width, height,winkImageView_width,winkImageView_height,readImageView_width,readImageView_height,walletImageView_width,walletImageView_height,check_width, check_height)]
            Common.fontsizeModel = [Font(button_size,
                                         bar_name_size,
                                         deal_name_size,
                                         comment_size,
                                         description_size,
                                         edit_box_size,
                                         small_comment_size,
                                         big_comment_size,
                                         sub_button_size,
                                         title_size,
                                         count_size,bottom_labelfont,scale_value,open_time)]
        }
 
        
        // get customer's location information
        self.locationTracker.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                self.coordinate = location.physical.coordinate
                Common.Coordinate = self.coordinate
            case .failure: break
                
            }
        }
        self.LoadCall()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
//        perform(#selector(SplashViewController.showViewController), with: nil, afterDelay: 0)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    func LoadCall(){
        let user_type = defaults.string(forKey: "user_type")
        if user_type == "1" {
            perform(#selector(SplashViewController.showViewController1), with: nil, afterDelay: 0)
        } else if user_type == "2" {
            perform(#selector(SplashViewController.showViewController2), with: nil, afterDelay: 0)
        } else if user_type == nil || user_type == "" {
            perform(#selector(SplashViewController.showViewController), with: nil, afterDelay: 0)
        }
    }

    @objc func showViewController() {
    // go to MainViewController
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @objc func showViewController1() {
        
        let user_id = defaults.string(forKey: "user_id")
        
        // if customer
        let lan = String(self.coordinate.latitude)
        let lon = String(self.coordinate.longitude)
        
        // HTTP request
        let url = Common.api_location + "check_remember_customer.php"
        let params = ["user_id": user_id,
                      "lat": lan,
                      "lon": lon]
        do {
            let opt = try HTTP.POST(url, parameters: params)
            self.activeIndicator.isHidden = false
            self.activeIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            
            opt?.run { response in
                DispatchQueue.main.sync(execute: {
                    self.view.isUserInteractionEnabled = true
                    
                    self.activeIndicator.stopAnimating()
                    self.activeIndicator.isHidden = true
                })
                
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        return
                    })
                    
                }
                do {
                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                    if Common.customerModel.success == "true" {
                        self.defaults.set(Common.customerModel.user_type, forKey: "user_type")
                        self.defaults.set(Common.customerModel.user_id, forKey: "user_id")
                        
                        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
                        if toViewController != nil {
                            DispatchQueue.main.sync(execute: {
                                let transition = CATransition()
                                transition.type = kCATransitionPush
                                transition.subtype = kCATransitionFromRight
                                transition.duration = 0.5
                                self.view.window!.layer.add(transition, forKey: kCATransition)
                                toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                                self.present(toViewController!, animated: true, completion:nil)
                            })
                        }
                    } else {
                        DispatchQueue.main.sync(execute: {
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.customerModel.message!)
                            return
                        })
                    }
                    
                } catch {
                    //Toast.toast("Json string error: \(error)")
                    DispatchQueue.main.sync(execute: {
                        self.perform(#selector(SplashViewController.showViewController), with: nil, afterDelay: 0)
                    })
                }
            }
        } catch let error {
            //Toast.toast("Request error: \(error)")
        }
    }
    
    @objc func showViewController2() {
        
        let user_id = defaults.string(forKey: "user_id")
        
        // HTTP request
        let url = Common.api_location + "check_remember_business.php"
        let params = ["user_id": user_id]
        do {
            let opt = try HTTP.POST(url, parameters: params)
            self.activeIndicator.isHidden = false
            self.activeIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            
            opt?.run { response in
                DispatchQueue.main.sync(execute: {
                    self.view.isUserInteractionEnabled = true
                    self.activeIndicator.stopAnimating()
                    self.activeIndicator.isHidden = true
                })
                
                if let error = response.error {
                    DispatchQueue.main.sync(execute: {
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        return
                    })
                }
                do {
                    Common.businessModel = try BusinessModel(JSONLoader(response.text!))
                    if Common.businessModel.success == "true" {
                        self.defaults.set(Common.businessModel.user_type, forKey: "user_type")
                        self.defaults.set(Common.businessModel.user_id, forKey: "user_id")
                        
                        DispatchQueue.main.sync(execute: {
                            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
                            if toViewController != nil {
                                self.activeIndicator.isHidden = true
                                self.activeIndicator.stopAnimating()
                                
                                let transition = CATransition()
                                transition.type = kCATransitionPush
                                transition.subtype = kCATransitionFromRight
                                transition.duration = 0.5
                                self.view.window!.layer.add(transition, forKey: kCATransition)
                                toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                                self.present(toViewController!, animated: true, completion:nil)
                            }
                        })
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                            return
                        })
                    }
                } catch {
                    //Toast.toast("Json string error: \(error)")
                }
            }
        } catch let error {
            //Toast.toast("Request error: \(error)")
        }
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}
