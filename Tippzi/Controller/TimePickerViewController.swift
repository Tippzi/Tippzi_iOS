//
//  TimePickerViewController.swift
//  Tippzi
//
//  Created by Admin on 11/15/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    
//    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timePickerView: UIDatePicker!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDone.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        
        timePickerView.setValue(UIColor.white, forKey: "textColor")

        if Common.select_time != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            timePickerView.date = dateFormatter.date(from: Common.select_time)!
        }
    }
    
    @IBAction func SelectAction(_ sender: Any) {
        if Common.slide_index == 0 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.mon_end != "" || Common.editBarModel.editopenHour?.mon_end != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.mon_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.mon_start != "" || Common.editBarModel.editopenHour?.mon_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.mon_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        } else if Common.slide_index == 1 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.tue_end != "" || Common.editBarModel.editopenHour?.tue_end != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.tue_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.tue_start != "" || Common.editBarModel.editopenHour?.tue_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.tue_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        } else if Common.slide_index == 2 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.wed_end != "" || Common.editBarModel.editopenHour?.wed_end != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.wed_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.wed_start != "" || Common.editBarModel.editopenHour?.wed_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.wed_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        } else if Common.slide_index == 3 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.thur_end != "" || Common.editBarModel.editopenHour?.thur_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.thur_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.thur_start != "" || Common.editBarModel.editopenHour?.thur_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.thur_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        } else if Common.slide_index == 4 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.fri_end != "" || Common.editBarModel.editopenHour?.fri_end != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.fri_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.fri_start != "" || Common.editBarModel.editopenHour?.fri_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.fri_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        } else if Common.slide_index == 5 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.sat_end != "" || Common.editBarModel.editopenHour?.sat_end != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.sat_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.sat_start != "" || Common.editBarModel.editopenHour?.sat_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.sat_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        }else if Common.slide_index == 6 {
            if Common.select_open == "open1" {
                if Common.editBarModel.editopenHour?.sun_end != "" || Common.editBarModel.editopenHour?.sun_end != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.sun_end?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date2 = Int(interval)
                }
            } else if Common.select_open == "open2" {
                if Common.editBarModel.editopenHour?.sun_start != "" || Common.editBarModel.editopenHour?.sun_start != "00:00" {
                    var interval:Double = 0
                    let parts = Common.editBarModel.editopenHour?.sun_start?.components(separatedBy: ":")
                    for (index, part) in (parts?.reversed().enumerated())! {
                        interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
                    }
                    
                    Common.select_date1 = Int(interval)
                }
            }
        }
        let date = Date()
        var select_index = 0
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var startDateString = dateFormatter.string(from: timePickerView.date)
        var interval:Double = 0
        
        let parts = startDateString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        
        let myInt = Int(interval)
        if Common.select_open == "open1" {
            Common.select_date1 = myInt
        } else if Common.select_open == "open2" {
            Common.select_date2 = myInt
        }
        if Common.select_date2 != 0 {
            if Common.select_date1 <= Common.select_date2 {
                select_index = 1
            } else if Common.select_date1 > Common.select_date2 {
                select_index = 2
            }
        } else {
            select_index = 1
        }
//        if select_index == 1 {
            dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            startDateString = dateFormatter.string(from: timePickerView.date)
            
            Common.select_time = startDateString
            
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile3")
            
            let transition = CATransition()
            transition.type = kCATransitionFromBottom
            transition.subtype = kCATransitionFromBottom
            transition.duration = 0.2
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
//        } else {
//            MessageBoxViewController.showAlert(self, title: "Alert", message: "You can't select past time.")
//            return
//        }

    }
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
