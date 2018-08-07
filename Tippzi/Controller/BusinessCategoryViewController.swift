//
//  CategoryViewController.swift
//  Tippzi
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class BusinessCategoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var dropdown: UIPickerView!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var MyView: UIView!
    
    var category_string : String = ""
    
    var category = ["Select your category", "Nightlife", "Health & Fitness", "Hair & Beauty"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let countrows : Int = category.count
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleRow = category[row]
        return titleRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.category_string = self.category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.category[row]
        pickerLabel?.textColor = UIColor.darkGray
        
        return pickerLabel!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyView.layer.masksToBounds = true
        
    }

    func gotoPreviousPage() {
        
        Common.businessSignUpModel.flag = true
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateBusinessAccountView")
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
        
        if self.category_string == "Nightlife" || self.category_string == "Health & Fitness" || self.category_string == "Hair & Beauty" {
            
            Common.category = self.category_string
            gotoPreviousPage()
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
