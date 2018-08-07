//
//  CreateGuestAccountViewController.swift
//  Tippzi
//
//  Created by Admin on 11/17/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
//import DLRadioButton

class CreateGuestAccountViewController: UIViewController, UITextFieldDelegate {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
   
    @IBOutlet weak var customerHeaderLabel: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnCreateAcount: UIButton!
    @IBOutlet weak var btnShowPass: UIButton!
    @IBOutlet weak var btnShowPass1: UIButton!
//    @IBOutlet weak var OptionView: UIView!
    @IBOutlet weak var btnGender: UIButton!
    
//    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnBackUp: UIButton!
    
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //font size set
        customerHeaderLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        txtName.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtEmail.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtGender.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtNickName.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtPassword.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtConfirmPassword.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
//        txtGender.textColor = MyColor.LabelColor1()
        
//        termsLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].bottom_labelfont))
        
        let longString = "some sort of generic terms and conditions line with links to terms and conditions of use plus privacy policy"
        let longestWord = "terms and conditions"
        let longestWord1 = "conditions of use plus privacy policy"
        
        let longestWordRange = (longString as NSString).range(of: longestWord)
        let longestWordRange1 = (longString as NSString).range(of: longestWord1)
        
        let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont)])
        
        attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont), NSAttributedStringKey.foregroundColor : UIColor.white], range: longestWordRange)
        
        attributedString.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: Common.fontsizeModel[0].bottom_labelfont), NSAttributedStringKey.foregroundColor : UIColor.white], range: longestWordRange1)
        
//        termsLabel.attributedText = attributedString
        
        btnBack.isEnabled = true
        btnBackUp.isEnabled = true
      
        btnCreateAcount.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        
        ///
        btnCreateAcount.layer.cornerRadius = btnCreateAcount.frame.height/2
        btnCreateAcount.layer.borderWidth = 2
        btnCreateAcount.layer.borderColor = MyColor.customGuestButtonBorderColor().cgColor
        btnCreateAcount.setTitleColor(MyColor.customGuestButtonBorderColor(), for: .normal)
        
        btnCreateAcount.isEnabled = false
        
        self.activeIndicator.isHidden = true
        
        btnShowPass.isEnabled = false
        btnShowPass1.isEnabled = false
        
        //for focus to txtName
        txtName.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
        
        //for hide keyboard
        txtName.delegate = self
        txtEmail.delegate = self
        txtNickName.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        txtName.layer.cornerRadius = 5
        //add padding textfield
        let paddingView1_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtName.frame.height))
        txtName.leftView = paddingView1_left
        txtName.leftViewMode = UITextFieldViewMode.always
        let paddingView1_right = UIView(frame: CGRect.init(x: self.txtName.frame.width - 15, y: 0, width: 15, height: self.txtName.frame.height))
        txtName.rightView = paddingView1_right
        txtName.rightViewMode = UITextFieldViewMode.always
        
        txtEmail.layer.cornerRadius = 5
        //add padding textfield
        let paddingView2_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtEmail.frame.height))
        txtEmail.leftView = paddingView2_left
        txtEmail.leftViewMode = UITextFieldViewMode.always
        let paddingView2_right = UIView(frame: CGRect.init(x: self.txtEmail.frame.width - 15, y: 0, width: 15, height: self.txtEmail.frame.height))
        txtEmail.rightView = paddingView2_right
        txtEmail.rightViewMode = UITextFieldViewMode.always
        
        txtGender.layer.cornerRadius = 5
//        txtGender.layer.masksToBounds = true
        //add padding txtGender
        let paddingView3_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtGender.frame.height))
        txtGender.leftView = paddingView3_left
        txtGender.leftViewMode = UITextFieldViewMode.always
        btnGender.layer.cornerRadius = 5
        
        txtNickName.layer.cornerRadius = 5
        //add padding textfield
        let paddingView4_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtNickName.frame.height))
        txtNickName.leftView = paddingView4_left
        txtNickName.leftViewMode = UITextFieldViewMode.always
        let paddingView4_right = UIView(frame: CGRect.init(x: self.txtNickName.frame.width - 15, y: 0, width: 15, height: self.txtNickName.frame.height))
        txtNickName.rightView = paddingView4_right
        txtNickName.rightViewMode = UITextFieldViewMode.always
        
        txtPassword.layer.cornerRadius = 5
        //add padding textfield
        let paddingView5_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtPassword.frame.height))
        txtPassword.leftView = paddingView5_left
        txtPassword.leftViewMode = UITextFieldViewMode.always
        let paddingView5_right = UIView(frame: CGRect.init(x: self.txtPassword.frame.width - 30, y: 0, width: 30, height: self.txtPassword.frame.height))
        txtPassword.rightView = paddingView5_right
        txtPassword.rightViewMode = UITextFieldViewMode.always
        
        txtConfirmPassword.layer.cornerRadius = 5
        //add padding textfield
        let paddingView6_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtConfirmPassword.frame.height))
        txtConfirmPassword.leftView = paddingView6_left
        txtConfirmPassword.leftViewMode = UITextFieldViewMode.always
        let paddingView6_right = UIView(frame: CGRect.init(x: self.txtConfirmPassword.frame.width - 15, y: 0, width: 15, height: self.txtConfirmPassword.frame.height))
        txtConfirmPassword.rightView = paddingView6_right
        txtConfirmPassword.rightViewMode = UITextFieldViewMode.always
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateGuestAccountViewController.KeyboardHidden))
        
        view.addGestureRecognizer(tap)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    @objc func KeyboardHidden() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    // when addtarger to txtName, all control editable
    @objc func TextFieldEnabled(_ textField : UITextField) {
        
        txtName.layer.backgroundColor = UIColor.white.cgColor
        txtEmail.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.isEnabled = true
        txtGender.backgroundColor = UIColor.white
//        txtGender.textColor = MyColor.LabelColor2()
//            txtGender.isEnabled = true
            btnGender.isEnabled = true
        
        txtNickName.layer.backgroundColor = UIColor.white.cgColor
            txtNickName.isEnabled = true
        txtPassword.layer.backgroundColor = UIColor.white.cgColor
            txtPassword.isEnabled = true
        txtConfirmPassword.layer.backgroundColor = UIColor.white.cgColor
            txtConfirmPassword.isEnabled = true
        
        btnCreateAcount.isEnabled = true
            btnCreateAcount.backgroundColor = MyColor.customGreenButtonColor()
            btnCreateAcount.setTitleColor(UIColor.white, for: .normal)
            btnCreateAcount.layer.borderWidth = 0
        btnShowPass.isEnabled = true
        btnShowPass1.isEnabled = true
        
        //scroll action
        myScrollView.contentSize.height = self.myScrollView.frame.height
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Common.customerSignUpModel.flag == true {
            txtName.text = Common.customerSignUpModel.username
            txtEmail.text = Common.customerSignUpModel.email
            txtGender.text =  Common.gender
            txtNickName.text = Common.customerSignUpModel.nickname
            txtPassword.text = Common.customerSignUpModel.password
            txtConfirmPassword.text = Common.customerSignUpModel.confirm_password
        
            txtName.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.isEnabled = true
            txtGender.backgroundColor = UIColor.white
        
            btnGender.isEnabled = true
        
            txtNickName.layer.backgroundColor = UIColor.white.cgColor
            txtNickName.isEnabled = true
            txtPassword.layer.backgroundColor = UIColor.white.cgColor
            txtPassword.isEnabled = true
            txtConfirmPassword.layer.backgroundColor = UIColor.white.cgColor
            txtConfirmPassword.isEnabled = true
        
            btnCreateAcount.isEnabled = true
            btnCreateAcount.backgroundColor = MyColor.customGreenButtonColor()
            btnCreateAcount.setTitleColor(UIColor.white, for: .normal)
            btnCreateAcount.layer.borderWidth = 0
            btnShowPass.isEnabled = true
            btnShowPass1.isEnabled = true
        
            //scroll action
            myScrollView.contentSize.height = self.myScrollView.frame.height
        }
        
    }
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // check email type valid or in valid --------------------
    func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    //btnGenderClick
    @IBAction func btnGenderClick(_ sender: Any) {
        
        Common.customerSignUpModel.username = txtName.text
        Common.customerSignUpModel.email = txtEmail.text
        //        Common.customerSignUpModel.gender = txtGender.text
        Common.customerSignUpModel.nickname = txtNickName.text
        Common.customerSignUpModel.password = txtPassword.text
        Common.customerSignUpModel.confirm_password = txtConfirmPassword.text
        
        // popup datepicker
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "GenderView")
        
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    //Back
    @IBAction func btnBackClick(_ sender: Any) {
        
        format()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func btnUpClick(_ sender: Any) {
        
        format()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    // show password secured
    
    @IBAction func btnShowPassword(_ sender: Any) {
        
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
    
    @IBAction func btnShowPassword1(_ sender: Any) {
        
        if txtConfirmPassword.isSecureTextEntry == true
        {
            txtConfirmPassword.isSecureTextEntry = false
            let image = UIImage(named: "ic_visibility")
            btnShowPass1.setImage(image, for: .normal)
        }
        else
        {
            txtConfirmPassword.isSecureTextEntry = true
            let image = UIImage(named: "ic_visibility_off")
            btnShowPass1.setImage(image, for: .normal)
            
        }
    }
    
    func format()
    {
        
        Common.customerSignUpModel.username = ""
        Common.customerSignUpModel.email = ""
        Common.customerSignUpModel.gender = ""
        Common.customerSignUpModel.nickname = ""
        Common.customerSignUpModel.password = ""
        Common.customerSignUpModel.confirm_password = ""
        
        Common.customerSignUpModel.flag = false
        
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
        
        format()
        
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
    
    //CreateBusinessAccount-------
    
    
    @IBAction func btnCreateAccountClick(_ sender: Any) {
        
        if Common.isAccepted == false {
            return
        }
        
        //check textfields is empty ---------------
        if (txtName.text?.isEmpty)! || (txtEmail.text?.isEmpty)! || (txtGender.text?.isEmpty)! || (txtNickName.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtConfirmPassword.text?.isEmpty)!{
            
            if (txtName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your name field is required")
            }
            if (txtEmail.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your email field is required")
            }
            if (txtGender.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your gender field is required")
            }
            if (txtNickName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Username field is required")
            }
            if (txtPassword.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Password field is required")
            }
            if (txtConfirmPassword.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Confirm password field is required")
            }
            
        }
        else{
            
            //check correctness of inputed data ----------------
            if isValidEmail(txtEmail.text!) == false || txtPassword.text!.characters.count < 8 || txtPassword.text != txtConfirmPassword.text {
                
                if isValidEmail(txtEmail.text!) == false {
                    
                    MessageBoxViewController.showAlert(self, title: "Alert", message: "Please fill in a valid email address")
                    
                }
                
                if txtPassword.text!.characters.count < 8 {
                    
                    MessageBoxViewController.showAlert(self, title: "Alert", message: "This password is too short")
                    
                }
                if txtPassword.text != txtConfirmPassword.text {
                    
                    MessageBoxViewController.showAlert(self, title: "Alert", message: "This password is incorrect")
                }
            }
            else{
                
                btnBack.isEnabled = false
                btnBackUp.isEnabled = false
                btnCreateAcount.isEnabled = false
//                btnMale.isEnabled = false
//                btnFemale.isEnabled = false
                // input business data to server
                input_customer_data()
            }
            
        }
    }
    
    @IBAction func actionTermsAndCondition(_ sender: Any) {
        Common.webUrl = "http://tippzi.com/b-c-terms.php"
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsView")
        self.present(viewController!, animated: true, completion:nil)
    }
    
    // input data to server and get from server
    func input_customer_data()
    {
        
        // ----------------------------------------------- input data to server --------------------------------------------------------
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        
        var name = txtName.text
        var email = txtEmail.text
        var gender = txtGender.text
        var nickname = txtNickName.text
        var password = txtPassword.text

        //from address get latitude and longitude
        
        var lat = String(Common.Coordinate.latitude)
        var lon = String(Common.Coordinate.longitude)
        var birthday = "0000-00-00"
        
        var social_account = 0
        
        //up to server
        let url = Common.api_location + "customer_sign_up.php"
        let params = ["user_name": name!,
                      "email": email!,
                      "gender": gender!,
                      "birthday": birthday,
                      "username": nickname!,
                      "password": password!,
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
                        
                        self.btnBack.isEnabled = true
                        self.btnBackUp.isEnabled = true
                        self.btnCreateAcount.isEnabled = true
                        
                        return
                    })
                    
                }
                do {

                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                    
                    if Common.customerModel.success == "true" {
                        
                        self.defaults.set("1", forKey: "user_type")
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
                            
                            self.btnBack.isEnabled = true
                            self.btnBackUp.isEnabled = true
                            self.btnCreateAcount.isEnabled = true
                            
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
        
        // =============================================================================================================================
        
//        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Tutorial1View") {
//            self.present(viewController, animated: true, completion: nil)
//        }
        
    }
    
    
}

//extension UILabel {
//    private struct AssociatedKeys {
//        static var padding = UIEdgeInsets()
//    }
//    
//    public var padding: UIEdgeInsets? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//    }
//    
//    override open func draw(_ rect: CGRect) {
//        if let insets = padding {
//            self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//        } else {
//            self.drawText(in: rect)
//        }
//    }
//    
//    
//}

