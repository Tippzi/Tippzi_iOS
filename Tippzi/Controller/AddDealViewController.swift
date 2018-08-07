//
//  AddDealViewController.swift
//  Tippzi
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

private var maxLengths = [UITextField: Int]()

class AddDealViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var btnAddDeal: UIButton!
    
    @IBOutlet weak var txtDealName: UITextField!
    @IBOutlet weak var txtDealDescription: UITextView!
    @IBOutlet weak var txtDealDuration: UITextField!
    @IBOutlet weak var txtDealQuantity: UITextField!
    
    @IBOutlet weak var btnMonday: UIButton!
    @IBOutlet weak var btnTuesday: UIButton!
    @IBOutlet weak var btnWednesday: UIButton!
    @IBOutlet weak var btnThursday: UIButton!
    @IBOutlet weak var btnFriday: UIButton!
    @IBOutlet weak var btnSaturday: UIButton!
    @IBOutlet weak var btnSunday: UIButton!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var labBusinessName: UILabel!
    @IBOutlet weak var btnDuration: UIButton!
    @IBOutlet weak var labTitle: UILabel!
    
    @IBOutlet weak var adddeal_label1: UILabel!
    @IBOutlet weak var adddeal_label2: UILabel!
    
    @IBOutlet weak var btnSelectAllDays: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnBackUp: UIButton!
    
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    //for day value(bool)
    var v_monday : String? = ""
    var v_tuesday : String? = ""
    var v_wednesday : String? = ""
    var v_thursday : String? = ""
    var v_friday : String? = ""
    var v_saturday : String? = ""
    var v_sunday : String? = ""
    
    var all_days_flag : Bool = false
    
    // start
    override func viewDidLoad() {
        super.viewDidLoad()
        //font size set
        //        myaccountLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        labTitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        labBusinessName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        adddeal_label1.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        adddeal_label2.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtDealName.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtDealDescription.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtDealDuration.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtDealQuantity.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        btnAddDeal.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnMonday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnTuesday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnWednesday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnThursday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnFriday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnSaturday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnSunday.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        btnSelectAllDays.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        //
        labBusinessName.text = Common.businessModel.bars[0].business_name
        //        if Common.add_deal_flag == 0 {
        
        btnAddDeal.isEnabled = false
        btnDuration.isEnabled = false
        
        btnMonday.isEnabled = false
        btnTuesday.isEnabled = false
        btnWednesday.isEnabled = false
        btnThursday.isEnabled = false
        btnFriday.isEnabled = false
        btnSaturday.isEnabled = false
        btnSunday.isEnabled = false
        
        //        }
        btnAddDeal.layer.cornerRadius = btnAddDeal.frame.height/2
        btnAddDeal.layer.borderWidth = 2
        btnAddDeal.layer.borderColor = UIColor.white.cgColor
        
        btnBack.isEnabled = true
        btnBackUp.isEnabled = true
        
        self.activeIndicator.isHidden = true
        
        txtDealName.layer.cornerRadius = 5
        //txtDealName.layer..UIFont.boldSystemFont(ofSize: 15.0)
        //add padding textfield
        let paddingView1_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtDealName.frame.height))
        txtDealName.leftView = paddingView1_left
        txtDealName.leftViewMode = UITextFieldViewMode.always
        let paddingView1_right = UIView(frame: CGRect.init(x: self.txtDealName.frame.width - 15, y: 0, width: 15, height: self.txtDealName.frame.height))
        txtDealName.rightView = paddingView1_right
        txtDealName.rightViewMode = UITextFieldViewMode.always
        
        txtDealDescription.layer.cornerRadius = 5
        //add padding textfield
        txtDealDescription.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        txtDealDuration.layer.cornerRadius = 5
        //add padding textfield
        let paddingView2_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtDealDuration.frame.height))
        txtDealDuration.leftView = paddingView2_left
        txtDealDuration.leftViewMode = UITextFieldViewMode.always
        let paddingView2_right = UIView(frame: CGRect.init(x: self.txtDealDuration.frame.width - 15, y: 0, width: 15, height: self.txtDealDuration.frame.height))
        txtDealDuration.rightView = paddingView2_right
        txtDealDuration.rightViewMode = UITextFieldViewMode.always
        
        txtDealQuantity.layer.cornerRadius = 5
        //add padding textfield
        let paddingView3_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtDealQuantity.frame.height))
        txtDealQuantity.leftView = paddingView3_left
        txtDealQuantity.leftViewMode = UITextFieldViewMode.always
        let paddingView3_right = UIView(frame: CGRect.init(x: self.txtDealQuantity.frame.width - 15, y: 0, width: 15, height: self.txtDealQuantity.frame.height))
        txtDealQuantity.rightView = paddingView3_right
        txtDealQuantity.rightViewMode = UITextFieldViewMode.always
        
        btnMonday.layer.masksToBounds = true
        btnMonday.layer.cornerRadius = 5
        btnTuesday.layer.masksToBounds = true
        btnTuesday.layer.cornerRadius = 5
        btnWednesday.layer.masksToBounds = true
        btnWednesday.layer.cornerRadius = 5
        btnThursday.layer.masksToBounds = true
        btnThursday.layer.cornerRadius = 5
        btnFriday.layer.masksToBounds = true
        btnFriday.layer.cornerRadius = 5
        btnSaturday.layer.masksToBounds = true
        btnSaturday.layer.cornerRadius = 5
        btnSunday.layer.masksToBounds = true
        btnSunday.layer.cornerRadius = 5
        
        //for move txt cursor to txtDealName ------------
        txtDealName.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
        
        //for hide keyboard
        txtDealName.delegate = self
        txtDealDescription.delegate = self
        txtDealDuration.delegate = self
        txtDealQuantity.delegate = self
        //        txtDealQuantity.maxLength = 4
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddDealViewController.KeyboardHidden))
        
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
    
    //all control editable -----------
    
    @objc func TextFieldEnabled(_ textField : UITextField) {
        
        txtDealName.layer.backgroundColor = UIColor.white.cgColor
        txtDealDescription.layer.backgroundColor = UIColor.white.cgColor
        txtDealDescription.isEditable = true
        txtDealDuration.layer.backgroundColor = UIColor.white.cgColor
        
        txtDealQuantity.layer.backgroundColor = UIColor.white.cgColor
        txtDealQuantity.isEnabled = true
        
        btnAddDeal.isEnabled = true
        btnDuration.isEnabled = true
        
        btnMonday.isEnabled = true
        btnTuesday.isEnabled = true
        btnWednesday.isEnabled = true
        btnThursday.isEnabled = true
        btnFriday.isEnabled = true
        btnSaturday.isEnabled = true
        btnSunday.isEnabled = true
        
        btnSelectAllDays.isEnabled = true
        btnSelectAllDays.setTitle("Select all days", for: .normal)
        
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
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool
    {
        if (textView.isFirstResponder)
        {
            if textView.textInputMode?.primaryLanguage == "emoji" || !(((textView.textInputMode?.primaryLanguage) != nil))
            {
                return false
            }
        }
        return true
    }
    
    @IBAction func btnSelectAllDaysClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0{ // add deal
            
            if all_days_flag == false {
                
                Common.dealModel.monday = "True"
                btnMonday.backgroundColor = UIColor.white
                Common.dealModel.tuesday = "True"
                btnTuesday.backgroundColor = UIColor.white
                Common.dealModel.wednesday = "True"
                btnWednesday.backgroundColor = UIColor.white
                Common.dealModel.thursday = "True"
                btnThursday.backgroundColor = UIColor.white
                Common.dealModel.friday = "True"
                btnFriday.backgroundColor = UIColor.white
                Common.dealModel.saturday = "True"
                btnSaturday.backgroundColor = UIColor.white
                Common.dealModel.sunday = "True"
                btnSunday.backgroundColor = UIColor.white
                
                all_days_flag = true
                btnSelectAllDays.setTitle("Deselect all days", for: .normal)
            }
            else{
                
                Common.dealModel.monday = ""
                btnMonday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.tuesday = ""
                btnTuesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.wednesday = "Tre"
                btnWednesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.thursday = ""
                btnThursday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.friday = ""
                btnFriday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.saturday = ""
                btnSaturday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.sunday = ""
                btnSunday.backgroundColor = MyColor.customdayunselectColor()
                
                all_days_flag = false
                btnSelectAllDays.setTitle("Select all days", for: .normal)
            }
        }
        else if Common.dealModel.add_deal_flag == 1{ // edit deal
            
            if all_days_flag == false {
                
                Common.dealModel.monday1 = "True"
                btnMonday.backgroundColor = UIColor.white
                Common.dealModel.tuesday1 = "True"
                btnTuesday.backgroundColor = UIColor.white
                Common.dealModel.wednesday1 = "True"
                btnWednesday.backgroundColor = UIColor.white
                Common.dealModel.thursday1 = "True"
                btnThursday.backgroundColor = UIColor.white
                Common.dealModel.friday1 = "True"
                btnFriday.backgroundColor = UIColor.white
                Common.dealModel.saturday1 = "True"
                btnSaturday.backgroundColor = UIColor.white
                Common.dealModel.sunday1 = "True"
                btnSunday.backgroundColor = UIColor.white
                
                all_days_flag = true
                btnSelectAllDays.setTitle("Deselect all days", for: .normal)
            }
            else{
                
                Common.dealModel.monday1 = ""
                btnMonday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.tuesday1 = ""
                btnTuesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.wednesday1 = ""
                btnWednesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.thursday1 = ""
                btnThursday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.friday1 = ""
                btnFriday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.saturday1 = ""
                btnSaturday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.sunday1 = ""
                btnSunday.backgroundColor = MyColor.customdayunselectColor()
                
                all_days_flag = false
                btnSelectAllDays.setTitle("Select all days", for: .normal)
            }
        }
        
        
    }
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
    
    //back
    
    @objc func finishedResponse1() {
        
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
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
            self.present(toViewController!, animated: false, completion:nil)
        }
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        format()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
    }
    
    
    @IBAction func btnUpClick(_ sender: Any) {
        
        format()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
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
        
        if let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView") {
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController, animated: true, completion: nil)
        }
    }
    
    // day buttons click
    @IBAction func btnMondayClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.monday == "") {
                Common.dealModel.monday = "True"
                btnMonday.backgroundColor = UIColor.white
            }
            else{
                btnMonday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.monday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1 {
            if (Common.dealModel.monday1 == "") {
                Common.dealModel.monday1 = "True"
                btnMonday.backgroundColor = UIColor.white
            }
            else{
                btnMonday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.monday1 = ""
            }
        }
    }
    
    @IBAction func btnTuesdayClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.tuesday == "") {
                btnTuesday.backgroundColor = UIColor.white
                Common.dealModel.tuesday = "True"
            }
            else{
                btnTuesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.tuesday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1 {
            if (Common.dealModel.tuesday1 == "") {
                btnTuesday.backgroundColor = UIColor.white
                Common.dealModel.tuesday1 = "True"
            }
            else{
                btnTuesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.tuesday1 = ""
            }
        }
    }
    
    @IBAction func btnWednesdayClick(_ sender: Any) {
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.wednesday == "") {
                btnWednesday.backgroundColor = UIColor.white
                Common.dealModel.wednesday = "True"
            }
            else{
                btnWednesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.wednesday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1  {
            if (Common.dealModel.wednesday1 == "") {
                btnWednesday.backgroundColor = UIColor.white
                Common.dealModel.wednesday1 = "True"
            }
            else{
                btnWednesday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.wednesday1 = ""
            }
        }
    }
    
    @IBAction func btnThursdayClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.thursday == "") {
                btnThursday.backgroundColor = UIColor.white
                Common.dealModel.thursday = "True"
            }
            else{
                btnThursday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.thursday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1 {
            if (Common.dealModel.thursday1 == "") {
                btnThursday.backgroundColor = UIColor.white
                Common.dealModel.thursday1 = "True"
            }
            else{
                btnThursday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.thursday1 = ""
            }
        }
    }
    
    @IBAction func btnFridayClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.friday == "") {
                btnFriday.backgroundColor = UIColor.white
                Common.dealModel.friday = "True"
            }
            else{
                btnFriday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.friday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1 {
            if (Common.dealModel.friday1 == "") {
                btnFriday.backgroundColor = UIColor.white
                Common.dealModel.friday1 = "True"
            }
            else{
                btnFriday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.friday1 = ""
            }
        }
    }
    
    @IBAction func btnSaturdayClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.saturday == "") {
                btnSaturday.backgroundColor = UIColor.white
                Common.dealModel.saturday = "True"
            }
            else{
                btnSaturday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.saturday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1 {
            if (Common.dealModel.saturday1 == "") {
                btnSaturday.backgroundColor = UIColor.white
                Common.dealModel.saturday1 = "True"
            }
            else{
                btnSaturday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.saturday1 = ""
            }
        }
        
    }
    
    @IBAction func btnSundayClick(_ sender: Any) {
        
        if Common.dealModel.add_deal_flag == 0 {
            if (Common.dealModel.sunday == "") {
                btnSunday.backgroundColor = UIColor.white
                Common.dealModel.sunday = "True"
            }
            else{
                btnSunday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.sunday = ""
            }
        }
        else if Common.dealModel.add_deal_flag == 1 {
            if (Common.dealModel.sunday1 == "") {
                btnSunday.backgroundColor = UIColor.white
                Common.dealModel.sunday1 = "True"
            }
            else{
                btnSunday.backgroundColor = MyColor.customdayunselectColor()
                Common.dealModel.sunday1 = ""
            }
        }
    }
    
    // go to pop up datepicker view
    @IBAction func btnDurationClick(_ sender: Any) {
        
        Common.dealModel.all_days_flag = all_days_flag
        
        if Common.dealModel.add_deal_flag == 0 {
            
            Common.dealModel.deal_name = txtDealName.text
            Common.dealModel.deal_description = txtDealDescription.text
            Common.dealModel.deal_quantity = txtDealQuantity.text
            Common.dealModel.deal_duration = txtDealDuration.text
            
        }
        else if Common.dealModel.add_deal_flag == 1 {
            
            Common.dealModel.deal_name1 = txtDealName.text
            Common.dealModel.deal_description1 = txtDealDescription.text
            Common.dealModel.deal_quantity1 = txtDealQuantity.text
            Common.dealModel.deal_duration1 = txtDealDuration.text
            
        }
        
        // popup datepicker
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "DateView")
        
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
    
    //Add a Deal button Click
    @IBAction func btnAddDealClick(_ sender: Any) {
        var deal_qty = txtDealQuantity.text
        //check textfields is empty ---------------
        if (txtDealName.text?.isEmpty)! || (txtDealDescription.text?.isEmpty)! || (txtDealDuration.text?.isEmpty)! || (txtDealQuantity.text?.isEmpty)! ||  deal_qty == "0" {
            
            if (txtDealName.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your deal field is required")
            }
            if (txtDealDescription.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Description field is required")
            }
            if (txtDealDuration.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Duration field is required")
            }
            if (txtDealQuantity.text?.isEmpty)! {
                
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Quantity field is required")
            }
            var deal_qty = txtDealQuantity.text
            if Int(deal_qty!) == 0 {
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Quantity field is required")
            }
        }
        else{
            
            if Common.dealModel.add_deal_flag == 0 {
                
                btnBack.isEnabled = false
                btnBackUp.isEnabled = false
                btnAddDeal.isEnabled = false
                
                add_deal_data()
            }
            else  {  //add_deal_flag == 1
                
                btnBack.isEnabled = false
                btnBackUp.isEnabled = false
                btnAddDeal.isEnabled = false
                
                // add deal data to server
                edit_deal_data()
            }
            
        }
        
        format()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // when back from DateViewController, represent data
        
        //  add_deal_flag == 0  :  dashboard(add deal button click)
        //  add_deal_flag == 1  :  dashboard(edit deal button click)
        //  flag == 1  :           dateview(pickdate click)
        
        if Common.dealModel.add_deal_flag == 0 && Common.dealModel.flag == 1 { // from datePicker
            
            txtDealName.text =  Common.dealModel.deal_name
            txtDealDescription.text = Common.dealModel.deal_description
            txtDealQuantity.text =  Common.dealModel.deal_quantity
            txtDealDuration.text = Common.dealModel.deal_duration
            all_days_flag = Common.dealModel.all_days_flag
            
            if all_days_flag == true {
                btnSelectAllDays.setTitle("Deselecet all days", for: .normal)
            }
            
            txtDealName.backgroundColor = UIColor.white
            txtDealDescription.isEditable = true
            txtDealDescription.backgroundColor = UIColor.white
            //            txtDealDescription.addTarget(self, action: #selector(TextViewEnabled), for: .editingDidBegin)
            //            txtDealDescription.target(forAction: #selector(TextViewEnabled), withSender: <#T##Any?#>)
            
            txtDealQuantity.isEnabled = true
            txtDealQuantity.backgroundColor = UIColor.white
            //            txtDealQuantity.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            //            txtDealDuration.isEnabled = true
            txtDealDuration.backgroundColor = UIColor.white
            
            if Common.dealModel.monday == "True" {
                
                btnMonday.backgroundColor = UIColor.white
            }
            if Common.dealModel.tuesday == "True" {
                
                btnTuesday.backgroundColor = UIColor.white
            }
            if Common.dealModel.wednesday == "True" {
                
                btnWednesday.backgroundColor = UIColor.white
            }
            if Common.dealModel.thursday == "True" {
                
                btnThursday.backgroundColor = UIColor.white
            }
            if Common.dealModel.friday == "True" {
                
                btnFriday.backgroundColor = UIColor.white
            }
            if Common.dealModel.saturday == "True" {
                
                btnSaturday.backgroundColor = UIColor.white
            }
            if Common.dealModel.sunday == "True" {
                
                btnSunday.backgroundColor = UIColor.white
            }
            
            btnMonday.isEnabled = true
            btnTuesday.isEnabled = true
            btnWednesday.isEnabled = true
            btnThursday.isEnabled = true
            btnFriday.isEnabled = true
            btnSaturday.isEnabled = true
            btnSunday.isEnabled = true
            btnDuration.isEnabled = true
            btnAddDeal.isEnabled = true
            btnSelectAllDays.isEnabled = true
            
        }
        if Common.dealModel.add_deal_flag == 1 { // dashboard edit deal click
            
            labTitle.text = "Edit Deal"
            txtDealName.text =  Common.businessModel.bars[0].deal[Common.businessDash_index].title
            txtDealDescription.text = Common.businessModel.bars[0].deal[Common.businessDash_index].description
            txtDealQuantity.text =  Common.businessModel.bars[0].deal[Common.businessDash_index].qty
            txtDealDuration.text = Common.businessModel.bars[0].deal[Common.businessDash_index].duration
            
            txtDealName.backgroundColor = UIColor.white
            txtDealDescription.isEditable = true
            txtDealDescription.backgroundColor = UIColor.white
            txtDealQuantity.isEnabled = true
            txtDealQuantity.backgroundColor = UIColor.white
            //            txtDealQuantity.addTarget(self, action: #selector(TextFieldEnabled), for: .editingDidBegin)
            //            txtDealDuration.isEnabled = true
            txtDealDuration.backgroundColor = UIColor.white
            
            if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.monday == "true" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.tuesday == "true" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.wednesday == "true" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.thursday == "true" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.friday == "true" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.saturday == "true" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.sunday == "true" {
                
                all_days_flag = true
                btnSelectAllDays.setTitle("Deselect all days", for: .normal)
            }
            
            if  Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.monday == "false" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.tuesday == "false" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.wednesday == "false" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.thursday == "false" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.friday == "false" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.saturday == "false" &&
                Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.sunday == "false" {
                
                all_days_flag = false
                btnSelectAllDays.setTitle("Select all days", for: .normal)
            }
            
            if Common.dealModel.flag == 0 {
                
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.monday == "true" {
                    
                    btnMonday.backgroundColor = UIColor.white
                    Common.dealModel.monday1 = "True"
                    
                }
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.tuesday == "true" {
                    
                    btnTuesday.backgroundColor = UIColor.white
                    Common.dealModel.tuesday1 = "True"
                }
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.wednesday == "true" {
                    
                    btnWednesday.backgroundColor = UIColor.white
                    Common.dealModel.wednesday1 = "True"
                }
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.thursday == "true" {
                    
                    btnThursday.backgroundColor = UIColor.white
                    Common.dealModel.thursday1 = "True"
                }
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.friday == "true" {
                    
                    btnFriday.backgroundColor = UIColor.white
                    Common.dealModel.friday1 = "True"
                }
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.saturday == "true" {
                    
                    btnSaturday.backgroundColor = UIColor.white
                    Common.dealModel.saturday1 = "True"
                }
                if Common.businessModel.bars[0].deal[Common.businessDash_index].deal_days?.sunday == "true" {
                    
                    btnSunday.backgroundColor = UIColor.white
                    Common.dealModel.sunday1 = "True"
                }
            }
            
            
            btnMonday.isEnabled = true
            btnTuesday.isEnabled = true
            btnWednesday.isEnabled = true
            btnThursday.isEnabled = true
            btnFriday.isEnabled = true
            btnSaturday.isEnabled = true
            btnSunday.isEnabled = true
            btnDuration.isEnabled = true
            btnAddDeal.setTitle("Edit Deal",for: .normal)
            btnAddDeal.isEnabled = true
            btnSelectAllDays.isEnabled = true
            
            if Common.dealModel.flag == 1 { // from datepicker
                
                txtDealName.text =  Common.dealModel.deal_name1
                txtDealDescription.text = Common.dealModel.deal_description1
                txtDealQuantity.text = Common.dealModel.deal_quantity1
                txtDealDuration.text = Common.dealModel.deal_duration1
                
                self.all_days_flag = Common.dealModel.all_days_flag
                
                if Common.dealModel.monday1 == "True" {
                    btnMonday.backgroundColor = UIColor.white
                }
                if Common.dealModel.tuesday1 == "True" {
                    btnTuesday.backgroundColor = UIColor.white
                }
                if Common.dealModel.wednesday1 == "True" {
                    btnWednesday.backgroundColor = UIColor.white
                }
                if Common.dealModel.thursday1 == "True" {
                    btnThursday.backgroundColor = UIColor.white
                }
                if Common.dealModel.friday1 == "True" {
                    btnFriday.backgroundColor = UIColor.white
                }
                if Common.dealModel.saturday1 == "True" {
                    btnSaturday.backgroundColor = UIColor.white
                }
                if Common.dealModel.sunday1 == "True" {
                    btnSunday.backgroundColor = UIColor.white
                }
                
            }
        }
        
        
    }
    
    func format()
    {
        
        Common.dealModel.deal_name = ""
        Common.dealModel.deal_description = ""
        Common.dealModel.deal_quantity = ""
        Common.dealModel.deal_duration = ""
        Common.dealModel.monday = ""
        Common.dealModel.tuesday = ""
        Common.dealModel.wednesday = ""
        Common.dealModel.thursday = ""
        Common.dealModel.friday = ""
        Common.dealModel.saturday = ""
        Common.dealModel.sunday = ""
        
        Common.dealModel.deal_name1 = ""
        Common.dealModel.deal_description1 = ""
        Common.dealModel.deal_quantity1 = ""
        Common.dealModel.deal_duration1 = ""
        Common.dealModel.monday1 = ""
        Common.dealModel.tuesday1 = ""
        Common.dealModel.wednesday1 = ""
        Common.dealModel.thursday1 = ""
        Common.dealModel.friday1 = ""
        Common.dealModel.saturday1 = ""
        Common.dealModel.sunday1 = ""
        
        Common.dealModel.flag = 0
        
    }
    
    
    //    // add data to server and get from server
    func add_deal_data()
    {
        
        // ----------------------------------------------- add data to server --------------------------------------------------------
        var dict: Dictionary = ["monday" : Common.dealModel.monday,
                                "tuesday" : Common.dealModel.tuesday,
                                "wednesday" : Common.dealModel.wednesday,
                                "thursday" : Common.dealModel.thursday,
                                "friday" : Common.dealModel.friday,
                                "saturday" : Common.dealModel.saturday,
                                "sunday" : Common.dealModel.sunday]
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        

        
        var user_id = Common.businessModel.user_id
        var bar_id = Common.businessModel.bars[0].bar_id
        var deal_name = txtDealName.text
        var deal_description = txtDealDescription.text
        var deal_duration = txtDealDuration.text
        var deal_quantity = txtDealQuantity.text

        //up to server
        let url = Common.api_location + "add_deal.php"
  
        let params = ["user_id": user_id,
                      "bar_id": bar_id,
                      "title": deal_name,
                      "description": deal_description,
                      "duration": deal_duration,
                      "qty": deal_quantity,
                      "deal_days": dict] as [String : Any]
        
        
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
                        self.btnAddDeal.isEnabled = true
                        
                        return
                    })
                    
                }
                var businessModel1 = BusinessModel()
                do {
                    businessModel1 = try BusinessModel(JSONLoader(response.text!))
                    if businessModel1.success == "true" {
                        self.flag = true
                        Common.businessModel = businessModel1
                    } else {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: businessModel1.message!)
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            self.btnBack.isEnabled = true
                            self.btnBackUp.isEnabled = true
                            self.btnAddDeal.isEnabled = true
                            
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
    }
    
    func edit_deal_data()
    {
        
        // ----------------------------------------------- update data to server --------------------------------------------------------
        var dict: Dictionary = ["monday" : Common.dealModel.monday1,
                                "tuesday" : Common.dealModel.tuesday1,
                                "wednesday" : Common.dealModel.wednesday1,
                                "thursday" : Common.dealModel.thursday1,
                                "friday" : Common.dealModel.friday1,
                                "saturday" : Common.dealModel.saturday1,
                                "sunday" : Common.dealModel.sunday1]
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        
        var user_id = Common.businessModel.user_id
        var bar_id = Common.businessModel.bars[0].bar_id
        var deal_id = Common.businessModel.bars[0].deal[Common.businessDash_index].deal_id
        var deal_name = txtDealName.text
        var deal_description = txtDealDescription.text
        var deal_duration = txtDealDuration.text
        var deal_quantity = txtDealQuantity.text
        
        //        var deal_mon = Common.dealModel.monday
        //        var deal_tue = Common.dealModel.tuesday
        //        var deal_wed = Common.dealModel.wednesday
        //        var deal_thu = Common.dealModel.thursday
        //        var deal_fri = Common.dealModel.friday
        //        var deal_sat = Common.dealModel.saturday
        //        var deal_sun = Common.dealModel.sunday
        
        
        //up to server
        let url = Common.api_location + "edit_deal.php"
        //        let params = ["user_id": user_id,
        //                      "bar_id": bar_id,
        //                      "title": deal_name,
        //                      "description": deal_description,
        //                      "duration": deal_duration,
        //                      "qty": deal_quantity,
        //                      "monday": deal_mon,
        //                      "tuesday": deal_tue,
        //                      "wednesday": deal_wed,
        //                      "thursday": deal_thu,
        //                      "friday": deal_fri,
        //                      "saturday": deal_sat,
        //                      "sunday": deal_sun] as [String : Any]
        let params = ["user_id": user_id,
                      "bar_id": bar_id,
                      "deal_id": deal_id,
                      "title": deal_name,
                      "description": deal_description,
                      "duration": deal_duration,
                      "qty": deal_quantity,
                      "deal_days": dict] as [String : Any]
        
        
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
                        self.btnAddDeal.isEnabled = true
                        
                        return
                    })
                    
                }
                do {
                    
                    Common.businessModel = try BusinessModel(JSONLoader(response.text!))
                    if Common.businessModel.success == "true" {
                        self.flag = true
                        
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            self.btnBack.isEnabled = true
                            self.btnBackUp.isEnabled = true
                            self.btnAddDeal.isEnabled = true
                            
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
    }
    
    
}

extension UITextField {
    
    // 3
    @IBInspectable var maxLength: Int {
        get {
            // 4
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            // 5
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControlEvents.editingChanged
            )
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        // 6
        guard let prospectiveText = textField.text,
            prospectiveText.characters.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        // 7
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
    
}



