//
//  CreateBusinessAccountViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class CreateBusinessAccountViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnBusinessAccount: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnLookUp: UIButton!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtBusinessName: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var serviceName: SearchTextField!
    
    @IBOutlet weak var btnAddressManually: UIButton!
    @IBOutlet weak var btnShowPass: UIButton!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var addDealHeaderTitleLabel: UILabel!
    
    @IBOutlet weak var tellusLabel: UILabel!
    
    @IBOutlet weak var businessTitleLabel: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnBackUp: UIButton!
    var aryData : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Common.manually_flag = false
        
        //font size set
        addDealHeaderTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        tellusLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtName.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtEmail.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        serviceName.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtTelephone.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtPassword.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtBusinessName.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtCategory.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtPostCode.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtAddress.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        businessTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        tellusLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        btnAddressManually.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnLookUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnBusinessAccount.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        //
        
        btnBusinessAccount.layer.cornerRadius = btnBusinessAccount.frame.height/2
        btnBusinessAccount.layer.borderWidth = 2
        //        btnBusinessAccount.layer.borderColor = UIColor.darkGray.cgColor
        btnBusinessAccount.layer.borderColor = MyColor.customButtonBorderColor().cgColor
        btnBusinessAccount.isEnabled = false
        
        btnCategory.isEnabled = true
        
        btnLookUp.layer.cornerRadius = 5
        btnLookUp.isEnabled = false
        
        btnAddressManually.isEnabled = false
        
        btnBack.isEnabled = true
        btnBackUp.isEnabled  = true
        
        self.activeIndicator.isHidden = true
        
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
        
        serviceName.layer.cornerRadius = 5
        let paddingView9_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.serviceName.frame.height))
        serviceName.leftView = paddingView9_left
        serviceName.leftViewMode = UITextFieldViewMode.always
        let paddingView9_right = UIView(frame: CGRect.init(x: self.serviceName.frame.width - 15, y: 0, width: 15, height: self.serviceName.frame.height))
        serviceName.rightView = paddingView9_right
        serviceName.rightViewMode = UITextFieldViewMode.always
        
        txtTelephone.layer.cornerRadius = 5
        //add padding textfield
        let paddingView3_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtTelephone.frame.height))
        txtTelephone.leftView = paddingView3_left
        txtTelephone.leftViewMode = UITextFieldViewMode.always
        let paddingView3_right = UIView(frame: CGRect.init(x: self.txtTelephone.frame.width - 15, y: 0, width: 15, height: self.txtTelephone.frame.height))
        txtTelephone.rightView = paddingView3_right
        txtTelephone.rightViewMode = UITextFieldViewMode.always
        
        txtPassword.layer.cornerRadius = 5
        //add padding textfield
        let paddingView4_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtPassword.frame.height))
        txtPassword.leftView = paddingView4_left
        txtPassword.leftViewMode = UITextFieldViewMode.always
        let paddingView4_right = UIView(frame: CGRect.init(x: self.txtPassword.frame.width - 15, y: 0, width: 15, height: self.txtPassword.frame.height))
        txtPassword.rightView = paddingView4_right
        txtPassword.rightViewMode = UITextFieldViewMode.always
        
        txtBusinessName.layer.cornerRadius = 5
        //add padding textfield
        let paddingView5_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtBusinessName.frame.height))
        txtBusinessName.leftView = paddingView5_left
        txtBusinessName.leftViewMode = UITextFieldViewMode.always
        let paddingView5_right = UIView(frame: CGRect.init(x: self.txtBusinessName.frame.width - 15, y: 0, width: 15, height: self.txtBusinessName.frame.height))
        txtBusinessName.rightView = paddingView5_right
        txtBusinessName.rightViewMode = UITextFieldViewMode.always
        
        txtPostCode.layer.cornerRadius = 5
        //add padding textfield
        let paddingView6_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtPostCode.frame.height))
        txtPostCode.leftView = paddingView6_left
        txtPostCode.leftViewMode = UITextFieldViewMode.always
        let paddingView6_right = UIView(frame: CGRect.init(x: self.txtPostCode.frame.width - 15, y: 0, width: 15, height: self.txtPostCode.frame.height))
        txtPostCode.rightView = paddingView6_right
        txtPostCode.rightViewMode = UITextFieldViewMode.always
        
        txtAddress.layer.cornerRadius = 5
        //add padding textfield
        let paddingView7_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtAddress.frame.height))
        txtAddress.leftView = paddingView7_left
        txtAddress.leftViewMode = UITextFieldViewMode.always
        let paddingView7_right = UIView(frame: CGRect.init(x: self.txtAddress.frame.width - 15, y: 0, width: 15, height: self.txtAddress.frame.height))
        txtAddress.rightView = paddingView7_right
        txtAddress.rightViewMode = UITextFieldViewMode.always
        
        txtAddress.isHidden = true
        
        txtCategory.layer.cornerRadius = 5
        //add padding textfield
        let paddingView8_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtCategory.frame.height))
        txtCategory.leftView = paddingView8_left
        txtCategory.leftViewMode = UITextFieldViewMode.always
        let paddingView8_right = UIView(frame: CGRect.init(x: self.txtCategory.frame.width - 15, y: 0, width: 15, height: self.txtCategory.frame.height))
        txtCategory.rightView = paddingView8_right
        txtCategory.rightViewMode = UITextFieldViewMode.always
        
        //for focus to txtName
        txtName.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
        
        //for hide keyboard
        txtName.delegate = self
        txtEmail.delegate = self
        txtTelephone.delegate = self
        txtPassword.delegate = self
        txtBusinessName.delegate = self
        txtPostCode.delegate = self
        txtAddress.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateBusinessAccountViewController.KeyboardHidden))
        
        view.addGestureRecognizer(tap)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        myScrollView.contentSize.height = self.btnBusinessAccount.frame.origin.y + self.btnBusinessAccount.frame.size.height + 15
        
        get_service_names()
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
        serviceName.layer.backgroundColor = UIColor.white.cgColor
        serviceName.isEnabled = true
        txtTelephone.layer.backgroundColor = UIColor.white.cgColor
        txtTelephone.isEnabled = true
        txtPassword.layer.backgroundColor = UIColor.white.cgColor
        txtPassword.isEnabled = true
        txtBusinessName.layer.backgroundColor = UIColor.white.cgColor
        txtBusinessName.isEnabled = true
        txtCategory.layer.backgroundColor = UIColor.white.cgColor
//        txtCategory.isEnabled = true
        txtPostCode.layer.backgroundColor = UIColor.white.cgColor
        txtPostCode.isEnabled = true
        
        btnBusinessAccount.isEnabled = true
        btnBusinessAccount.layer.borderColor = UIColor.white.cgColor
        btnBusinessAccount.layer.borderWidth = 2
        btnBusinessAccount.setTitleColor(UIColor.white, for: .normal)
        
        btnShowPass.isEnabled = true
        btnCategory.isEnabled = true
        btnLookUp.isEnabled = true
        btnAddressManually.isEnabled = true
        
        tellusLabel.textColor = UIColor.white
        businessTitleLabel.textColor = UIColor.white
        
        //scroll action
//        myScrollView.contentSize.height = self.myScrollView.frame.height + 120
//        myScrollView.contentSize.height = self.btnBusinessAccount.frame.origin.y + self.btnBusinessAccount.frame.size.height + 15
        
    }
    
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
//        if textField.isEqual(txtEmail) {
//            if let _ = string.rangeOfCharacter(from: NSCharacterSet.uppercaseLetters) {
//                // Do not allow upper case letters
//                return false
//            }
//            if textField.text?.characters.first == " " || textField.text?.characters.last == " " || string == " " {
//                return false
//            }
//            
//            return true
//        }
        return true
    }
    
    // check email type valid or in valid --------------------
    func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func showPassClick(_ sender: Any) {
        
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
    
    //Back--------
    @IBAction func btnBackClick(_ sender: Any) {
        
        Common.businessSignUpModel = BusinessSignUpModel()
        Common.selectAddress = ""
        Common.manually_flag = false
        Common.category = ""
        
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
        
        Common.businessSignUpModel = BusinessSignUpModel()
        Common.selectAddress = ""
        Common.manually_flag = false
        Common.category = ""
        
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
    
    // when back from popup view to CreateBusinessAccountView, show prior textvalue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Common.selectAddress !=  "" {
            
            txtName.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.isEnabled = true
            txtEmail.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtTelephone.layer.backgroundColor = UIColor.white.cgColor
            txtTelephone.isEnabled = true
            txtTelephone.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtPassword.layer.backgroundColor = UIColor.white.cgColor
            txtPassword.isEnabled = true
            txtPassword.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtBusinessName.layer.backgroundColor = UIColor.white.cgColor
            txtBusinessName.isEnabled = true
            txtBusinessName.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtCategory.layer.backgroundColor = UIColor.white.cgColor
//            txtCategory.isEnabled = true
            txtPostCode.layer.backgroundColor = UIColor.white.cgColor
            txtPostCode.isEnabled = true
            txtPostCode.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            
            serviceName.layer.backgroundColor = UIColor.white.cgColor
            serviceName.isEnabled = true
            
            txtAddress.isHidden = false
            txtAddress.layer.backgroundColor = UIColor.white.cgColor
            if Common.manually_flag == true {
                
                txtAddress.isEnabled = true
                txtAddress.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            }
//            txtAddress.isEnabled = true
//            txtAddress.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            
            txtName.text = Common.businessSignUpModel.username
            txtEmail.text = Common.businessSignUpModel.email
            txtTelephone.text = Common.businessSignUpModel.telephone
            txtPassword.text = Common.businessSignUpModel.password
            txtBusinessName.text = Common.businessSignUpModel.business_name
            txtCategory.text = Common.businessSignUpModel.category_name
            txtPostCode.text = Common.businessSignUpModel.post_code
            txtAddress.text = Common.businessSignUpModel.address
            serviceName.text = Common.businessSignUpModel.service_name
            
            btnBusinessAccount.isEnabled = true
            btnBusinessAccount.layer.borderColor = UIColor.white.cgColor
            btnBusinessAccount.layer.borderWidth = 2
            btnBusinessAccount.setTitleColor(UIColor.white, for: .normal)
            btnCategory.isEnabled = true
            btnLookUp.isEnabled = true
            btnAddressManually.isEnabled = true
            
//            txtAddress.isHidden = false
//            txtAddress.isEnabled = false
            txtAddress.text = Common.selectAddress
//            myScrollView.contentSize.height = self.btnBusinessAccount.frame.origin.y + self.btnBusinessAccount.frame.size.height + 15
        }
        
        txtAddress.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
        
        if Common.businessSignUpModel.flag == true {
            
            txtName.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.layer.backgroundColor = UIColor.white.cgColor
            txtEmail.isEnabled = true
            txtEmail.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtTelephone.layer.backgroundColor = UIColor.white.cgColor
            txtTelephone.isEnabled = true
            txtTelephone.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtPassword.layer.backgroundColor = UIColor.white.cgColor
            txtPassword.isEnabled = true
            txtPassword.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtBusinessName.layer.backgroundColor = UIColor.white.cgColor
            txtBusinessName.isEnabled = true
            txtBusinessName.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            txtCategory.layer.backgroundColor = UIColor.white.cgColor
//            txtCategory.isEnabled = true
            txtPostCode.layer.backgroundColor = UIColor.white.cgColor
            txtPostCode.isEnabled = true
            txtPostCode.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            serviceName.layer.backgroundColor = UIColor.white.cgColor
            serviceName.isEnabled = true
            serviceName.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            
//            txtAddress.isHidden = false
            txtAddress.layer.backgroundColor = UIColor.white.cgColor
            if Common.manually_flag == true {
                
                txtAddress.isEnabled = true
                txtAddress.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            }
            //            txtAddress.isEnabled = true
            //            txtAddress.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            
            txtName.text = Common.businessSignUpModel.username
            txtEmail.text = Common.businessSignUpModel.email
            txtTelephone.text = Common.businessSignUpModel.telephone
            txtPassword.text = Common.businessSignUpModel.password
            txtBusinessName.text = Common.businessSignUpModel.business_name
            txtCategory.text = Common.category
            txtPostCode.text = Common.businessSignUpModel.post_code
            txtAddress.text = Common.businessSignUpModel.address
            serviceName.text = Common.businessSignUpModel.service_name
            
            btnBusinessAccount.isEnabled = true
            btnBusinessAccount.layer.borderColor = UIColor.white.cgColor
            btnBusinessAccount.layer.borderWidth = 2
            btnBusinessAccount.setTitleColor(UIColor.white, for: .normal)
            btnCategory.isEnabled = true
            btnLookUp.isEnabled = true
            btnAddressManually.isEnabled = true
            
            //            txtAddress.isHidden = false
            //            txtAddress.isEnabled = false
            txtAddress.text = Common.selectAddress
        }

    }
    
    //LookUp-------
    
    @objc func finishedResponse1() {
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        Common.lookup_button_flag = 1
        
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
            
            Common.businessSignUpModel.username = txtName.text
            Common.businessSignUpModel.email = txtEmail.text
            Common.businessSignUpModel.telephone = txtTelephone.text
            Common.businessSignUpModel.post_code = txtPostCode.text
            Common.businessSignUpModel.password = txtPassword.text
            Common.businessSignUpModel.business_name = txtBusinessName.text
            Common.businessSignUpModel.category_name = txtCategory.text
            Common.businessSignUpModel.address = txtAddress.text!
            Common.businessSignUpModel.service_name = serviceName.text!
            
            // remove whitespace in text
            let text = txtPostCode.text!.replacingOccurrences(of: " ", with: "")
            txtPostCode.text = text
//            txtAddress.text = ""
            
            // get address information from post_code
            var search_address = txtPostCode.text
            
            let url = "https://api.getAddress.io/find/" + search_address! + "?api-key=_GJ_sMycoUOy1_g7W2lavw10914"
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
                            
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            
                            return
                        })
                    }
                    do {
                        Common.addressModel = try AddressModel(JSONLoader(response.text!))
                        DispatchQueue.main.sync(execute: {
                            self.finishedResponse1()
                        })
                    } catch {
                        DispatchQueue.main.sync(execute: {
                            //Toast.toast("Json string error: \(error)")
                        })
                    }
                }
            } catch let error {
                DispatchQueue.main.sync(execute: {
                    //Toast.toast("Request error: \(error)")
                })
            }
            
            //            txtAddress.isHidden = false
            //            txtAddress.isEnabled = false
            
        }
        else{
            
            MessageBoxViewController.showAlert(self, title: "Alert", message: "Post Code is required")
        }

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
        
    }
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        
        Common.businessSignUpModel.username = txtName.text
        Common.businessSignUpModel.email = txtEmail.text
        Common.businessSignUpModel.telephone = txtTelephone.text
        Common.businessSignUpModel.post_code = txtPostCode.text
        Common.businessSignUpModel.password = txtPassword.text
        Common.businessSignUpModel.business_name = txtBusinessName.text
//        Common.businessSignUpModel.category_name = txtCategory.text
        Common.businessSignUpModel.address = txtAddress.text!
        Common.businessSignUpModel.service_name = serviceName.text!
        
        // popup datepicker
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessCategoryView")
        
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
    
    // for indicator finish
    
    @objc func finishedResponse() {
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.myScrollView.isUserInteractionEnabled = true
        
        Common.businessSignUpModel = BusinessSignUpModel()
        Common.selectAddress = ""
        Common.manually_flag = false
        Common.category = ""
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    //Addressmanually click
    
    @IBAction func btnAddressManuallyClick(_ sender: Any) {
        
        txtAddress.isHidden = false
        txtAddress.layer.backgroundColor = UIColor.white.cgColor
        txtAddress.isEnabled = true
        Common.manually_flag = true
        
    }
    
    //CreateBusinessAccount-------
    
    @IBAction func btnCreateBusinessAccountClick(_ sender: Any) {
        
        //check textfields is empty ---------------
        if (txtName.text?.isEmpty)! || (txtEmail.text?.isEmpty)! || (txtTelephone.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtBusinessName.text?.isEmpty)! || (txtCategory.text?.isEmpty)! || (txtPostCode.text?.isEmpty)! || (txtAddress.text?.isEmpty)! || (serviceName.text?.isEmpty)! {
            
            if (txtName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your name field is required")
            }
            if (txtEmail.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your email field is required")
            }
            if (txtTelephone.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your telephone field is required")
            }
            if (txtPassword.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your password field is required")
            }
            if (txtBusinessName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Business name field is required")
            }
            if (txtCategory.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Category name field is required")
            }
            if (serviceName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Service name field is required")
            }
            if (txtPostCode.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Post code field is required")
            }
            if (txtAddress.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Business address field is required")
            }
            
        }
        else{
            
            //check correctness of inputed data ----------------
            if isValidEmail(txtEmail.text!) == false || txtPassword.text!.characters.count < 8 {
                if isValidEmail(txtEmail.text!) == false {
                    MessageBoxViewController.showAlert(self, title: "Alert", message: "Please fill in a valid email address")
                }
                if txtPassword.text!.characters.count < 8 {
                    MessageBoxViewController.showAlert(self, title: "Alert", message: "This password is too short")
                }
            }
            else{
                
                Common.selectAddress = ""
                Common.manually_flag = false
                
                btnBack.isEnabled = false
                btnBackUp.isEnabled  = false
                btnCategory.isEnabled = false
                btnLookUp.isEnabled = false
                btnBusinessAccount.isEnabled = false
                
                // input business data to serverge
                let address = txtAddress.text
                
                print (address)
                self.activeIndicator.isHidden = false
                self.activeIndicator.startAnimating()
                self.getCoordinate(address!)
            }
            
        }
        
    }
    
    func getCoordinate( _ addressString : String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    let location1 : CLLocationCoordinate2D = location.coordinate
                    self.input_business_data(location1)
                    return
                }
            }
            
        }
    }
    
    // input data to server and get from server
    func input_business_data(_ getLocation : CLLocationCoordinate2D)
    {
        
        // -------------------------------------------------------- input data to server --------------------------------------------------------
        self.defaults.set(0, forKey: "textview_lines")
        
        var name = txtName.text
        var email = txtEmail.text
        var telephone = txtTelephone.text
        var password = txtPassword.text
        var business_name = txtBusinessName.text
        var category = txtCategory.text
        var post_code = txtPostCode.text
        var address = txtAddress.text
        var service_name = serviceName.text
        
        //from address get latitude and longitude
        var lat = String(getLocation.latitude)
        var lon = String(getLocation.longitude)
        
        var social_account = 0
        
        //up to server
        let url = Common.api_location + "business_sign_up.php"
        let params = ["username": name,
                      "email": email,
                      "telephone": telephone,
                      "password": password,
                      "business_name": business_name,
                      "category": category,
                      "post_code": post_code,
                      "address": address,
                      "lat": lat,
                      "lon": lon,
                      "social_account":social_account,
                      "service_name":service_name] as [String : Any]
        
        do {
            let opt = try HTTP.POST(url, parameters: params)
            self.activeIndicator.isHidden = false
            self.activeIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            self.myScrollView.isUserInteractionEnabled = false
            
            
            //get from server
            opt?.run { response in
                DispatchQueue.main.sync(execute: {
                    self.view.isUserInteractionEnabled = true
                    self.myScrollView.isUserInteractionEnabled = true
                    
                    self.activeIndicator.stopAnimating()
                    self.activeIndicator.isHidden = true
                    
                    self.btnBack.isEnabled = true
                    self.btnBackUp.isEnabled  = true
                    self.btnCategory.isEnabled = true
                    self.btnLookUp.isEnabled = true
                    self.btnBusinessAccount.isEnabled = true
                })
                
                if let error = response.error {
                    DispatchQueue.main.sync(execute: {
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        return
                    })
                }
                do {
                    print (response.text!)
                    Common.businessModel = try BusinessModel(JSONLoader(response.text!))
                    if Common.businessModel.success == "true" {
                        self.defaults.set("2", forKey: "user_type")
                        self.defaults.set(Common.businessModel.user_id, forKey: "user_id")
                        DispatchQueue.main.sync(execute: {
                            // when create, remember to iphone device
                        
                            self.finishedResponse()
                        })
                    } else {
                        DispatchQueue.main.sync(execute: {
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                        })
                    }
                } catch {
                    DispatchQueue.main.sync(execute: {
                        //Toast.toast("Json string error: \(error)")
                    })
                }
            }
        } catch let error {
            DispatchQueue.main.sync(execute: {
                //Toast.toast("Request error: \(error)")
            })
        }
        // =======================================================================================================================================
    }
    

    func get_service_names()
    {
        let url = Common.api_location + "get_service_name.php"
        let params = [:] as [String : Any]

        do {
            let opt = try HTTP.GET(url)

            opt?.run { response in
                if let error = response.error {
                    return
                }
                do {
                    let decoder: JSONLoader = JSONLoader(response.text!)
                    guard let decoderArray = decoder.getOptionalArray() else {throw JSONError.wrongType}
                    self.aryData.removeAll()
                    for decoderT in decoderArray {
                        let service_name: String! = try decoderT.get() as String
                        self.aryData.append(service_name)
                    }

                    DispatchQueue.main.sync(execute: {
                        self.serviceName.delegate = self
                        self.serviceName.filterStrings(self.aryData)
                    })
                } catch {
                    DispatchQueue.main.sync(execute: {
                        //Toast.toast("Json string error: \(error)")
                    })
                }
            }
        } catch let error {
            DispatchQueue.main.sync(execute: {
                //Toast.toast("Request error: \(error)")
            })
        }
    }
    
}
