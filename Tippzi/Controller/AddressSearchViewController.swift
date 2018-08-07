//
//  AddressSearchViewController.swift
//  Tippzi
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class AddressSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectaddressLabel: UILabel!
    
    @IBOutlet weak var roundAddress: UIButton!
    
    var cell : AddressItemCellTableViewCell? = nil
    let cellReuseIdentifier = "address_item"
    
    let cellSpacingHeight: CGFloat = 1
    var arrayOfArray = [AddressInfo]()
    var createaccountview = CreateBusinessAccountViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        //font size set
        selectaddressLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        //
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = UIColor.clear
//        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        roundAddress.layer.cornerRadius = 8
        roundAddress.layer.borderColor = UIColor.white.cgColor
        roundAddress.layer.borderWidth = 2
        
        arrayOfArray = [AddressInfo]()
        for index in 0...Common.addressModel.addresses.count-1 {
            arrayOfArray += [AddressInfo(Common.addressModel.addresses[index].address!)]
        }
        addressView.layer.cornerRadius = 15
        addressView.layer.borderColor = UIColor.white.cgColor
        addressView.layer.borderWidth = 3
        
        
        
        // Do any additional setup after loading the view.
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
    
    // create a cell for each tableview row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get cell of TableView
        cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! AddressItemCellTableViewCell
        
        // cell style
        
        cell?.clipsToBounds = true
        let choice = arrayOfArray[indexPath.section]
        cell?.addressLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        cell?.addressLabel.text = choice.address_name
        cell?.selectaddressbtn.addTarget(self, action:#selector(Select), for: .touchUpInside)
        return cell!
    }
    
    
    @IBAction func Select(_ sender: Any){
        let superview = (sender as AnyObject).superview
        let cell = superview??.superview as? AddressItemCellTableViewCell
        
        var view_str = ""
        if Common.lookup_button_flag == 1 {
            view_str = "CreateBusinessAccountView"
        }
        else if Common.lookup_button_flag == 2 {
            view_str = "EditBusinessProfile1"

        }
        
        let indexPath = self.tableView.indexPath(for: cell!)
        Common.selectAddress = arrayOfArray[(indexPath?.section)!].address_name
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: view_str)
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @IBAction func gotoCreateBusinessAccount(_ sender: Any) {
        
        var view_str = ""
        if Common.lookup_button_flag == 1 {
            view_str = "CreateBusinessAccountView"
        }
        else if Common.lookup_button_flag == 2 {
            view_str = "EditBusinessProfile1"
            
        }
        
        let indexPath = self.tableView.indexPath(for: cell!)
        //Common.selectAddress = ""
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: view_str)
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)

    }
    
    // method to run when tableview cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cell = tableView.cellForRow(at: indexPath) as! AddressItemCellTableViewCell?
        Common.selectAddress = arrayOfArray[indexPath.section].address_name
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
