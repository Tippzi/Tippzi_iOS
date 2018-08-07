//
//  EditBusinessProfile3ViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class EditBusinessProfile3ViewController: UIViewController , AKPickerViewDataSource, AKPickerViewDelegate {

    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    @IBOutlet weak var labBusinessName: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var switchopenBtn: UIButton!
    @IBOutlet weak var openTime1View: UIView!
    @IBOutlet weak var openTime2View: UIView!
    @IBOutlet weak var closedView: UIView!
    @IBOutlet weak var open1viewbtn: UIButton!
    @IBOutlet weak var open2viewbtn: UIButton!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var openTimeLabel1: UILabel!
    @IBOutlet weak var openTimeLabel2: UILabel!
    
    @IBOutlet weak var edit3HeaderTitleLabel: UILabel!
    
    @IBOutlet weak var edit3OpenHourLabel: UILabel!
    
    @IBOutlet weak var edit3SwipeTitle: UIButton!
    
    @IBOutlet weak var edit3ClosedLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var untilLabel: UILabel!
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var checkImg: UIImageView!
    
    @IBOutlet weak var copy_paste: UILabel!
    
    let titles = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var close_flag : Bool = false
    var checkall_flag : Bool = false
    
    var day_start : String = ""
    var day_end : String = ""
    
//    var lines : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activeIndicator.isHidden = true
        
        //font size set
        labBusinessName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        openTimeLabel1.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].open_time))
        openTimeLabel2.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].open_time))
        edit3HeaderTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        edit3OpenHourLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        fromLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        untilLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        edit3ClosedLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].open_time))
        
        btnContinue.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        switchopenBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        copy_paste.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        open1viewbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        open2viewbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        edit3SwipeTitle.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bottom_labelfont))
        
        //
        labBusinessName.text = Common.editBarModel.business_name
        btnContinue.layer.cornerRadius = btnContinue.frame.height/2
        btnContinue.layer.borderWidth = 2
        btnContinue.layer.borderColor = UIColor.white.cgColor
        
        openTime1View.layer.cornerRadius = 5
        openTime2View.layer.cornerRadius = 5
        closedView.layer.cornerRadius = 5
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        self.pickerView.textColor = UIColor.white
        self.pickerView.highlightedFont = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        self.pickerView.pickerViewStyle = .wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        
        closedView.isHidden = true
       
        if Common.select_open == "" {
            if (Common.editBarModel.editopenHour?.mon_start?.isEmpty)! && (Common.editBarModel.editopenHour?.mon_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.mon_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.mon_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.mon_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.mon_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
        }
        
        if Common.select_open == "open1" {
            
            openTime1View.layer.backgroundColor = UIColor.white.cgColor
            openTimeLabel1.text = Common.select_time
            if openTimeLabel1.text != "00:00"
            {
                openTimeLabel1.textColor = UIColor.darkGray
            }
            
            if Common.slide_index == 0 {
                Common.editBarModel.editopenHour?.mon_start = Common.select_time
            } else if Common.slide_index == 1{
                Common.editBarModel.editopenHour?.tue_start = Common.select_time
            } else if Common.slide_index == 2{
                Common.editBarModel.editopenHour?.wed_start = Common.select_time
            } else if Common.slide_index == 3{
                Common.editBarModel.editopenHour?.thur_start = Common.select_time
            } else if Common.slide_index == 4{
                Common.editBarModel.editopenHour?.fri_start = Common.select_time
            } else if Common.slide_index == 5{
                Common.editBarModel.editopenHour?.sat_start = Common.select_time
            }else if Common.slide_index == 6{
                Common.editBarModel.editopenHour?.sun_start = Common.select_time
            }
            
        } else if Common.select_open == "open2" {
            openTime2View.layer.backgroundColor = UIColor.white.cgColor
            openTimeLabel2.text = Common.select_time
            if openTimeLabel2.text != "00:00"
            {
                openTimeLabel2.textColor = UIColor.darkGray
            }
            
            if Common.slide_index == 0 {
                Common.editBarModel.editopenHour?.mon_end = Common.select_time
            } else if Common.slide_index == 1 {
                Common.editBarModel.editopenHour?.tue_end = Common.select_time
            } else if Common.slide_index == 2 {
                Common.editBarModel.editopenHour?.wed_end = Common.select_time
            } else if Common.slide_index == 3 {
                Common.editBarModel.editopenHour?.thur_end = Common.select_time
            } else if Common.slide_index == 4 {
                Common.editBarModel.editopenHour?.fri_end = Common.select_time
            } else if Common.slide_index == 5 {
                Common.editBarModel.editopenHour?.sat_end = Common.select_time
            } else if Common.slide_index == 6 {
                Common.editBarModel.editopenHour?.sun_end = Common.select_time
            }
        }
        
        self.pickerView.selectItem(Common.slide_index)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    //PickerView Part
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return self.titles.count
    }
    
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        
        return self.titles[item]
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.titles[item])!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        print("Your favorite city is \(self.titles[item])")
        Common.slide_index = item
        if Common.slide_index == 0 {
            if (Common.editBarModel.editopenHour?.mon_start?.isEmpty)! && (Common.editBarModel.editopenHour?.mon_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.mon_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.mon_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.mon_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.mon_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            }
        } else if Common.slide_index == 1 {
            if (Common.editBarModel.editopenHour?.tue_start?.isEmpty)! && (Common.editBarModel.editopenHour?.tue_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.tue_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.tue_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.tue_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.tue_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            }
        } else if Common.slide_index == 2 {
            if (Common.editBarModel.editopenHour?.wed_start?.isEmpty)! && (Common.editBarModel.editopenHour?.wed_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.wed_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.wed_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.wed_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.wed_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            }
        } else if Common.slide_index == 3 {
            if (Common.editBarModel.editopenHour?.thur_start?.isEmpty)! && (Common.editBarModel.editopenHour?.thur_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.thur_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.thur_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.thur_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.thur_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            }
        } else if Common.slide_index == 4 {
            if (Common.editBarModel.editopenHour?.fri_start?.isEmpty)! && (Common.editBarModel.editopenHour?.fri_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.fri_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = (Common.editBarModel.editopenHour?.fri_start)!
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.fri_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.fri_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            }
        } else if Common.slide_index == 5 {
            if (Common.editBarModel.editopenHour?.sat_start?.isEmpty)! && (Common.editBarModel.editopenHour?.sat_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.sat_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.sat_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.sat_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.sat_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            }
        } else if Common.slide_index == 6 {
            if (Common.editBarModel.editopenHour?.sun_start?.isEmpty)! && (Common.editBarModel.editopenHour?.sun_end?.isEmpty)! {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                open1viewbtn.isEnabled = true
                open2viewbtn.isEnabled = true
                closedView.isHidden = true
                close_flag = false
                switchopenBtn.setTitle("We're closed today", for: .normal)
                
                openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel1.text = "00:00"
                openTimeLabel1.textColor = MyColor.customCircleFillColor()
                openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                openTimeLabel2.text = "00:00"
                openTimeLabel2.textColor = MyColor.customCircleFillColor()
                
            } else {
                openTime1View.isHidden = false
                openTime2View.isHidden = false
                closedView.isHidden = true
                switchopenBtn.setTitle("We're closed today", for: .normal)
                close_flag = false
                if (Common.editBarModel.editopenHour?.sun_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.sun_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.sun_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.sun_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // println("\(scrollView.contentOffset.x)")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Common.select_open == "open1" {
            
            openTime1View.layer.backgroundColor = UIColor.white.cgColor
            openTimeLabel1.text = Common.select_time
            if openTimeLabel1.text != "00:00"
            {
                openTimeLabel1.textColor = UIColor.darkGray
            }
            
            if Common.slide_index == 0 {
                Common.editBarModel.editopenHour?.mon_start = Common.select_time
            } else if Common.slide_index == 1{
                Common.editBarModel.editopenHour?.tue_start = Common.select_time
            } else if Common.slide_index == 2{
                Common.editBarModel.editopenHour?.wed_start = Common.select_time
            } else if Common.slide_index == 3{
                Common.editBarModel.editopenHour?.thur_start = Common.select_time
            } else if Common.slide_index == 4{
                Common.editBarModel.editopenHour?.fri_start = Common.select_time
            } else if Common.slide_index == 5{
                Common.editBarModel.editopenHour?.sat_start = Common.select_time
            }else if Common.slide_index == 6{
                Common.editBarModel.editopenHour?.sun_start = Common.select_time
                
            }
            
        } else if Common.select_open == "open2" {
            
            openTime2View.layer.backgroundColor = UIColor.white.cgColor
            openTimeLabel2.text = Common.select_time
            if openTimeLabel2.text != "00:00"
            {
                openTimeLabel2.textColor = UIColor.darkGray
            }
            
            if Common.slide_index == 0 {
                Common.editBarModel.editopenHour?.mon_end = Common.select_time
            } else if Common.slide_index == 1{
                Common.editBarModel.editopenHour?.tue_end = Common.select_time
            } else if Common.slide_index == 2{
                Common.editBarModel.editopenHour?.wed_end = Common.select_time
            } else if Common.slide_index == 3{
                Common.editBarModel.editopenHour?.thur_end = Common.select_time
            } else if Common.slide_index == 4{
                Common.editBarModel.editopenHour?.fri_end = Common.select_time
            } else if Common.slide_index == 5{
                Common.editBarModel.editopenHour?.sat_end = Common.select_time
            }else if Common.slide_index == 6{
                Common.editBarModel.editopenHour?.sun_end = Common.select_time
            }
        }
        
        self.pickerView.selectItem(Common.slide_index)
    }
    
    func finishedResponse() {
        
        Common.select_time = ""
        close_flag = true
        Common.select_open = ""
        Common.slide_index = 0
        
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
    
    //back
    @IBAction func btnBackClick(_ sender: Any) {
        Common.select_time = ""
        close_flag = true
        Common.select_open = ""
        Common.slide_index = 0
        Common.category = ""
        Common.selectAddress = ""
        self.finishedResponse()
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
//        self.activeIndicator.isHidden = false
//        self.activeIndicator.startAnimating()
        
    }

    @IBAction func btnUpClick(_ sender: Any) {
        
        Common.select_time = ""
        close_flag = true
        Common.select_open = ""
        Common.slide_index = 0
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile2")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    //
    @IBAction func btnClosedTodayClick(_ sender: Any) {
        
        Common.select_date1 = 0
        Common.select_date2 = 0
        
        if close_flag == false {
            openTime1View.isHidden = true
            openTime2View.isHidden = true
            open1viewbtn.isHidden = true
            open2viewbtn.isHidden = true
            open1viewbtn.isEnabled = false
            open2viewbtn.isEnabled = false
            closedView.isHidden = false
            close_flag = true
            switchopenBtn.setTitle("Add opening hours", for: .normal)
            if Common.slide_index == 0 {
                Common.editBarModel.editopenHour?.mon_start = ""
                Common.editBarModel.editopenHour?.mon_end = ""
                
            } else if Common.slide_index == 1 {
                Common.editBarModel.editopenHour?.tue_start = ""
                Common.editBarModel.editopenHour?.tue_end = ""
            } else if Common.slide_index == 2 {
                Common.editBarModel.editopenHour?.wed_start = ""
                Common.editBarModel.editopenHour?.wed_end = ""
            } else if Common.slide_index == 3 {
                Common.editBarModel.editopenHour?.thur_start = ""
                Common.editBarModel.editopenHour?.thur_end = ""
            } else if Common.slide_index == 4 {
                Common.editBarModel.editopenHour?.fri_start = ""
                Common.editBarModel.editopenHour?.fri_end = ""
            } else if Common.slide_index == 5 {
                Common.editBarModel.editopenHour?.sat_start = ""
                Common.editBarModel.editopenHour?.sat_end = ""
            } else if Common.slide_index == 6 {
                Common.editBarModel.editopenHour?.sun_start = ""
                Common.editBarModel.editopenHour?.sun_end = ""
            }
        } else {
            openTime1View.isHidden = false
            openTime2View.isHidden = false
            
            open1viewbtn.isHidden = false
            open2viewbtn.isHidden = false
            open1viewbtn.isEnabled = true
            open2viewbtn.isEnabled = true
            
            closedView.isHidden = true
            close_flag = false
            switchopenBtn.setTitle("We're closed today", for: .normal)
            
            if Common.slide_index == 0 {
                if (Common.editBarModel.editopenHour?.mon_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.mon_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.mon_end?.isEmpty)! {
                    openTimeLabel2.text = "00:00"
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.mon_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
                
            } else if Common.slide_index == 1 {
                if (Common.editBarModel.editopenHour?.tue_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.tue_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.tue_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.tue_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            } else if Common.slide_index == 2 {
                if (Common.editBarModel.editopenHour?.wed_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.wed_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.wed_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.wed_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            } else if Common.slide_index == 3 {
                if (Common.editBarModel.editopenHour?.thur_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.thur_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.thur_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.thur_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            } else if Common.slide_index == 4 {
                if (Common.editBarModel.editopenHour?.fri_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.fri_start!
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.fri_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.fri_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            } else if Common.slide_index == 5 {
                if (Common.editBarModel.editopenHour?.sat_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.sat_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.sat_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.sat_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            } else if Common.slide_index == 6 {
                if (Common.editBarModel.editopenHour?.sun_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.sun_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.sun_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                } else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.sun_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
        }
        
    }
    
    
    @IBAction func OpenTime1Action(_ sender: Any) {
        
        Common.select_time = openTimeLabel1.text!
        Common.select_open = "open1"
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerViewController")
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func OpenTime2Action(_ sender: Any) {
        
        Common.select_time = openTimeLabel2.text!
        Common.select_open = "open2"
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func CheckForAllDays(_ sender: Any) {
        
        if checkall_flag == true {
            
            checkImg.image = UIImage(named: "ico_uncheck.png")
            checkall_flag = false

            var val = Common.editBarModel.editopenHour?.mon_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.mon_start = val
            val = Common.editBarModel.editopenHour?.tue_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.tue_start = val
            val = Common.editBarModel.editopenHour?.wed_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.wed_start = val
            val = Common.editBarModel.editopenHour?.thur_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.thur_start = val
            val = Common.editBarModel.editopenHour?.fri_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.fri_start = val
            val = Common.editBarModel.editopenHour?.sat_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.sat_start = val
            val = Common.editBarModel.editopenHour?.sun_start1 ?? "00:00"
            Common.editBarModel.editopenHour?.sun_start = val

            val = Common.editBarModel.editopenHour?.mon_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.mon_end = val
            val = Common.editBarModel.editopenHour?.tue_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.tue_end = val
            val = Common.editBarModel.editopenHour?.wed_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.wed_end = val
            val = Common.editBarModel.editopenHour?.thur_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.thur_end = val
            val = Common.editBarModel.editopenHour?.fri_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.fri_end = val
            val = Common.editBarModel.editopenHour?.sat_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.sat_end = val
            val = Common.editBarModel.editopenHour?.sun_end1 ?? "00:00"
            Common.editBarModel.editopenHour?.sun_end = val
            
            if Common.slide_index == 0 {
                if (Common.editBarModel.editopenHour?.mon_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.mon_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.mon_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.mon_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            else if Common.slide_index == 1 {
                if (Common.editBarModel.editopenHour?.tue_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.tue_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.tue_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.tue_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            else if Common.slide_index == 2 {
                if (Common.editBarModel.editopenHour?.wed_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.wed_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.wed_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.wed_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            else if Common.slide_index == 3 {
                if (Common.editBarModel.editopenHour?.thur_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.thur_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.thur_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.thur_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            else if Common.slide_index == 4 {
                if (Common.editBarModel.editopenHour?.fri_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.fri_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.fri_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.fri_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            else if Common.slide_index == 5 {
                if (Common.editBarModel.editopenHour?.sat_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.sat_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.sat_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.sat_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            else if Common.slide_index == 6 {
                if (Common.editBarModel.editopenHour?.sun_start?.isEmpty)! {
                    openTime1View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel1.text = "00:00"
                    openTimeLabel1.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime1View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel1.text = Common.editBarModel.editopenHour?.sun_start
                    openTimeLabel1.textColor = UIColor.darkGray
                }
                if (Common.editBarModel.editopenHour?.sun_end?.isEmpty)! {
                    openTime2View.layer.backgroundColor = MyColor.customPinkColor().cgColor
                    openTimeLabel2.text = "00:00"
                    openTimeLabel2.textColor = MyColor.customCircleFillColor()
                }
                else {
                    openTime2View.layer.backgroundColor = UIColor.white.cgColor
                    openTimeLabel2.text = Common.editBarModel.editopenHour?.sun_end
                    openTimeLabel2.textColor = UIColor.darkGray
                }
            }
            
        }
        else {
            checkImg.image = UIImage(named: "ico_check.png")
            checkall_flag = true
            
            var val = Common.editBarModel.editopenHour?.mon_start ?? "00:00"
            Common.editBarModel.editopenHour?.mon_start1 = val
            val = Common.editBarModel.editopenHour?.tue_start ?? "00:00"
            Common.editBarModel.editopenHour?.tue_start1 = val
            val = Common.editBarModel.editopenHour?.wed_start ?? "00:00"
            Common.editBarModel.editopenHour?.wed_start1 = val
            val = Common.editBarModel.editopenHour?.thur_start ?? "00:00"
            Common.editBarModel.editopenHour?.thur_start1 = val
            val = Common.editBarModel.editopenHour?.fri_start ?? "00:00"
            Common.editBarModel.editopenHour?.fri_start1 = val
            val = Common.editBarModel.editopenHour?.sat_start ?? "00:00"
            Common.editBarModel.editopenHour?.sat_start1 = val
            val = Common.editBarModel.editopenHour?.sun_start ?? "00:00"
            Common.editBarModel.editopenHour?.sun_start1 = val

            val = Common.editBarModel.editopenHour?.mon_end ?? "00:00"
            Common.editBarModel.editopenHour?.mon_end1 = val
            val = Common.editBarModel.editopenHour?.tue_end ?? "00:00"
            Common.editBarModel.editopenHour?.tue_end1 = val
            val = Common.editBarModel.editopenHour?.wed_end ?? "00:00"
            Common.editBarModel.editopenHour?.wed_end1 = val
            val = Common.editBarModel.editopenHour?.thur_end ?? "00:00"
            Common.editBarModel.editopenHour?.thur_end1 = val
            val = Common.editBarModel.editopenHour?.fri_end ?? "00:00"
            Common.editBarModel.editopenHour?.fri_end1 = val
            val = Common.editBarModel.editopenHour?.sat_end ?? "00:00"
            Common.editBarModel.editopenHour?.sat_end1 = val
            val = Common.editBarModel.editopenHour?.sun_end ?? "00:00"
            Common.editBarModel.editopenHour?.sun_end1 = val
            
            if Common.slide_index == 0 {
                
                day_start = (Common.editBarModel.editopenHour?.mon_start)!
                day_end = (Common.editBarModel.editopenHour?.mon_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            } else if Common.slide_index == 1 {
                
                day_start = (Common.editBarModel.editopenHour?.tue_start)!
                day_end = (Common.editBarModel.editopenHour?.tue_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            } else if Common.slide_index == 2 {
                
                day_start = (Common.editBarModel.editopenHour?.wed_start)!
                day_end = (Common.editBarModel.editopenHour?.wed_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            } else if Common.slide_index == 3 {
                
                day_start = (Common.editBarModel.editopenHour?.thur_start)!
                day_end = (Common.editBarModel.editopenHour?.thur_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            } else if Common.slide_index == 4 {
                
                day_start = (Common.editBarModel.editopenHour?.fri_start)!
                day_end = (Common.editBarModel.editopenHour?.fri_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            } else if Common.slide_index == 5 {
                
                day_start = (Common.editBarModel.editopenHour?.sat_start)!
                day_end = (Common.editBarModel.editopenHour?.sat_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            } else if Common.slide_index == 6 {
                
                day_start = (Common.editBarModel.editopenHour?.sun_start)!
                day_end = (Common.editBarModel.editopenHour?.sun_end)!
                
                Common.editBarModel.editopenHour?.mon_start = day_start
                Common.editBarModel.editopenHour?.tue_start = day_start
                Common.editBarModel.editopenHour?.wed_start = day_start
                Common.editBarModel.editopenHour?.thur_start = day_start
                Common.editBarModel.editopenHour?.fri_start = day_start
                Common.editBarModel.editopenHour?.sat_start = day_start
                Common.editBarModel.editopenHour?.sun_start = day_start
                
                Common.editBarModel.editopenHour?.mon_end = day_end
                Common.editBarModel.editopenHour?.tue_end = day_end
                Common.editBarModel.editopenHour?.wed_end = day_end
                Common.editBarModel.editopenHour?.thur_end = day_end
                Common.editBarModel.editopenHour?.fri_end = day_end
                Common.editBarModel.editopenHour?.sat_end = day_end
                Common.editBarModel.editopenHour?.sun_end = day_end
                
            }
            
        }
    }
    
    func CheckOpenTime()->Bool {
        if Common.slide_index == 0 {
            if (Common.editBarModel.editopenHour?.mon_start == "" && Common.editBarModel.editopenHour?.mon_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.mon_start == "00:00" && Common.editBarModel.editopenHour?.mon_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.mon_start != "" && Common.editBarModel.editopenHour?.mon_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.mon_start == "" && Common.editBarModel.editopenHour?.mon_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.mon_start != "" && Common.editBarModel.editopenHour?.mon_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.mon_start == "00:00" && Common.editBarModel.editopenHour?.mon_end != ""){
                return false
            } else {
                return true
            }
        } else if Common.slide_index == 1 {
            if (Common.editBarModel.editopenHour?.tue_start == "" && Common.editBarModel.editopenHour?.tue_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.tue_start == "00:00" && Common.editBarModel.editopenHour?.tue_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.tue_start != "" && Common.editBarModel.editopenHour?.tue_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.tue_start == "" && Common.editBarModel.editopenHour?.tue_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.tue_start != "" && Common.editBarModel.editopenHour?.tue_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.tue_start == "00:00" && Common.editBarModel.editopenHour?.tue_end != ""){
                return false
            } else {
                return true
            }
        } else if Common.slide_index == 2 {
            if (Common.editBarModel.editopenHour?.wed_start == "" && Common.editBarModel.editopenHour?.wed_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.wed_start == "00:00" && Common.editBarModel.editopenHour?.wed_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.wed_start != "" && Common.editBarModel.editopenHour?.wed_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.wed_start == "" && Common.editBarModel.editopenHour?.wed_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.wed_start != "" && Common.editBarModel.editopenHour?.wed_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.wed_start == "00:00" && Common.editBarModel.editopenHour?.wed_end != ""){
                return false
            } else {
                return true
            }

        } else if Common.slide_index == 3 {
            if (Common.editBarModel.editopenHour?.thur_start == "" && Common.editBarModel.editopenHour?.thur_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.thur_start == "00:00" && Common.editBarModel.editopenHour?.thur_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.thur_start != "" && Common.editBarModel.editopenHour?.thur_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.thur_start == "" && Common.editBarModel.editopenHour?.thur_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.thur_start != "" && Common.editBarModel.editopenHour?.thur_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.thur_start == "00:00" && Common.editBarModel.editopenHour?.thur_end != ""){
                return false
            } else {
                return true
            }
        } else if Common.slide_index == 4 {
            if (Common.editBarModel.editopenHour?.fri_start == "" && Common.editBarModel.editopenHour?.fri_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.fri_start == "00:00" && Common.editBarModel.editopenHour?.fri_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.fri_start != "" && Common.editBarModel.editopenHour?.fri_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.fri_start == "" && Common.editBarModel.editopenHour?.fri_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.fri_start != "" && Common.editBarModel.editopenHour?.fri_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.fri_start == "00:00" && Common.editBarModel.editopenHour?.fri_end != ""){
                return false
            } else {
                return true
            }
        } else if Common.slide_index == 5 {
            if (Common.editBarModel.editopenHour?.sat_start == "" && Common.editBarModel.editopenHour?.sat_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.sat_start == "00:00" && Common.editBarModel.editopenHour?.sat_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.sat_start != "" && Common.editBarModel.editopenHour?.sat_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.sat_start == "" && Common.editBarModel.editopenHour?.sat_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.sat_start != "" && Common.editBarModel.editopenHour?.sat_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.sat_start == "00:00" && Common.editBarModel.editopenHour?.sat_end != ""){
                return false
            } else {
                return true
            }
        } else if Common.slide_index == 6 {
            if (Common.editBarModel.editopenHour?.sun_start == "" && Common.editBarModel.editopenHour?.sun_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.sun_start == "00:00" && Common.editBarModel.editopenHour?.sun_end == "00:00") {
                return false
            } else if (Common.editBarModel.editopenHour?.sun_start != "" && Common.editBarModel.editopenHour?.sun_end == "") {
                return false
            } else if (Common.editBarModel.editopenHour?.sun_start == "" && Common.editBarModel.editopenHour?.sun_end != ""){
                return false
            } else if (Common.editBarModel.editopenHour?.sun_start != "" && Common.editBarModel.editopenHour?.sun_end == "00:00"){
                return false
            } else if (Common.editBarModel.editopenHour?.sun_start == "00:00" && Common.editBarModel.editopenHour?.sun_end != ""){
                return false
            } else {
                return true
            }
        }
        
        return true
    }
    
    @IBAction func btnContinueClick(_ sender: Any) {
        if self.CheckOpenTime() == false {
            MessageBoxViewController.showAlert(self, title: "Alert", message: "Please Choose Open Time")
        } else {
            Common.select_time = ""
            close_flag = true
            Common.select_open = ""
            Common.slide_index = 0
            
            //transition effect
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile4")
            
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

}

