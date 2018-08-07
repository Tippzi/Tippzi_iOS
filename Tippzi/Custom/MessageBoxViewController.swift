//
//  MessageBoxViewController.swift
//  Buc
//
//  Created by Admin on 3/14/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class MessageBoxViewController: UIViewController {

    // Alert
    class func showAlert(_ viewController : UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    // ActionSheet
    class func showActionSheet(_ viewController : UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

}
