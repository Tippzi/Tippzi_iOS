//
//  GenderViewController.swift
//  Tippzi
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var MyView: UIView!
    @IBOutlet weak var dropdown: UIPickerView!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var gender_string : String = ""
    
    var gender = ["Select your sex", "Male", "Female"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let countrows : Int = gender.count
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleRow = gender[row]
        return titleRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.gender_string = self.gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.gender[row]
        pickerLabel?.textColor = UIColor.darkGray
        
        return pickerLabel!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyView.layer.masksToBounds = true
        
    }
    
    func gotoPreviousPage() {
        
        Common.customerSignUpModel.flag = true
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateGuestAccountView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @IBAction func Done(_ sender: Any) {
        
        if self.gender_string == "Male" || self.gender_string == "Female"{
            
            Common.gender = self.gender_string
            gotoPreviousPage()
        }
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
