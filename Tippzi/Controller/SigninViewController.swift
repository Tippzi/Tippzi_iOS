//
//  SigninViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import QuartzCore
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion
import FBSDKLoginKit
import FBSDKCoreKit

class SigninViewController: UIViewController, UITextFieldDelegate, GPPSignInDelegate, CLLocationManagerDelegate, UIWebViewDelegate {
    
    let defaults = UserDefaults.standard
    
    var locationManager: CLLocationManager!
    var lati: String?
    var long: String?
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnShowPass: UIButton!
    @IBOutlet weak var signinHeaderTitleLabel: UILabel!
    
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var socialtitleLabel: UILabel!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    
//    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    var twittertoken : String!
    var signIn : GPPSignIn?
    var request_object: OAuthIORequest? = nil
    var oauth_modal: OAuthIOModal? = nil
    var username : String = ""
    var useremail : String = ""
    
    var decoder : JSONLoader!
    var user_type : String?
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var message : String = ""
    
    var button_width : CGFloat = 0
    var button_height : CGFloat = 0
    
    /**
     Load access token.
     */
    public func loadAccessToken() -> String! {
        if let outputStr = UserDefaults.standard.object(forKey: "SavedAccessHTTPBody") as? String{
            return outputStr
        }
        return nil
    }
    
    public func didReceiveOAuthIOResponse(_ request: OAuthIORequest!) {
        var cred: Dictionary = request.getCredentials()
        print(cred["oauth_token"])
        print(cred["oauth_token_secret"])
        self.request_object = request
        let cache_available = self.oauth_modal?.cacheAvailable(forProvider:"twitter")
        self.defaults.set(cache_available, forKey: "twitterflag")
    }
    
    public func finished(withAuth auth: GTMOAuth2Authentication!, error: Error!){
        activeIndicator.isHidden = true
        activeIndicator.stopAnimating()
        var userid = auth.accessToken
        self.username = auth.userEmail
        //GPPSignIn.sharedInstance().signOut()
        if self.username != "" {
            self.SocialSignIn(3)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        lati = String(userLocation.coordinate.latitude)
        long = String(userLocation.coordinate.longitude)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
        
        
        //font size set
        if DeviceType.IS_IPAD {
            button_width = 80
            button_height = 80
            facebookBtn.frame = CGRect.init(x: facebookBtn.frame.origin.x, y: facebookBtn.frame.origin.y, width: button_width, height: button_height)
            twitterBtn.frame = CGRect.init(x: twitterBtn.frame.origin.x, y: twitterBtn.frame.origin.y, width: button_width, height: button_height)
            googleBtn.frame = CGRect.init(x: googleBtn.frame.origin.x, y: googleBtn.frame.origin.y, width: button_width, height: button_height)
        } else if DeviceType.IS_IPAD_PRO_9_7 {
            button_width = 80
            button_height = 80
            facebookBtn.frame = CGRect.init(x: facebookBtn.frame.origin.x, y: facebookBtn.frame.origin.y, width: button_width, height: button_height)
            twitterBtn.frame = CGRect.init(x: twitterBtn.frame.origin.x, y: twitterBtn.frame.origin.y, width: button_width, height: button_height)
            googleBtn.frame = CGRect.init(x: googleBtn.frame.origin.x, y: googleBtn.frame.origin.y, width: button_width, height: button_height)
        } else if DeviceType.IS_IPAD_PRO_12_9 {
            button_width = 90
            button_height = 90
            facebookBtn.frame = CGRect.init(x: facebookBtn.frame.origin.x, y: facebookBtn.frame.origin.y, width: button_width, height: button_height)
            twitterBtn.frame = CGRect.init(x: twitterBtn.frame.origin.x, y: twitterBtn.frame.origin.y, width: button_width, height: button_height)
            googleBtn.frame = CGRect.init(x: googleBtn.frame.origin.x, y: googleBtn.frame.origin.y, width: button_width, height: button_height)
        }
        
 
        
//        txtUserName.textInputMode .setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS)
        
        txtUserName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtPassword.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        signinHeaderTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        socialtitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
//        termsLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bottom_labelfont))
        
        let longString = "some sort of generic terms and conditions line with links to terms and conditions of use plus privacy policy"
        let longestWord = "terms and conditions"
        let longestWord1 = "conditions of use plus privacy policy"
        
        let longestWordRange = (longString as NSString).range(of: longestWord)
        let longestWordRange1 = (longString as NSString).range(of: longestWord1)
        
        let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont)])
        
        attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont), NSAttributedStringKey.foregroundColor : UIColor.white], range: longestWordRange)
        
        attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont), NSAttributedStringKey.foregroundColor : UIColor.white], range: longestWordRange1)
        
//        termsLabel.attributedText = attributedString
        
        btnForgotPassword.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        btnSignin.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        //
        btnSignin.layer.cornerRadius = btnSignin.frame.height/2
        btnSignin.layer.borderWidth = 2
        btnSignin.layer.borderColor = UIColor.white.cgColor
        
        self.activeIndicator.isHidden = true
        
        txtUserName.layer.cornerRadius = 5
        //add padding textfield
        let paddingView1_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtUserName.frame.height))
        txtUserName.leftView = paddingView1_left
        txtUserName.leftViewMode = UITextFieldViewMode.always
        let paddingView1_right = UIView(frame: CGRect.init(x: self.txtUserName.frame.width - 15, y: 0, width: 15, height: self.txtUserName.frame.height))
        txtUserName.rightView = paddingView1_right
        txtUserName.rightViewMode = UITextFieldViewMode.always
        
        txtPassword.layer.cornerRadius = 5
        let paddingView2_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtPassword.frame.height))
        txtPassword.leftView = paddingView2_left
        txtPassword.leftViewMode = UITextFieldViewMode.always
        let paddingView2_right = UIView(frame: CGRect.init(x: self.txtPassword.frame.width - 30, y: 0, width: 30, height: self.txtPassword.frame.height))
        txtPassword.rightView = paddingView2_right
        txtPassword.rightViewMode = UITextFieldViewMode.always
        
        //for focus to txtName
        
        txtUserName.delegate = self
        txtPassword.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.KeyboardHidden))
        
        view.addGestureRecognizer(tap)
        
        myScrollView.contentSize.height = self.myScrollView.frame.height
        
        // long Press
        //        let longGesture1 = UILongPressGestureRecognizer(target: self, action: "Long")
        //        btnShowPass.addGestureRecognizer(longGesture1)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    @IBAction func actionTermsAndCondition(_ sender: Any) {
        Common.webUrl = "http://tippzi.com/b-b-terms.php"
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsView")
//        self.navigationController?.pushViewController(viewController!, animated: true)
        self.present(viewController!, animated: true, completion:nil)
        //    http://tippzi.com/privacy-policy.php
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField.isFirstResponder)
        {
            if textField.textInputMode?.primaryLanguage == "emoji" || !(((textField.textInputMode?.primaryLanguage) != nil))
            {
                return false
            }
        }
        return true
    }
   
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    @objc func KeyboardHidden() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    @IBAction func showPass(_ sender: Any) {
        
        if txtPassword.isSecureTextEntry == true
        {
            txtPassword.isSecureTextEntry = false
            let image = UIImage(named: "ic_visibility")
            btnShowPass.setImage(image, for: .normal)
        }
        else
        {
            txtPassword.isSecureTextEntry = true
            let image = UIImage(named: "ic_visibility_off")
            btnShowPass.setImage(image, for: .normal)
        }
    }
    // when long press, password display
    //    func Long() {
    //
    //        if txtPassword.isSecureTextEntry == true
    //        {
    //           txtPassword.isSecureTextEntry = false
    //        }
    //        else
    //        {
    //            txtPassword.isSecureTextEntry = false
    //        }
    //    }
    
    // when addtarger to txtUserName, all control editable
    
    //    func TextFieldEnabled(textField : UITextField) {
    //
    //        txtUserName.layer.backgroundColor = UIColor.white.cgColor
    //        txtPassword.layer.backgroundColor = UIColor.white.cgColor
    //        txtPassword.isEnabled = true
    //
    //        btnSignin.isEnabled = true
    //
    //    }
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //back button click
    @IBAction func btnBackClick(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    // for indicator finish
    
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        
        if self.user_type == "1" {
            
            //transition effect
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
            
        } else {
            
            //transition effect
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            self.present(toViewController!, animated: false, completion:nil)
        }
        
    }
    
    @objc func finishedResponse2() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        MessageBoxViewController.showAlert(self, title: "Forgot Password", message: "The link was sent to your email address." )
    }
    
    
    @IBAction func ForgotAction(_ sender: Any) {
        if (txtUserName.text?.isEmpty)! {
            
            if (txtUserName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Username field is required" )
            }
        } else {
            self.flag = false
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse2), userInfo: nil, repeats: true)
            
            let userName = txtUserName.text
            let url = Common.api_location + "forgot_password.php"
            let params = ["username": userName] as [String : Any]
            
            do {
                let opt = try HTTP.POST(url, parameters: params)
                self.activeIndicator.isHidden = false
                self.activeIndicator.startAnimating()
                self.view.isUserInteractionEnabled = false
                
                
                //get from server
                opt?.run { response in
                    if let error = response.error {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            return
                        })
                        
                    }
                    do {
                        self.flag = true
                    } catch {
                        DispatchQueue.main.sync(execute: {
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: self.message)
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            return
                        })
                        
                    }
                }
            } catch let error {
                //Toast.toast("Request error: \(error)")
            }
        }
        
    }
    //signin button click
    @IBAction func btnSigninClick(_ sender: Any) {
        if Common.isAccepted == false {
            return
        }

        //check textfields is empty ---------------
        if (txtUserName.text?.isEmpty)! || (txtPassword.text?.isEmpty)! {
            if (txtUserName.text?.isEmpty)! {
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Username field is required" )
            }
            if (txtPassword.text?.isEmpty)! {
                MessageBoxViewController.showAlert(self, title: "Error", message: "Password field is required" )
            }
        }
        else{
            
            
            self.flag = false
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
            
            let userName = txtUserName.text
            let password = txtPassword.text
//            let lan = String(Common.Coordinate.latitude)
//            let lon = String(Common.Coordinate.longitude)
            let lan = lati
            let lon = long
            
            let url = Common.api_location + "sign_in.php"
            let params = ["username": userName,
                          "password": password,
                          "lat": lan,
                          "lon": lon] as [String : Any]
            
            do {
                let opt = try HTTP.POST(url, parameters: params)
                self.activeIndicator.isHidden = false
                self.activeIndicator.startAnimating()
                self.view.isUserInteractionEnabled = false
                
                
                //get from server
                opt?.run { response in
                    if let error = response.error {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            return
                        })
                        
                    }
                    do {
                        print (response.text!)
                        self.decoder = JSONLoader(response.text!)
                        self.message = try self.decoder["message"].get()
                        self.user_type = try self.decoder["user_type"].get()
                        
                        if self.user_type == "1" {
                            Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                            if Common.customerModel.success == "true" {
                                self.defaults.set(Common.customerModel.user_type, forKey: "user_type")
                                self.defaults.set(Common.customerModel.user_id, forKey: "user_id")
                                self.flag = true
                            }else {
                                
                                DispatchQueue.main.sync(execute: {
                                    
                                    self.view.isUserInteractionEnabled = true
                                    
                                    MessageBoxViewController.showAlert(self, title: "Error", message: Common.customerModel.message!)
                                    
                                    // stop timer
                                    self.activeIndicator.stopAnimating()
                                    self.activeIndicator.isHidden = true
                                    self.timer.invalidate()
                                    
                                    return
                                })
                            }
                        } else if self.user_type == "2" {
                            Common.businessModel = try BusinessModel(JSONLoader(response.text!))
                            if Common.businessModel.success == "true" {
                                self.flag = true
                                
                                self.defaults.set(Common.businessModel.user_type, forKey: "user_type")
                                self.defaults.set(Common.businessModel.user_id, forKey: "user_id")
                                
                            }else {
                                
                                DispatchQueue.main.sync(execute: {
                                    
                                    self.view.isUserInteractionEnabled = true
                                    
                                    MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                                    // stop timer
                                    self.activeIndicator.stopAnimating()
                                    self.activeIndicator.isHidden = true
                                    self.timer.invalidate()
                                    
                                    return
                                })
                                
                            }
                        } else if self.user_type == nil || self.user_type == "" {
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.view.isUserInteractionEnabled = true
                                
                                MessageBoxViewController.showAlert(self, title: "Error", message: self.message)
                                // stop timer
                                self.activeIndicator.stopAnimating()
                                self.activeIndicator.isHidden = true
                                self.timer.invalidate()
                                
                                return
                            })
                        }
                        
                        
                    } catch {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: self.message)
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            return
                        })
                        
                    }
                }
            } catch let error {
                //Toast.toast("Request error: \(error)")
            }
            
        }
    }
    
    @IBAction func ConnectFaceBookAction(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        let permissions = ["public_profile"]
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in

            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    
                }
                if FBSDKAccessToken.current() != nil {
                    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large),first_name, last_name,gender"]).start { (connection, resultData, error) in
                        if(resultData != nil){
                            let resultDict = resultData as! NSDictionary
                            self.username = (resultDict.value(forKey: "email") as? String)!
                            self.SocialSignIn(1)
                        }
                    }
                }
                
            }
        }
    }
    
    @IBAction func ConnectTwitterAction(_ sender: Any) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                let accesstoken = session?.authToken
                let store = Twitter.sharedInstance().sessionStore
                let lastesession = store.session()
                let sessions = store.existingUserSessions()
                self.username = (session?.userName)!
                self.useremail = (session?.userID)!
                self.SocialSignIn(2)
            } else {
                
            }
        })
    }
    
    @IBAction func ConnectGoogleAction(_ sender: Any) {
        signIn = GPPSignIn.sharedInstance()
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.shouldFetchGoogleUserEmail = true
        signIn?.clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com"
        signIn?.scopes = [kGTLAuthScopePlusLogin]
        signIn?.delegate = self
        signIn?.authenticate()
//        activeIndicator.isHidden = false
//        activeIndicator.startAnimating()
    }
    
    @objc func finishedResponse1() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    func SocialSignIn(_ social_type : Int){
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
        
        //from address get latitude and longitude
        
        var lat = String(Common.Coordinate.latitude)
        var lon = String(Common.Coordinate.longitude)
        
        var social_account = social_type
        
        //up to server
        let url = Common.api_location + "so_sign_in.php"
        let params = ["username": self.username,
                      "social_account": social_account,
                      "lat": lat,
                      "lon": lon] as [String : Any]
        
        do {
            let opt = try HTTP.POST(url, parameters: params)
            self.activeIndicator.isHidden = false
            self.activeIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            
            
            //get from server
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.view.isUserInteractionEnabled = true
                        
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        // stop timer
                        self.activeIndicator.stopAnimating()
                        self.activeIndicator.isHidden = true
                        self.timer.invalidate()
                       
                        return
                    })
                }
                do {
                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                    if Common.customerModel.success == "true" {
                        self.defaults.set(Common.customerModel.user_type, forKey: "user_type")
                        self.defaults.set(Common.customerModel.user_id, forKey: "user_id")
                        self.flag = true
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            GPPSignIn.sharedInstance().signOut()
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.customerModel.message!)
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                        
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
    
    func didFailWithOAuthIOError(error: NSError!) {
        
    }
    
    
    func didFailAuthenticationServerSide(_ body: String!, andResponse response: URLResponse!, andError error: Error!) {
        
    }
    
    func didAuthenticateServerSide(_ body: String!, andResponse response: URLResponse!) {
        
    }
    
    func didReceiveOAuthIOCode(_ code: String!) {
        
    }
    
    func didFail(withOAuthIOError error: Error!) {
        
    }
}

