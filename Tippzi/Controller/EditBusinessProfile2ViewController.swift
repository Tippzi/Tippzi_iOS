//
//  EditBusinessProfile2ViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class EditBusinessProfile2ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
   
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var labBusinessName: UILabel!
    
    @IBOutlet weak var txtMusicType: UITextField!
    
    @IBOutlet weak var btnContinue: UIButton!
    
    
    @IBOutlet weak var edit2HeaderTitleLabel: UILabel!
    
    @IBOutlet weak var edit2briefTitleLabel: UILabel!
    
    @IBOutlet weak var edit2musicTitleLabel: UILabel!
    
    @IBOutlet weak var edit2commaLabel: UILabel!
    
    var lines : Int = 0
    var description_text : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activeIndicator.isHidden = true

        if Common.editBarModel.category_name != "Nightlife" {
            edit2commaLabel.isHidden = true
            txtMusicType.isHidden = true
            edit2musicTitleLabel.isHidden = true
        }
        //font size set
        
        labBusinessName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        txtDescription.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        txtMusicType.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        edit2HeaderTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        edit2briefTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        edit2musicTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        edit2commaLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bottom_labelfont))
        
        btnContinue.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        //
        labBusinessName.text = Common.editBarModel.business_name
        
        btnContinue.layer.cornerRadius = btnContinue.frame.height/2
        btnContinue.layer.borderColor = UIColor.white.cgColor
        btnContinue.layer.borderWidth = 2
        
        txtDescription.layer.cornerRadius = 5
        //add padding textview
        txtDescription.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        txtDescription.textContainer.lineFragmentPadding = 5
        txtMusicType.layer.cornerRadius = 5
        
        //add padding textfield
        let paddingView_left = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.txtMusicType.frame.height))
        txtMusicType.leftView = paddingView_left
        txtMusicType.leftViewMode = UITextFieldViewMode.always
        let paddingView_right = UIView(frame: CGRect.init(x: self.txtMusicType.frame.width - 15, y: 0, width: 15, height: self.txtMusicType.frame.height))
        txtMusicType.rightView = paddingView_right
        txtMusicType.rightViewMode = UITextFieldViewMode.always
        
        if Common.editBarModel.description == "" {
            txtDescription.text = "Description"
            txtDescription.textColor = UIColor.lightGray
        } else {
            txtDescription.text = Common.editBarModel.description
        }
        txtDescription.delegate = self
        
//            Common.change_text_dark_color(txtDescription)
        txtMusicType.text = Common.editBarModel.music_type
        
        txtDescription.selectedTextRange = txtDescription.textRange(from: txtDescription.beginningOfDocument, to: txtDescription.beginningOfDocument)
        
//            Common.change_text_dark_color(txtMusicType)
        
        //for hide keyboard
        
        txtMusicType.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditBusinessProfile2ViewController.KeyboardHidden))
        
        view.addGestureRecognizer(tap)
        
        //scroll action
        myScrollView.contentSize.height = self.myScrollView.frame.height
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text
        let updatedText = (textView.text as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.darkGray
        }
        let numberOfChars = updatedText.characters.count
        if numberOfChars > 500 {
            return false
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
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
    
    
    
    func finishedResponse() {
        
//        self.view.isUserInteractionEnabled = true
//        
//        timer.invalidate()
//        
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
        self.finishedResponse()
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
//        self.activeIndicator.isHidden = false
//        self.activeIndicator.startAnimating()
        
    }
    
    @IBAction func btnUpClick(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile1")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
       
    }
    
    // Continue
    @IBAction func btnContinueClick(_ sender: Any) {
        Common.editBarModel.description = txtDescription.text!
        if Common.editBarModel.category_name != "Nightlife" {
            Common.editBarModel.music_type = ""
            Common.editBarModel.textview_lines = 0
        } else {
            Common.editBarModel.music_type = txtMusicType.text!
            Common.editBarModel.textview_lines = self.lines
        }
        
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile3")
        
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

//extension UITextView {
//    var numberOfVisibleLines: Int {
//        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
//        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
//        let charSize: Int = lroundf(Float(self.font!.pointSize))
//        return rHeight / charSize
//    }
//}
