//
//  MainViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnSignin: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //font size set
        btnCreateAccount.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnSignin.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        //
        //round button make
        btnCreateAccount.layer.cornerRadius = btnCreateAccount.frame.height/2
        
        btnSignin.layer.cornerRadius = btnSignin.frame.height/2
        btnSignin.layer.borderColor = UIColor.white.cgColor
        btnSignin.layer.borderWidth = 2
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
   
    //btnClick action
    @IBAction func btnCreateAccountClick(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    
    @IBAction func btnSigninClick(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "SigninView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    

}
