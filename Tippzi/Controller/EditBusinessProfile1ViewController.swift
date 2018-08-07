//
//  EditBusinessProfile1ViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//
import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class EditBusinessProfile1ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labBusinessName: UILabel!
    
    @IBOutlet weak var txtBusinessName: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    @IBOutlet weak var txtWebsite: UITextField!
    
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnLookUp: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var editprofile_questionLabel: UILabel!
    
    @IBOutlet weak var editbusinessTitleLabel: UILabel!
    
    @IBOutlet weak var edit1HeaderTitleLabel: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnBackUp: UIButton!
    
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //font size set
        edit1HeaderTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        txtBusinessName.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtCategory.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtPostCode.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtAddress.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtEmail.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtTelephone.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtWebsite.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        editprofile_questionLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        editbusinessTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labBusinessName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        
        btnLookUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnContinue.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        
        //
        labBusinessName.text = Common.editBarModel.business_name
        btnContinue.layer.cornerRadius = btnContinue.frame.height/2
        btnContinue.layer.borderWidth = 2
        btnContinue.layer.borderColor = UIColor.white.cgColor
        
        btnLookUp.layer.cornerRadius = 5
        
        btnBack.isEnabled = true
        btnBackUp.isEnabled = true
        
        self.activeIndicator.isHidden = true
        
        txtBusinessName.layer.cornerRadius = 5
        //add padding textfield
        let paddingView1_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtBusinessName.frame.height))
        txtBusinessName.leftView = paddingView1_left
        txtBusinessName.leftViewMode = UITextFieldViewMode.always
        let paddingView1_right = UIView(frame: CGRect.init(x: self.txtBusinessName.frame.width - 15, y: 0, width: 15, height: self.txtBusinessName.frame.height))
        txtBusinessName.rightView = paddingView1_right
        txtBusinessName.rightViewMode = UITextFieldViewMode.always
        
        txtCategory.layer.cornerRadius = 5
        //add padding textfield
        let paddingView7_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtCategory.frame.height))
        txtCategory.leftView = paddingView7_left
        txtCategory.leftViewMode = UITextFieldViewMode.always
        let paddingView7_right = UIView(frame: CGRect.init(x: self.txtCategory.frame.width - 15, y: 0, width: 15, height: self.txtCategory.frame.height))
        txtCategory.rightView = paddingView7_right
        txtCategory.rightViewMode = UITextFieldViewMode.always
        
        txtPostCode.layer.cornerRadius = 5
        //add padding textfield
        let paddingView2_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtPostCode.frame.height))
        txtPostCode.leftView = paddingView2_left
        txtPostCode.leftViewMode = UITextFieldViewMode.always
        let paddingView2_right = UIView(frame: CGRect.init(x: self.txtPostCode.frame.width - 15, y: 0, width: 15, height: self.txtPostCode.frame.height))
        txtPostCode.rightView = paddingView2_right
        txtPostCode.rightViewMode = UITextFieldViewMode.always
        
        txtAddress.layer.cornerRadius = 5
        //add padding textfield
        let paddingView3_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtAddress.frame.height))
        txtAddress.leftView = paddingView3_left
        txtAddress.leftViewMode = UITextFieldViewMode.always
        let paddingView3_right = UIView(frame: CGRect.init(x: self.txtAddress.frame.width - 15, y: 0, width: 15, height: self.txtAddress.frame.height))
        txtAddress.rightView = paddingView3_right
        txtAddress.rightViewMode = UITextFieldViewMode.always
        
        txtEmail.layer.cornerRadius = 5
        //add padding textfield
        let paddingView4_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtEmail.frame.height))
        txtEmail.leftView = paddingView4_left
        txtEmail.leftViewMode = UITextFieldViewMode.always
        let paddingView4_right = UIView(frame: CGRect.init(x: self.txtEmail.frame.width - 15, y: 0, width: 15, height: self.txtEmail.frame.height))
        txtEmail.rightView = paddingView4_right
        txtEmail.rightViewMode = UITextFieldViewMode.always
        
        txtTelephone.layer.cornerRadius = 5
        //add padding textfield
        let paddingView5_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtTelephone.frame.height))
        txtTelephone.leftView = paddingView5_left
        txtTelephone.leftViewMode = UITextFieldViewMode.always
        let paddingView5_right = UIView(frame: CGRect.init(x: self.txtTelephone.frame.width - 15, y: 0, width: 15, height: self.txtTelephone.frame.height))
        txtTelephone.rightView = paddingView5_right
        txtTelephone.rightViewMode = UITextFieldViewMode.always
        
        txtWebsite.layer.cornerRadius = 5
        txtWebsite.autocapitalizationType = UITextAutocapitalizationType.none
        
        //add padding textfield
        let paddingView6_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtWebsite.frame.height))
        txtWebsite.leftView = paddingView6_left
        txtWebsite.leftViewMode = UITextFieldViewMode.always
        let paddingView6_right = UIView(frame: CGRect.init(x: self.txtWebsite.frame.width - 15, y: 0, width: 15, height: self.txtWebsite.frame.height))
        txtWebsite.rightView = paddingView6_right
        txtWebsite.rightViewMode = UITextFieldViewMode.always
        
        txtBusinessName.text = Common.editBarModel.business_name
        txtCategory.text = Common.editBarModel.category_name
//            Common.change_text_dark_color(str: txtBusinessName)
        txtPostCode.text = Common.editBarModel.post_code
//            Common.change_text_dark_color(str: txtPostCode)
        
        txtAddress.text = Common.editBarModel.address
//            Common.change_text_dark_color(str: txtAddress)
        txtEmail.text = Common.editBarModel.email
//            Common.change_text_dark_color(str: txtEmail)
        txtTelephone.text = Common.editBarModel.telephone
//            Common.change_text_dark_color(str: txtTelephone)
        txtWebsite.text = Common.editBarModel.website
//            Common.change_text_dark_color(str: txtWebsite)
        
        //for hide keyboard
        txtBusinessName.delegate = self
        txtPostCode.delegate = self
        txtAddress.delegate = self
        txtEmail.delegate = self
        txtTelephone.delegate = self
        txtWebsite.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditBusinessProfile1ViewController.KeyboardHidden))
        
        view.addGestureRecognizer(tap)

        //scroll action
        myScrollView.contentSize.height = self.myScrollView.frame.height + 25
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

    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    //Move a view up only when the keyboard covers an input field ------------
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == txtEmail || textField == txtTelephone {
//            animateViewMoving(up: true, moveValue: 100)
//        }
//        if textField == txtWebsite {
//            animateViewMoving(up: true, moveValue: 170)
//        }
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == txtEmail || textField == txtTelephone {
//            animateViewMoving(up: false, moveValue: 100)
//        }
//        if textField == txtWebsite {
//            animateViewMoving(up: false, moveValue: 170)
//        }
//    }
//    
//    func animateViewMoving (up:Bool, moveValue :CGFloat){
//        let movementDuration:TimeInterval = 0.3
//        let movement:CGFloat = ( up ? -moveValue : moveValue)
//        
//        UIView.beginAnimations("EditBusinessProfile1", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(movementDuration)
//        
//        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
//        UIView.commitAnimations()
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField.isFirstResponder)
        {
            if textField.textInputMode?.primaryLanguage == "emoji" || !(((textField.textInputMode?.primaryLanguage) != nil))
            {
                return false
            }
        }
        if textField.isEqual(txtWebsite) {
            if let _ = string.rangeOfCharacter(from: NSCharacterSet.uppercaseLetters) {
                // Do not allow upper case letters
                return false
            }
            if textField.text?.characters.first == " " || textField.text?.characters.last == " " || string == " " {
                return false
            }
            
            return true
        }
        if textField.isEqual(txtEmail) {
            if let _ = string.rangeOfCharacter(from: NSCharacterSet.uppercaseLetters) {
                // Do not allow upper case letters
                return false
            }
            if textField.text?.characters.first == " " || textField.text?.characters.last == " " || string == " " {
                return false
            }
            
            return true
        }
        return true
    }
    
    // check email type valid or in valid --------------------
    func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    func finishedResponse1() {
        
//        self.view.isUserInteractionEnabled = true
//        
//        timer.invalidate()
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        if toViewController != nil {
            
            self.activeIndicator.isHidden = true
            self.activeIndicator.stopAnimating()
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
        }
        
    }
    
    // Back
    @IBAction func btnBackClick(_ sender: Any) {
        
        Common.category = ""
        Common.selectAddress = ""
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
//        self.activeIndicator.isHidden = false
//        self.activeIndicator.startAnimating()
        self.finishedResponse1()
        
    }
    
    @IBAction func btnUpClick(_ sender: Any) {
        self.finishedResponse1()
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
//        self.activeIndicator.isHidden = false
//        self.activeIndicator.startAnimating()
    
    }
    
    // when back from popup view to CreateBusinessAccountView, show prior textvalue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Common.selectAddress !=  "" {
            
            txtAddress.text = Common.selectAddress
        }
        if Common.editBarModel.category_flag == true {
            if Common.category != "" {
                txtCategory.text = Common.category
            }
        }

    }
    
    
    // look up
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        Common.lookup_button_flag = 2
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressSearchViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func btnLookUpClick(_ sender: Any) {
        
        if !((txtPostCode.text?.isEmpty)!) {
            
            Common.editBarModel.business_name = txtBusinessName.text!
            Common.editBarModel.category_name = txtCategory.text!
            Common.editBarModel.post_code = txtPostCode.text!
            Common.editBarModel.address = txtAddress.text!
            Common.editBarModel.email = txtEmail.text!
            Common.editBarModel.telephone = txtTelephone.text!
            Common.editBarModel.website = txtWebsite.text!
            
            btnBack.isEnabled = false
            btnBackUp.isEnabled = false
            btnLookUp.isEnabled = false
            btnCategory.isEnabled = false
            btnContinue.isEnabled = false
            
            // remove whitespace in text
            let text = txtPostCode.text!.replacingOccurrences(of: " ", with: "")
            txtPostCode.text = text
            txtAddress.text = ""
            
            // get address information from post_code
            var search_address = txtPostCode.text
            
            let url = "https://api.getAddress.io/find/" + search_address! + "?api-key=_GJ_sMycoUOy1_g7W2lavw10914"
            self.flag = false
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
            // HTTP request
            do {
                let opt = try HTTP.GET(url)
                self.activeIndicator.isHidden = false
                self.activeIndicator.startAnimating()
                self.view.isUserInteractionEnabled = false
                
                opt?.run { response in
                    if let error = response.error {
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: "Post code is incorrect")
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            self.btnBack.isEnabled = true
                            self.btnBackUp.isEnabled = true
                            self.btnLookUp.isEnabled = true
                            self.btnCategory.isEnabled = true
                            self.btnContinue.isEnabled = true
                            
                            return
                        })
                    }
                    do {
                        Common.addressModel = try AddressModel(JSONLoader(response.text!))
                        self.flag = true
                    } catch {
                        ////Toast.toast("Json string error: \(error)")
                    }
                }
            } catch let error {
                ////Toast.toast("Request error: \(error)")
            }
            
        }
        else{
            
            MessageBoxViewController.showAlert(self, title: "Alert", message: "Post Code is required")
        }
    }
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        
        Common.editBarModel.business_name = txtBusinessName.text!
//        Common.editBarModel.category_name = txtCategory.text!
        Common.editBarModel.post_code = txtPostCode.text!
        Common.editBarModel.address = txtAddress.text!
        Common.editBarModel.email = txtEmail.text!
        Common.editBarModel.telephone = txtTelephone.text!
        Common.editBarModel.website = txtWebsite.text!
        
        // popup
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessCategoryView1")
        
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
    //Continue button click-------
    
    @IBAction func btnContinueClick(_ sender: Any) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(txtAddress.text!) { (placemarks, error) in
            if error != nil {// Address is incorrect
                print(self.txtAddress.text!)
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your address is invalid \n Please check address again")
                return
            } else {
                //check correctness of inputed data ----------------
                if !((self.txtEmail.text?.isEmpty)!) && self.isValidEmail(self.txtEmail.text!) == false {
                    
                    //alert message
                    MessageBoxViewController.showAlert(self, title: "Alert", message: "Please fill in a valid email address")
                    
                } else {
                    Common.editBarModel.business_name = self.txtBusinessName.text!
                    Common.editBarModel.category_name = self.txtCategory.text!
                    Common.editBarModel.post_code = self.txtPostCode.text!
                    Common.editBarModel.address = self.txtAddress.text!
                    Common.editBarModel.email = self.txtEmail.text!
                    Common.editBarModel.telephone = self.txtTelephone.text!
                    Common.editBarModel.website = self.txtWebsite.text!
                    
                    //transition effect
                    let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile2")
                    
                    let transition = CATransition()
                    transition.type = kCATransitionPush
                    transition.subtype = kCATransitionFromRight
                    transition.duration = 0.5
                    self.view.window!.layer.add(transition, forKey: kCATransition)
                    toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                    self.present(toViewController!, animated: true, completion:nil)
                    
                }
            }
        }
    }
    
    
}
