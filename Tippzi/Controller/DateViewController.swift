//
//  DateViewController.swift
//  Tippzi
//
//  Created by Admin on 11/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    var select_index : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDone.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnCancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        
        datePicker.setValue(UIColor.white, forKey: "textColor")

    }
        
    @IBAction func btnOkClick(_ sender: Any) {
        
        let date = Date() // get date of now

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateString = dateFormatter.string(from: datePicker.date)
        let getDateString = Common.getDate(startDateString)
        
        ////
        let startDate = dateFormatter.date(from: startDateString)
        switch date.compare(startDate!) {
        case .orderedAscending     :   select_index = 1
        case .orderedDescending    :   select_index = 2
        case .orderedSame          :   select_index = 3
        }
        print(select_index)
        if select_index == 2 {
            MessageBoxViewController.showAlert(self, title: "Alert", message: "You can't select past time.")
        } else {
            if Common.dealModel.add_deal_flag == 0 {
                Common.dealModel.deal_duration = getDateString
            }
            else{
                Common.dealModel.deal_duration1 = getDateString
            }
            
            // go to previous page
            gotoPreviousPage()
        }
    }
 
    func gotoPreviousPage() {

        Common.dealModel.flag = 1
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddDealView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    
    }
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
