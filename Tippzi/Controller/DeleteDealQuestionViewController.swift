//
//  DeleteDealQuestionViewController.swift
//  Tippzi
//
//  Created by Admin on 1/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class DeleteDealQuestionViewController: UIViewController {

    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //font size set
        questionLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnYes.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnNo.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        
        //
        myView.layer.cornerRadius = 15
        myView.layer.borderColor = UIColor.white.cgColor
        myView.layer.borderWidth = 2
        btnYes.layer.cornerRadius = btnYes.frame.height / 2
        btnYes.layer.borderColor = UIColor.white.cgColor
        btnYes.layer.borderWidth = 2
        btnNo.layer.cornerRadius = btnNo.frame.height / 2
        btnNo.layer.borderColor = UIColor.white.cgColor
        btnNo.layer.borderWidth = 2
        
        self.activeIndicator.isHidden = true
    }
    
    @IBAction func btnYesClick(_ sender: Any) {
        
        Delete_Deal(Common.inDash_delete_index)
        
    }
    
    @IBAction func btnNoClick(_ sender: Any) {
        
        Common.inDash_delete_index = 0
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    //delete deal
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        Common.inDash_delete_index = 0
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    func Delete_Deal(_ delete_index: Int) {
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        
        
        let user_id = Common.businessModel.user_id
        let deal_id = Common.businessModel.bars[0].deal[delete_index].deal_id
        
        //create the url with URL
        let url = URL(string:Common.api_location + "delete_deal.php")!
        
        let params = ["user_id": user_id, "deal_id": deal_id] as [String : Any]
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.sync(execute: {
                    
                    self.view.isUserInteractionEnabled = true
                    
                    MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                    
                    // stop timer
                    self.activeIndicator.stopAnimating()
                    self.activeIndicator.isHidden = true
                    self.timer.invalidate()
                })
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    // handle json...
                    print(json)
                    Common.businessModel = try BusinessModel(JSONLoader(json))
                    if Common.businessModel.success == "true" {
                        self.flag = true
                        
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.customerModel.message!)
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            return
                        })
                    }
                    
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }

}
