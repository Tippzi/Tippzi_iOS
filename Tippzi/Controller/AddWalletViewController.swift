//
//  AddWalletViewController.swift
//  Tippzi
//
//  Created by Admin on 11/20/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class AddWalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var headtitle: UILabel!
    @IBOutlet weak var myDealCount: UILabel!
    
    @IBOutlet weak var coinCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var isNavigationController = false
    
    var cell : CustomerDealItemViewCell? = nil
    let cellSpacingHeight: CGFloat = 10
    let defaults = UserDefaults.standard
    var arrayOfArray = [WalletListModel]()
    
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var select_pos : Int = 0
    var wallet_pos : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activeIndicator.isHidden = true
        //font size set
        headtitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        myDealCount.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].deal_name_size))
        
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if Common.customerModel.wallets.count > 0 {
            
            for index in 0...Common.customerModel.wallets.count-1 {
            
                if Common.customerModel.wallets[index].claimed_check == "false" {
                    if (Common.category_name != "All") {
                        if Common.customerModel.wallets[index].category != Common.category_name {
                            continue
                        }
                    }
                    
                    arrayOfArray += [WalletListModel(Common.customerModel.wallets[index].bar_id!,
                                                     Common.customerModel.wallets[index].deal_id!,
                                                     Common.customerModel.wallets[index].title!,
                                                     Common.customerModel.wallets[index].description!,
                                                     Common.customerModel.wallets[index].duration!,
                                                     Common.customerModel.wallets[index].qty!,
                                                     Common.customerModel.wallets[index].impressions!,
                                                     Common.customerModel.wallets[index].in_wallet!,
                                                     Common.customerModel.wallets[index].claimed!,
                                                     Common.customerModel.wallets[index].business_name!,
                                                     Common.customerModel.wallets[index].music_type!, index)]
                    
                }
                
            }
        }
        
        //Common.walletModel = arrayOfArray
        //
        myDealCount.text = "My deals (" + String(arrayOfArray.count) + ")"
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.get_tippzi_coin_count()
    }
    func get_tippzi_coin_count()
    {
        let url = Common.host + "api/coin/get_coin_count"
        let params = ["customer":Common.customerModel.user_id!] as [String : Any]
        do {
            let opt = try HTTP.POST(url, parameters: params)
            opt?.run { response in
                if let error = response.error {
                    return
                }
                do {
                    let decoder: JSONLoader = JSONLoader(response.text!)
                    let coinCount = try TippziCoinCountModel(decoder)
                    
                    DispatchQueue.main.sync(execute: {
                        self.coinCount.text = String(describing: coinCount.count)
                    })
                } catch {
                }
            }
        } catch let error {
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }	
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        cell = CustomerDealItemViewCell.instanceFromNib() as! CustomerDealItemViewCell
        
        let choice = arrayOfArray[indexPath.section]
        
        //font size set
        cell?.labDealName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].deal_name_size))
        cell?.labDealDescription.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].description_size))
        cell?.labBarName.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].description_size))
        cell?.labRemaining.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        cell?.btnClaimDeal.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].sub_button_size))
        
        //
        cell?.labDealName.text = choice.deal_title
        cell?.labDealDescription.text = choice.deal_description
        cell?.labBarName.text = choice.business_name
        cell?.labRemaining.text = String(Int(choice.deal_qty)! - Int(choice.claimed)!) + " left Exp " + choice.deal_duratioin
        
        for i in 0...Common.customerModel.bars.count-1{
            if Common.customerModel.bars[i].bar_id == choice.bar_id {
                select_pos = i
            }
        }
        
        if Common.customerModel.bars[select_pos].category == "Nightlife" {
            cell?.labRemaining.textColor = MyColor.MarkLabelCategory0()
            cell?.location_category.image = UIImage(named: "ico_location_category1")
        }
        else if Common.customerModel.bars[select_pos].category == "Health & Fitness" {
            cell?.labRemaining.textColor = MyColor.MarkLabelCategory1()
            cell?.location_category.image = UIImage(named: "ico_location_category2")
        }
        else if Common.customerModel.bars[select_pos].category == "Hair & Beauty" {
            cell?.labRemaining.textColor = MyColor.MarkLabelCategory2()
            cell?.location_category.image = UIImage(named: "ico_location_category3")
        }
        
        cell?.layer.cornerRadius = 5
        
        cell?.btnClaimDeal.layer.cornerRadius = (cell?.btnClaimDeal.frame.height)! / 2
        cell?.btnDeleteWallet.addTarget(self, action: #selector(ClaimDeal), for: .touchUpInside)
        cell?.btnDeleteDeal.addTarget(self, action: #selector(DeleteDeal), for: .touchUpInside)
        return (cell)!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSLog("Table view scroll detected at offset: %f",scrollView.contentOffset.y)
    }
    
    //view this deal
    @IBAction func ClaimDeal(_ sender: Any){
        let superview = (sender as AnyObject).superview
        let cell = superview??.superview as? CustomerDealItemViewCell
        
        let indexPath = self.tableView.indexPath(for: cell!)
        let choices = arrayOfArray[(indexPath?.section)!]
        
        Common.wallet_pos = choices.index
        
        Common.check_wallet = true
        Common.from_claimdeal = false
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")

        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    // disapear in wallet list
    @IBAction func DeleteDeal(_ sender: Any){
        
        let superview = (sender as AnyObject).superview
        let cell = superview??.superview as? CustomerDealItemViewCell

        let indexPath = self.tableView.indexPath(for: cell!)
        let choices = arrayOfArray[(indexPath?.section)!]

        let delete_index = choices.index
        
        Common.inWallet_delete_index = delete_index
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "DeleteWalletQuestionView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        Common.check_wallet = false
        Common.from_claimdeal = false
        //transition effect
//        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerMap")
        if self.isNavigationController == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true) {
            }
        }
        
//        let transition = CATransition()
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromLeft
//        transition.duration = 0.5
//        view.window!.layer.add(transition, forKey: kCATransition)
//        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//        self.present(toViewController!, animated: true, completion:nil)
    }
    
}
