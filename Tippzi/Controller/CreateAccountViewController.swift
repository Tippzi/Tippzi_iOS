//
//  CreateAccountViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftHTTP
import JSONJoy

class CreateAccountViewController: UIViewController , GPPSignInDelegate{

    var referenceID = "nil"
    var twittertoken : String!
    let defaults = UserDefaults.standard
    var signIn : GPPSignIn?
    var request_object: OAuthIORequest? = nil
    var oauth_modal: OAuthIOModal? = nil
    var username : String = ""
    var useremail : String = ""
    @IBOutlet weak var btnOldSchool: UIButton!
    @IBOutlet weak var socialTitleLabel: UILabel!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
//    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var button_width : CGFloat = 0
    var button_height : CGFloat = 0

    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    public func storeAccessToken(_ accessToken: String!) {
        self.defaults.set(accessToken, forKey: "twittertoken")
        UserDefaults.standard.set(accessToken, forKey: "SavedAccessHTTPBody")
    }
    
    /**
     Load access token.
     */
    public func loadAccessToken() -> String! {
        if let outputStr = UserDefaults.standard.object(forKey: "SavedAccessHTTPBody") as? String{
            return outputStr
        }
        return nil
    }
    
    public func finished(withAuth auth: GTMOAuth2Authentication!, error: Error!){
        activeIndicator.isHidden = true
        activeIndicator.stopAnimating()
        var userid = auth.accessToken
        self.useremail = auth.userEmail
        self.username = ""
        GPPSignIn.sharedInstance().signOut()
        self.SocialSignUp(3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
 
       
        headerTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        btnOldSchool.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
                
        socialTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        businessBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
//        termsLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bottom_labelfont))
        
        let longString = "some sort of generic terms and conditions line with links to terms and conditions of use plus privacy policy"
        let longestWord = "terms and conditions"
        let longestWord1 = "conditions of use plus privacy policy"
        
        let longestWordRange = (longString as NSString).range(of: longestWord)
        let longestWordRange1 = (longString as NSString).range(of: longestWord1)
        
       let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont)])
        
       attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont), NSAttributedStringKey.foregroundColor : UIColor.white], range: longestWordRange)
//
      attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont), NSAttributedStringKey.foregroundColor : UIColor.white], range: longestWordRange1)
        
//        termsLabel.attributedText = attributedString
        //
        btnOldSchool.layer.cornerRadius = btnOldSchool.frame.height/2
        btnOldSchool.layer.borderWidth = 2
        btnOldSchool.layer.borderColor = UIColor.white.cgColor
        activeIndicator.isHidden = true

        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    //back click
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
    
    //OldSchool button click
    @IBAction func btnOldSchoolClick(_ sender: Any) {
        if Common.isAccepted == false {
            return
        }
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateGuestAccountView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    
    //BusinessUser button click
    @IBAction func btnBusinessUserClick(_ sender: Any) {
        if Common.isAccepted == false {
            return
        }
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateBusinessAccountView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func GooglePlusConnectAction(_ sender: Any) {
        if Common.isAccepted == false {
            return
        }
        
        //getaccesstoken = defaults.string(forKey: "accesstoken")
        signIn = GPPSignIn.sharedInstance()
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.shouldFetchGoogleUserEmail = true
        signIn?.clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com"
        signIn?.scopes = [kGTLAuthScopePlusLogin]
        signIn?.delegate = self
        signIn?.authenticate()
        activeIndicator.isHidden = false
        activeIndicator.startAnimating()
    }
    
    
    @IBAction func TwitterConnectAction(_ sender: Any) {
        if Common.isAccepted == false {
            return
        }
        
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                let accesstoken = session?.authToken
                let store = Twitter.sharedInstance().sessionStore
                let lastesession = store.session()
                let sessions = store.existingUserSessions()
                self.username = (session?.userName)!
                self.useremail = (session?.userID)!
                
                self.SocialSignUp(2)
            } else {
                
            }
        })
    }
    
    @IBAction func FaceBookConnectAction(_ sender: Any) {
        if Common.isAccepted == false {
            return
        }
        
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
                            self.useremail = (resultDict.value(forKey: "email") as? String)!
                            var first_name = resultDict.value(forKey: "first_name") as? String
                            var last_name = resultDict.value(forKey: "last_name") as? String
                            self.username = first_name! + " " + last_name!
                            self.SocialSignUp(1)
                        }
                    }
                }
                
            }
        }
    }
    
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "Tutorial1View")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func actionTermsAndCondition(_ sender: Any) {
        Common.webUrl = "http://tippzi.com/b-b-terms.php"
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsView")
        self.present(viewController!, animated: true, completion:nil)
    }
    
    func SocialSignUp(_ social_type : Int) {
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        
        //from address get latitude and longitude
        
        var lat = ""
        var lon = ""
        var gender = ""
        var password = ""
        var nickname = ""
        
        var birthday = "0000-00-00"
        
        var social_account = social_type
        
        //up to server
        let url = Common.api_location + "customer_sign_up.php"
        let params = ["user_name": username,
                      "email": useremail,
                      "gender": gender,
                      "birthday": birthday,
                      "username": nickname,
                      "password": password,
                      "lat": lat,
                      "lon": lon,
                      "social_account":social_account] as [String : Any]
        
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
                        GPPSignIn.sharedInstance().signOut()
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
