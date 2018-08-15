//
//  CustomerMapViewController.swift
//  Tippzi
//
//  Created by Admin on 11/19/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage
import SwiftHTTP
import JSONJoy
import Koloda
import CoreLocation

class CustomerMapViewController: UIViewController, GMSMapViewDelegate, UICollectionViewDataSource, HWSwiftyViewPagerDelegate,UITextFieldDelegate, KolodaViewDelegate,  KolodaViewDataSource
{
    //    var referenceID = "nil"
    
    @IBOutlet weak var wallet_countLabel: UILabel!
    
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var viewPager: HWSwiftyViewPager!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnSearchSwitch: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var remainLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var wallet_count : Int = 0
    
    var locationInfo = [LocationModel]()
    var searchlocationInfo = [LocationModel]()
    var locationInfo_card = [LocationModel]()
    
    var arrayOfArray = [WalletListModel]()
    
    var barIdArray_impressions = [String]()
    var barIdArray_engagement = [String]()
    
    var user_id : String = ""
    
    var search_flag : Bool = false
    
    var select_bar_id : Int = 0
    
    var card_deals = [BarDetailModel]()
    var index_count : Int = 0
    var index_viewcount : Int = 0
    var cell : CustomerBarCell? = nil
    var originIndexPath : IndexPath! = nil
    
    var temp_index_count : Int = 0
    var initialStatusBarStyle : UIStatusBarStyle?
    
    
    /**/
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    var timer:Timer = Timer()
    var flag:Bool = false
    var runloop : RunLoop = RunLoop()
    var mapFetch : MapDataFetch = MapDataFetch()
    /**/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user_id = Common.customerModel.user_id!
        
        //font size set
        wallet_countLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        remainLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        //
        self.viewPager.dataSource = self
        self.viewPager.pageSelectedDelegate = self
        googleMapView.delegate = self
    
    
        self.viewPager.translatesAutoresizingMaskIntoConstraints = false
        wallet_countLabel.layer.cornerRadius = wallet_countLabel.frame.width / 2
        searchView.layer.cornerRadius = 5
        wallet_countLabel.layer.masksToBounds = true
        
        let paddingView1 = UIView(frame: CGRect.init(x: 0, y: 0, width: 20, height: self.searchTextField.frame.height))
        searchTextField.leftView = paddingView1
        searchTextField.leftViewMode = UITextFieldViewMode.always
        
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
        
        wallet_count = arrayOfArray.count
        if wallet_count == nil {
            wallet_countLabel.text = ""
            wallet_countLabel.isHidden = true
        } else if wallet_count == 0 {
            wallet_countLabel.text = ""
            wallet_countLabel.isHidden = true
        } else {
            wallet_countLabel.text = String(wallet_count)
        }
        searchTextField.delegate = self
        
        let nibName = UINib(nibName: "CustomerBarCell", bundle:nil)
        self.viewPager.register(nibName, forCellWithReuseIdentifier: "cus_bar")
        
//        view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 280))
//
//        if DeviceType.IS_IPHONE_5 {
//            view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 280))
//        }  else if DeviceType.IS_IPHONE_6{
//            view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 380))
//        } else if DeviceType.IS_IPHONE_7 {
//            view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 414))
//        }else if DeviceType.IS_IPHONE_7P {
//            view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 500))
//        } else if DeviceType.IS_IPAD_PRO_9_7 {
//            //            view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 600))
//            self.viewPager.topAnchor.constraint(equalTo: self.viewPager.topAnchor, constant: -8).isActive = true
//        } else if DeviceType.IS_IPAD_PRO_12_9 {
//            view.addConstraint(NSLayoutConstraint(item: self.viewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 450))
//        }
 
        var aryBarTitles: [String] = []
        for i in 0 ..< Common.selectcategory.count {
            let lat = Common.selectcategory[i].latitude
            let long = Common.selectcategory[i].longitude
            
            var latitude = lat
            var longitude = long
            var barImage = Common.selectcategory[i].barImage
            var barTitle = Common.selectcategory[i].barTitle
            var music_type = Common.selectcategory[i].music_type
            var bar_id = Common.selectcategory[i].index_num
            var address = Common.selectcategory[i].address
            var service_name = Common.selectcategory[i].service_name
            
            
            var category_deal = [SelectCategoryDeal]()
            category_deal = Common.selectcategory[i].selectcategory_deal
            
            aryBarTitles.append(barTitle)
            
            locationInfo += [LocationModel(index_num: Int(bar_id), latitude: latitude, longitude: longitude, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle, music_type: music_type, category_name: Common.selectcategory[i].category_name, address: address, service_name: service_name)]
            if (Common.category_name == "All") {
                categoryLabel.isHidden = true
            } else {
                categoryLabel.text = locationInfo[i].category_name
            }
        }
        
        searchTextField.text = Common.search_string
        if Common.category_name == "Nightlife" {
            if Common.search_switch_flag == 0 {
                
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
                
            }
            else if Common.search_switch_flag == 1 {
                
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a bar", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_nightlife_search.jpg"), for: .normal)
                
            }
        }
        else if Common.category_name == "Health & Fitness" {
            if Common.search_switch_flag == 0 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
            }
            else if Common.search_switch_flag == 1 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a venue", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_health_search.jpg"), for: .normal)
            }
        }
        else if Common.category_name == "Hair & Beauty" {
            if Common.search_switch_flag == 0 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
            }
            else if Common.search_switch_flag == 1 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a beauty salon", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_hair_search.jpg"), for: .normal)
            }
        } else {
            if Common.search_switch_flag == 0 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
                
                searchTextField.filterItems([])
            } else if Common.search_switch_flag == 1 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a beauty salon", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "icon_bar.png"), for: .normal)
                
                searchTextField.addBars(aryBarTitles)
                self.get_service_names()
            }
        }
        
        self.search_action(Common.search_string)
        initialStatusBarStyle = UIApplication.shared.statusBarStyle
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
    }
    func get_service_names()
    {
        let url = Common.api_location + "get_service_name.php"
        let params = [:] as [String : Any]
        var aryServices: [String] = []
        do {
            let opt = try HTTP.GET(url)
            
            opt?.run { response in
                if let error = response.error {
                    return
                }
                do {
                    let decoder: JSONLoader = JSONLoader(response.text!)
                    guard let decoderArray = decoder.getOptionalArray() else {throw JSONError.wrongType}
                    for decoderT in decoderArray {
                        let service_name: String! = try decoderT.get() as String
                        aryServices.append(service_name)
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        self.searchTextField.addServices(aryServices)
                    })
                } catch {
                }
            }
        } catch let error {
        }
    }
    /***/
    func calculateNextNumber() {
        LoadCall()
    }
    
    func LoadCall(){
        let user_type = defaults.string(forKey: "user_type")
        if user_type == "1" {
            showViewController1()
        }
    }
    
    @objc func finishedResponse1() { //customer
        // timer
        if self.flag == false {
            return
        }
        
        timer.invalidate()
        
        Common.selectcategory = [LocationModel]()
        var category_deal = [SelectCategoryDeal]()
        
        for i in 0 ..< Common.customerModel.bars.count {
            if Common.category_name == Common.customerModel.bars[i].category {
                var bar_id = Common.customerModel.bars[i].bar_id
                var barTitle = Common.customerModel.bars[i].business_name
                var music_type = Common.customerModel.bars[i].music_type
                var latitude = CLLocationDegrees(Common.customerModel.bars[i].lat!)
                var longitude = CLLocationDegrees(Common.customerModel.bars[i].lon!)
                var address = Common.customerModel.bars[i].address
                var service_name = Common.customerModel.bars[i].service_name
                
                var category_deal = [SelectCategoryDeal]()
                var remain_number : Int = 0
                for j in 0 ..< Common.customerModel.bars[i].deal.count {
                    
                    var deal_title = Common.customerModel.bars[i].deal[j].title
                    var deal_description = Common.customerModel.bars[i].deal[j].description
                    remain_number = Int(Common.customerModel.bars[i].deal[j].qty!)! - Int(Common.customerModel.bars[i].deal[j].claimed!)!
                    var remain = String(remain_number) + " left Exp " + Common.customerModel.bars[i].deal[j].duration!
                    
                    category_deal += [SelectCategoryDeal(deal_title: deal_title!, deal_description: deal_description!, remain: remain)]
                }
                
                var barImage : String = ""
                if !(Common.customerModel.bars[i].background1?.isEmpty)! {
                    barImage = Common.download + Common.customerModel.bars[i].background1!
                } else if (!(Common.customerModel.bars[i].background2?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background2!
                } else if (!(Common.customerModel.bars[i].background3?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background3!
                } else if (!(Common.customerModel.bars[i].background4?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background4!
                } else if (!(Common.customerModel.bars[i].background5?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background5!
                } else if (!(Common.customerModel.bars[i].background6?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background6!
                }
                
                Common.selectcategory += [LocationModel(index_num: Int(bar_id!)!, latitude: latitude!, longitude: longitude!,  selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle!, music_type: music_type!, category_name: Common.category_name, address: address!, service_name:service_name!)]
            }
        }
        locationInfo = [LocationModel]()
        
        for i in 0 ..< Common.selectcategory.count {
            let lat = Common.selectcategory[i].latitude
            let long = Common.selectcategory[i].longitude
            
            var latitude = lat
            var longitude = long
            var barImage = Common.selectcategory[i].barImage
            var barTitle = Common.selectcategory[i].barTitle
            var music_type = Common.selectcategory[i].music_type
            var bar_id = Common.selectcategory[i].index_num
            var address = Common.selectcategory[i].address
            var service_name = Common.selectcategory[i].service_name
            
            var category_deal = [SelectCategoryDeal]()
            category_deal = Common.selectcategory[i].selectcategory_deal
            
            locationInfo += [LocationModel(index_num: Int(bar_id), latitude: latitude, longitude: longitude, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle, music_type: music_type, category_name: Common.selectcategory[i].category_name, address: address, service_name:service_name)]
        }
        
        googleMapView.reloadInputViews()
        self.viewPager.reloadInputViews()
        self.viewPager.setPage(Common.select_page_in, isAnimation: true)
        
    }
    
    func showViewController1() {
        
        let user_id = defaults.string(forKey: "user_id")
        
        // if customer
        let lan = String(Common.Coordinate.latitude)
        let lon = String(Common.Coordinate.longitude)
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
        
        // HTTP request
        let url = Common.api_location + "check_remember_customer.php"
        let params = ["user_id": user_id,
                      "lat": lan,
                      "lon": lon]
        do {
            let opt = try HTTP.POST(url, parameters: params)
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        //MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        // stop timer
                        self.timer.invalidate()
                        return
                    })
                    
                }
                do {
                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                    if Common.customerModel.success == "true" {
                        self.defaults.set(Common.customerModel.user_type, forKey: "user_type")
                        self.defaults.set(Common.customerModel.user_id, forKey: "user_id")
                        self.flag = true
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            self.timer.invalidate()
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
    }
    
    
    /***/
    
    @IBAction func MyLocationViewAction(_ sender: Any) {
        self.viewPager.setPage(0, isAnimation: true)
        googleMapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude, longitude: Common.Coordinate.longitude, zoom: 15.0)
        self.googleMapView.camera = camera
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    // take care of the close event
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        var selected_location_category_image : String = ""
        
        //mapView.clear()

        let data = marker.userData
        let i:Int = data as! Int
        Common.select_pos = i
        // remove color from currently selected marker
        self.viewPager.setPage(i, isAnimation: true)
        
        for index in 0 ..< locationInfo.count {
            //On load show first marker as selected marker
            if index == i {
                if i == Common.select_page_in {
                    
                } else {
                    let lat = CLLocationDegrees(locationInfo[index].latitude)
                    let long = CLLocationDegrees(locationInfo[index].longitude)
                    
                    let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                    let marker = GMSMarker(position: position)
                    marker.title = locationInfo[index].barTitle
                    //Here pass object you want to show in card it can be array or any thing
                    marker.userData = index //Pass some object
                    marker.map = googleMapView
                    mapView.selectedMarker = marker
                    marker.zIndex = 1
                    
                    if locationInfo[index].category_name == "Nightlife" {
                        
                        selected_location_category_image = "ico_selected_location_category1"
                    }
                    else if locationInfo[index].category_name == "Health & Fitness" {
                        
                        selected_location_category_image = "ico_selected_location_category2"
                        
                    }
                    else if locationInfo[index].category_name == "Hair & Beauty" {
                        
                        selected_location_category_image = "ico_selected_location_category3"
                        
                    }
                    else {
                        selected_location_category_image = "ico_selected_location"
                    }
                    
                    marker.icon = self.imageWithImage(image: UIImage(named: selected_location_category_image)!, scaledToSize:CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
                }
            } else {
                let lat = CLLocationDegrees(locationInfo[index].latitude)
                let long = CLLocationDegrees(locationInfo[index].longitude)

                let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                let marker = GMSMarker(position: position)
                marker.title = locationInfo[index].barTitle
                //Here pass object you want to show in card it can be array or any thing
                marker.userData = index //Pass some object
                marker.map = googleMapView
                marker.icon = self.imageWithImage(image: UIImage(named: "ico_unselected_location")!, scaledToSize: CGSize(width: Common.imageSize[0].width / 2, height: Common.imageSize[0].height / 2))
            }

        }
        
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UILabel? {
        
        var length = marker.title?.characters.count
        if length! > 20 {
            length = 20
        }
        
        var width = CGFloat(Common.fontsizeModel[0].scale_value)*CGFloat(length!) + 20.0
        
        let label = UIBorderedLabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: Common.fontsizeModel[0].deal_name_size))
        label.text = marker.title
        label.font = UIFont.systemFont(ofSize: Common.fontsizeModel[0].small_comment_size)
        label.layer.cornerRadius = label.frame.height / 2
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        
        let data = marker.userData
        let i:Int = data as! Int
        
        if locationInfo[i].category_name == "Nightlife" {
            
            label.backgroundColor = MyColor.MarkLabelCategory0()
            
        }
        else if locationInfo[i].category_name == "Health & Fitness" {
            
            label.backgroundColor = MyColor.MarkLabelCategory1()
            
        }
        else if locationInfo[i].category_name == "Hair & Beauty" {
            
            label.backgroundColor = MyColor.MarkLabelCategory2()
            
        }
        else {
            
            label.backgroundColor = MyColor.customCircleFillColor()
        }
        
        label.layer.masksToBounds = true
        return label
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationInfo.count
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        originIndexPath = indexPath as IndexPath
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cus_bar", for: indexPath) as? CustomerBarCell
        
        
        //font size set
        cell?.barTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        cell?.musicTypeLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        cell?.remainLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
       
        
        cell?.barView.layer.cornerRadius = 5
        cell?.remainingView.layer.cornerRadius = 5
        
        cell?.remainLabel.text = locationInfo[indexPath.row].selectcategory_deal[0].remain
        
        let url = URL(string: locationInfo[indexPath.row].barImage)
        cell?.barImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ico_app_logo"))
        if DeviceType.IS_IPHONE_5 {
            
        }  else if DeviceType.IS_IPHONE_6{

        } else if DeviceType.IS_IPHONE_7 {

        }else if DeviceType.IS_IPHONE_7P {
           cell?.barImageView.frame = CGRect.init(x: (cell?.barImageView.frame.origin.x)!, y: (cell?.barImageView.frame.origin.y)!, width: 50, height: 53)
        } else {
            cell?.barImageView.frame = CGRect.init(x: (cell?.barImageView.frame.origin.x)!, y: (cell?.barImageView.frame.origin.y)!, width: 50, height: 50)
        }
        
        
        
        cell?.barTitleLabel.text = locationInfo[indexPath.row].barTitle
        cell?.musicTypeLabel.text = locationInfo[indexPath.row].music_type
        cell?.detailBtn.addTarget(self, action: #selector(BarDetail), for: .touchUpInside)
        
        locationInfo_card = [LocationModel]()
        locationInfo_card += [LocationModel(index_num: locationInfo[indexPath.row].index_num, latitude: 0.0, longitude: 0.0, selectcategory_deal: locationInfo[indexPath.row].selectcategory_deal, barImage: "", barTitle: "", music_type: "", category_name: locationInfo[indexPath.row].category_name, address: "", service_name:"")]
        card_deals = [BarDetailModel]()
        for j in 0...locationInfo_card[0].selectcategory_deal.count - 1 {
            
            var deal_title = locationInfo_card[0].selectcategory_deal[j].deal_title
            var deal_description = locationInfo_card[0].selectcategory_deal[j].deal_description
            card_deals += [BarDetailModel(deal_title, deal_description, "", "", j)]
        }
        
        cell?.kolodaView.dataSource = self
        cell?.kolodaView.delegate = self
        cell?.kolodaView.resetCurrentCardIndex()
        cell?.kolodaView.reloadData()
        cell?.kolodaView.layer.cornerRadius = 5
        
        return (cell)!
    }
    
    @IBAction func BarDetail(_ sender: Any){
        googleMapView.removeFromSuperview()
        
        if locationInfo.count > 0 {
            for i in 0...locationInfo.count-1 {
                if select_bar_id == locationInfo[i].index_num {
                    Common.select_pos = i
                    //                    Common.select_page_in = i
                    Common.select_barid = select_bar_id
                    break
                } else {
                    Common.select_barid = locationInfo[0].index_num
                }
            }
        }
        
        Impression_Add() // Impression Api Call
        
//        Common.search_string = ""
        Common.fromBarDetail_toMap_flag = false
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerBarDetailViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    func changeremainLabel(_ flag: Bool) {
//        self.remainLabel.isHidden = flag
    }
    //MARK: HWSwiftyViewPagerDelegate
    func pagerDidSelecedPage(_ selectedPage: Int) {
        
        googleMapView.clear()
        
        // from BarDetail for card align center
        let nextIndexPath:NSIndexPath = NSIndexPath(row: Common.select_page_in, section: (originIndexPath?.section)!)
        cell = self.viewPager.dequeueReusableCell(withReuseIdentifier: "cus_bar", for: nextIndexPath as IndexPath) as? CustomerBarCell
        cell?.kolodaView.resetCurrentCardIndex()

        temp_index_count = 0
        var selected_location_category_image : String = ""
        
        barIdArray_impressions = [String]()

        Common.select_page_in = selectedPage
        select_bar_id = locationInfo[selectedPage].index_num
        let camera = GMSCameraPosition.camera(withLatitude: locationInfo[selectedPage].latitude,
                                              longitude: locationInfo[selectedPage].longitude,
                                              zoom: 15)
        
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = false
        if DeviceType.IS_IPHONE_5 {
            googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        }
        else {
            googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 180, right: 0)
        }

        googleMapView.camera = camera
        googleMapView.delegate = self
        
        let select_location = CLLocation(latitude : locationInfo[selectedPage].latitude, longitude: locationInfo[selectedPage].longitude)
        
        //add multiple markers on mapview
        for i in 0 ..< locationInfo.count {
            //On load show first marker as selected marker
            
            if i == selectedPage {
                locationInfo_card = [LocationModel]()
                locationInfo_card += [LocationModel(index_num: locationInfo[selectedPage].index_num, latitude: 0.0, longitude: 0.0, selectcategory_deal: locationInfo[selectedPage].selectcategory_deal, barImage: "", barTitle: locationInfo[selectedPage].barTitle, music_type: "", category_name: locationInfo[selectedPage].category_name, address: "", service_name:"")]
                card_deals = [BarDetailModel]()
                for j in 0...locationInfo_card[0].selectcategory_deal.count - 1 {
                    
                    var deal_title = locationInfo_card[0].selectcategory_deal[j].deal_title
                    var deal_description = locationInfo_card[0].selectcategory_deal[j].deal_description
                    card_deals += [BarDetailModel(deal_title, deal_description, "", "", j)]
                }
                
                let lat = CLLocationDegrees(locationInfo[i].latitude)
                let long = CLLocationDegrees(locationInfo[i].longitude)
                
                let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                let marker = GMSMarker(position: position)
                marker.title = locationInfo[i].barTitle
                
                //Here pass object you want to show in card it can be array or any thing
                marker.userData = i //Pass some object
                marker.map = googleMapView
                marker.zIndex = 1
                
                if locationInfo[i].category_name == "Nightlife" {
                    selected_location_category_image = "ico_blue_location"
                }
                else if locationInfo[i].category_name == "Health & Fitness" {
                    selected_location_category_image = "ico_yellow_icon"
                }
                else if locationInfo[i].category_name == "Hair & Beauty" {
                    selected_location_category_image = "ico_red_location"
                }
                else {
                    selected_location_category_image = "ico_selected_location"
                }
                marker.icon = self.imageWithImage(image: UIImage(named: selected_location_category_image)!, scaledToSize: CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
                
                googleMapView.selectedMarker = marker
                if Common.flagOfMapViewFromCategory == true {
                    categoryLabel.text = Common.selectcategory[i].category_name
                    if (categoryLabel.text?.isEmpty)! {
                        categoryLabel.isHidden = true
                    }
                    else{
                        categoryLabel.isHidden = false
                        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
                        categoryLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
                        //                        categoryLabel = UIBorderedLabel.init(frame: CGRect.init(x: 0, y: 0, width: categoryLabel.frame.width, height: Common.fontsizeModel[0].bar_name_size))
                        categoryLabel.layer.masksToBounds = true
                        
                    }
                }
                
                // get bar_array for engagement
                barIdArray_engagement.append(String(locationInfo[selectedPage].index_num))
                
            }
            else {
                let lat = CLLocationDegrees(locationInfo[i].latitude)
                let long = CLLocationDegrees(locationInfo[i].longitude)
                
                let fromlocation = CLLocation(latitude : locationInfo[i].latitude, longitude: locationInfo[selectedPage].longitude)
                let distance = select_location.distance(from: fromlocation)
                if distance <= 1609.0 {
                    barIdArray_impressions.append(String(locationInfo[i].index_num))
                }
                
                // get bar_array for impressions
                barIdArray_impressions.append(String(locationInfo[selectedPage].index_num))
                barIdArray_impressions.uniqInPlace()
                
                let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                let marker = GMSMarker(position: position)
                marker.title = locationInfo[i].barTitle
                
                //Here pass object you want to show in card it can be array or any thing
                marker.userData = i //Pass some object
                marker.map = googleMapView
                marker.icon = self.imageWithImage(image: UIImage(named: "ico_unselected_location")!, scaledToSize: CGSize(width: Common.imageSize[0].width / 2, height: Common.imageSize[0].height / 2))
            }
        }        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        //image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func SearchSwitchAction(_ sender: Any) {
        
        if Common.category_name == "Nightlife" {
            if Common.search_switch_flag == 0 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a bar", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_nightlife_search.jpg"), for: .normal)
                Common.search_switch_flag = 1
            }
            else if Common.search_switch_flag == 1 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
                Common.search_switch_flag = 0
            }
        }
        else if Common.category_name == "Health & Fitness" {
            if Common.search_switch_flag == 0 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a venue", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_health_search.jpg"), for: .normal)
                Common.search_switch_flag = 1
            }
            else if Common.search_switch_flag == 1 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
                Common.search_switch_flag = 0
            }
        }
        else if Common.category_name == "Hair & Beauty" {
            if Common.search_switch_flag == 0 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a beauty salon", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_hair_search.jpg"), for: .normal)
                Common.search_switch_flag = 1
            }
            else if Common.search_switch_flag == 1 {
                searchTextField.attributedPlaceholder = NSAttributedString(string: "Search an area", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                btnSearchSwitch.setImage(UIImage(named: "ico_area.jpg"), for: .normal)
                Common.search_switch_flag = 0
            }
        } else {
            Common.search_switch_flag = 1
            btnSearchSwitch.isHidden = true
            btnSearchSwitch.isEnabled = false
        }
    }
    
    @IBAction func SearchAction(_ sender: Any) {
        
        Common.fromBarDetail_toMap_flag = false
        var search_string : String = ""
        search_string = self.searchTextField.text!
        
        if search_string.isEmpty && search_flag == false {
            
            Common.search_string = search_string
            self.search_action(Common.search_string)
        }
        else if !search_string.isEmpty && search_flag == false {
            
            btnSearch.setImage(UIImage(named: "ico_close_search"), for: .normal)
            Common.search_string = search_string.lowercased()
            self.search_action(Common.search_string)
            search_flag = true
        }
        else if !search_string.isEmpty && search_flag == true {
            
            btnSearch.setImage(UIImage(named: "ico_search"), for: .normal)
            search_string = ""
            self.searchTextField.text = ""
            Common.search_string = search_string.lowercased()
            self.search_action(Common.search_string)
            search_flag = false
        }
    }
        
    func search_action(_ search_string : String) {
        googleMapView.clear()
        categoryLabel.isHidden = true
        if search_string == "" {
            
            locationInfo = [LocationModel]()
            
            //add multiple markers on mapview
            if Common.flagOfMapViewFromCategory == true {
                googleMapView.delegate = self
                let camera = GMSCameraPosition.camera(withLatitude: Common.selectcategory[0].latitude,
                                                      longitude: Common.selectcategory[0].longitude,
                                                      zoom: 15)
                
                googleMapView.isMyLocationEnabled = true
                googleMapView.settings.compassButton = true
                googleMapView.settings.zoomGestures = false

                if DeviceType.IS_IPHONE_5 {
                    googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
                }
                else {
                    googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 180, right: 0)
                }

                
                googleMapView.camera = camera
                
                locationInfo = [LocationModel]()
                for i in 0 ..< Common.selectcategory.count {
                    let lat = Common.selectcategory[i].latitude
                    let long = Common.selectcategory[i].longitude
                    
                    var latitude = lat
                    var longitude = long
                    var barImage = Common.selectcategory[i].barImage
                    var barTitle = Common.selectcategory[i].barTitle
                    var music_type = Common.selectcategory[i].music_type
                    var bar_id = Common.selectcategory[i].index_num
                    var address = Common.selectcategory[i].address
                    var service_name = Common.selectcategory[i].service_name
                    
                    var category_deal = [SelectCategoryDeal]()
                    category_deal = Common.selectcategory[i].selectcategory_deal
                    
                    locationInfo += [LocationModel(index_num: Int(bar_id), latitude: latitude, longitude: longitude, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle, music_type: music_type, category_name: Common.selectcategory[i].category_name, address: address, service_name:service_name)]
                    
                    categoryLabel.text = locationInfo[i].category_name
                    
                    if categoryLabel.text == "" {
                        categoryLabel.isHidden = true
                    }
                    else {
                        categoryLabel.isHidden = false
                        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
                        categoryLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
                        categoryLabel.layer.masksToBounds = true
                    }
                    
                    let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                    let marker = GMSMarker(position: position)
                    marker.title = locationInfo[i].barTitle
                    
                    //Here pass object you want to show in card it can be array or any thing
                    marker.userData = i //Pass some object
                    marker.map = googleMapView
                    
                    var selected_location_category_image : String = ""

                    //On load show first marker as selected marker
                    if i == Common.select_page_in {
                        googleMapView.selectedMarker = marker
                        //                marker.icon = UIImage(named: "ico_selected_location")
                        marker.zIndex = 1
                        
                        if Common.selectcategory[i].category_name == "Nightlife" {
                            
                            selected_location_category_image = "ico_blue_location"
                        }
                        else if Common.selectcategory[i].category_name == "Health & Fitness" {
                            
                            selected_location_category_image = "ico_yellow_icon"
                            
                        }
                        else if Common.selectcategory[i].category_name == "Hair & Beauty" {
                            
                            selected_location_category_image = "ico_red_location"
                            
                        }
                        else {
                            
                            selected_location_category_image = "ico_selected_location"
                        }
                        marker.icon = self.imageWithImage(image: UIImage(named: selected_location_category_image)!, scaledToSize: CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))

                    }
                    else {
                        
                        marker.icon = self.imageWithImage(image: UIImage(named: "ico_unselected_location")!, scaledToSize: CGSize(width: Common.imageSize[0].width / 2, height: Common.imageSize[0].height / 2))
                    }
                }

                self.viewPager.dataSource = self
                self.viewPager.pageSelectedDelegate = self
                self.viewPager.reloadData()
                self.viewPager.setPage(Common.select_page_in, isAnimation: true)
            }
            
        } else {
            searchlocationInfo = [LocationModel]()
            if Common.search_switch_flag == 0 { // Search an area
                /*
                if Common.fromBarDetail_toMap_flag == false {
                    Common.select_page_in = 0
                }
                
                searchlocationInfo = [LocationModel]()
                for i in 0 ..< Common.selectcategory.count {
//                    var filterString = Common.selectcategory[i].address
//                    if filterString.lowercased().contains(search_string) {
                        let lat = Common.selectcategory[i].latitude
                        let long = Common.selectcategory[i].longitude
                        var latitude = lat
                        var longitude = long
                        
                        var barImage = Common.selectcategory[i].barImage
                        var barTitle = Common.selectcategory[i].barTitle
                        var music_type = Common.selectcategory[i].music_type
                        var bar_id = Common.selectcategory[i].index_num
                        var address = Common.selectcategory[i].address
                        var service_name = Common.selectcategory[i].service_name
                        
                        var category_deal = [SelectCategoryDeal]()
                        category_deal = Common.selectcategory[i].selectcategory_deal
                        
                        searchlocationInfo += [LocationModel(index_num: Int(bar_id), latitude: latitude, longitude: longitude, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle, music_type: music_type, category_name: Common.selectcategory[i].category_name, address: address, service_name:service_name)]
//                    }
                }
                 */
                
                var geocoder = CLGeocoder()
                geocoder.geocodeAddressString(search_string) {
                    placemarks, error in
                    let placemark = placemarks?.first
                    let latitude = placemark?.location?.coordinate.latitude
                    let longitude = placemark?.location?.coordinate.longitude
//                    print("Lat: \(lat), Lon: \(lon)")
                    
                    let camera = GMSCameraPosition.camera(withLatitude: latitude!,
                                                          longitude: longitude!,
                                                          zoom: 15)
//                    googleMapView.isMyLocationEnabled = true
//                    googleMapView.settings.compassButton = true
//                    googleMapView.settings.zoomGestures = false
//                    if DeviceType.IS_IPHONE_5 {
//                        googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
//                    }
//                    else {
//                        googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 180, right: 0)
//                    }
                    
                    self.googleMapView.camera = camera
                }
            
            }
            else if Common.search_switch_flag == 1 { // Search a bar
                
                if Common.fromBarDetail_toMap_flag == false {
                    Common.select_page_in = 0
                }
                // dragon
                searchlocationInfo = [LocationModel]()
                for i in 0 ..< Common.selectcategory.count {
                    var filterString = Common.selectcategory[i].barTitle
                    var filterString1 = Common.selectcategory[i].service_name
                    if filterString.lowercased().contains(search_string) || filterString1.lowercased().contains(search_string) {
                        let lat = Common.selectcategory[i].latitude
                        let long = Common.selectcategory[i].longitude
                        var latitude = lat
                        var longitude = long
                        
                        var barImage = Common.selectcategory[i].barImage
                        var barTitle = Common.selectcategory[i].barTitle
                        var music_type = Common.selectcategory[i].music_type
                        var bar_id = Common.selectcategory[i].index_num
                        var address = Common.selectcategory[i].address
                        var service_name = Common.selectcategory[i].service_name
                        
                        var category_deal = [SelectCategoryDeal]()
                        category_deal = Common.selectcategory[i].selectcategory_deal
                        
                        searchlocationInfo += [LocationModel(index_num: Int(bar_id), latitude: latitude, longitude: longitude, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle, music_type: music_type, category_name: Common.selectcategory[i].category_name, address: address, service_name:service_name)]
                        
                    }
                    
                }
            }
            
            if searchlocationInfo.count > 0 {
                locationInfo = [LocationModel]()
                locationInfo = searchlocationInfo
                var latitude = locationInfo[0].latitude
                var longitude = locationInfo[0].longitude
                select_bar_id = locationInfo[0].index_num
                googleMapView.clear()
                googleMapView.delegate = self
                let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                                      longitude: longitude,
                                                      zoom: 15)
                googleMapView.isMyLocationEnabled = true
                googleMapView.settings.compassButton = true
                googleMapView.settings.zoomGestures = false
                if DeviceType.IS_IPHONE_5 {
                    googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
                }
                else {
                    googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 180, right: 0)
                }

                googleMapView.camera = camera
                
                for i in 0...locationInfo.count - 1 {
                    let lat = CLLocationDegrees(locationInfo[i].latitude)
                    let long = CLLocationDegrees(locationInfo[i].longitude)
                    
                    var latitude = lat
                    var longitude = long
                    
                    let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                    let marker = GMSMarker(position: position)
                    marker.title = locationInfo[i].barTitle
                    
                    //Here pass object you want to show in card it can be array or any thing
                    marker.userData = i //Pass some object
                    marker.map = googleMapView
                    
                    categoryLabel.text = locationInfo[i].category_name
                    
                    if categoryLabel.text == "" {
                        categoryLabel.isHidden = true
                    }
                    else {
                        categoryLabel.isHidden = false
                        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
                        categoryLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
                        //                        categoryLabel = UIBorderedLabel.init(frame: CGRect.init(x: 0, y: 0, width: categoryLabel.frame.width, height: Common.fontsizeModel[0].bar_name_size))
                        categoryLabel.layer.masksToBounds = true
                    }
                    
                    var selected_location_category_image : String = ""

                    //On load show first marker as selected marker
                    if i == 0 {
                        googleMapView.selectedMarker = marker
                        marker.zIndex = 1
                        if Common.flagOfMapViewFromCategory == true {
                            if Common.selectcategory[i].category_name == "Nightlife" {
                                selected_location_category_image = "ico_blue_location"
                            }
                            else if Common.selectcategory[i].category_name == "Health & Fitness" {
                                selected_location_category_image = "ico_yellow_icon"
                            }
                            else if Common.selectcategory[i].category_name == "Hair & Beauty" {
                                
                                selected_location_category_image = "ico_red_location"
                                
                            }
                            else {
                                
                                selected_location_category_image = "ico_selected_location"
                            }
                        } else {
                            
                            if locationInfo[i].category_name == "Nightlife" {
                                
                                selected_location_category_image = "ico_selected_location_category1"
                            }
                            else if locationInfo[i].category_name == "Health & Fitness" {
                                
                                selected_location_category_image = "ico_selected_location_category2"
                                
                            }
                            else if locationInfo[i].category_name == "Hair & Beauty" {
                                
                                selected_location_category_image = "ico_selected_location_category3"
                                
                            }
                            else {
                                
                                selected_location_category_image = "ico_selected_location"
                            }
                        }
                        marker.icon = self.imageWithImage(image: UIImage(named: selected_location_category_image)!, scaledToSize: CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
                    }
                    else {
                        marker.icon = self.imageWithImage(image: UIImage(named: "ico_unselected_location")!, scaledToSize: CGSize(width: Common.imageSize[0].width / 2, height: Common.imageSize[0].height / 2))
                    }
                }
                self.viewPager.dataSource = self
                self.viewPager.pageSelectedDelegate = self
                self.viewPager.reloadData()
                self.viewPager.setPage(Common.select_page_in, isAnimation: true)
            }
            else {
                if (Common.search_switch_flag == 0) {
                    return
                }
                MessageBoxViewController.showAlert(self, title: "Alert", message: "There is no data you required")
                searchTextField.text = ""
                googleMapView.clear()
                
                if Common.flagOfMapViewFromCategory == true {
                    locationInfo = [LocationModel]()
                    googleMapView.delegate = self
                    let camera = GMSCameraPosition.camera(withLatitude: Common.selectcategory[0].latitude,
                                                          longitude: Common.selectcategory[0].longitude,
                                                          zoom: 15)
                    googleMapView.isMyLocationEnabled = true
                    googleMapView.settings.compassButton = true
                    googleMapView.settings.zoomGestures = false

                    googleMapView.camera = camera
                    
                    locationInfo = [LocationModel]()
                    for i in 0 ..< Common.selectcategory.count {
                        let lat = Common.selectcategory[i].latitude
                        let long = Common.selectcategory[i].longitude
                        
                        var latitude = lat
                        var longitude = long
                        
                        var barImage = Common.selectcategory[i].barImage
                        var barTitle = Common.selectcategory[i].barTitle
                        var music_type = Common.selectcategory[i].music_type
                        var bar_id = Common.selectcategory[i].index_num
                        var address = Common.selectcategory[i].address
                        var service_name = Common.selectcategory[i].service_name
                        
                        var category_deal = [SelectCategoryDeal]()
                        category_deal = Common.selectcategory[i].selectcategory_deal
                        
                        locationInfo += [LocationModel(index_num: Int(bar_id), latitude: latitude,longitude: longitude, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle, music_type: music_type, category_name: Common.selectcategory[i].category_name, address: address, service_name:service_name)]
                        
                        categoryLabel.text = locationInfo[i].category_name
                        
                        if categoryLabel.text == "" {
                            categoryLabel.isHidden = true
                        }
                        else {
                            categoryLabel.isHidden = false
                            categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
                            categoryLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
                            //                            categoryLabel = UIBorderedLabel.init(frame: CGRect.init(x: 0, y: 0, width: categoryLabel.frame.width, height: Common.fontsizeModel[0].bar_name_size))
                            categoryLabel.layer.masksToBounds = true
                        }
                        
                        let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
                        let marker = GMSMarker(position: position)
                        marker.title = locationInfo[i].barTitle
                        
                        //Here pass object you want to show in card it can be array or any thing
                        marker.userData = i //Pass some object
                        marker.map = googleMapView
                        
                        var selected_location_category_image : String = ""
                        
                        //On load show first marker as selected marker
                        if i == Common.select_page_in {
                            googleMapView.selectedMarker = marker
                            //                marker.icon = UIImage(named: "ico_selected_location")
                            marker.zIndex = 1
                            
                            if Common.selectcategory[i].category_name == "Nightlife" {
                                
                                selected_location_category_image = "ico_selected_location_category1"
                            }
                            else if Common.selectcategory[i].category_name == "Health & Fitness" {
                                
                                selected_location_category_image = "ico_selected_location_category2"
                                
                            }
                            else if Common.selectcategory[i].category_name == "Hair & Beauty" {
                                
                                selected_location_category_image = "ico_selected_location_category3"
                                
                            }
                            else {
                                
                                selected_location_category_image = "ico_selected_location"
                            }
                            marker.icon = self.imageWithImage(image: UIImage(named: selected_location_category_image)!, scaledToSize: CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
                        }
                        else {
                            
                            marker.icon = self.imageWithImage(image: UIImage(named: "ico_unselected_location")!, scaledToSize: CGSize(width: Common.imageSize[0].width / 2, height: Common.imageSize[0].height / 2))
                        }
                    }
                    self.viewPager.dataSource = self
                    self.viewPager.pageSelectedDelegate = self
                    self.viewPager.reloadData()
                    self.viewPager.setPage(Common.select_page_in, isAnimation: true)
                }
            }
        }
        
    }
    
    func Impression_Add()
    {
        
        //up to server
        let url = Common.api_location + "add_impressions.php"
        let params = ["user_id": user_id,
                      "bar_id_list": barIdArray_impressions,
                      "engagement_list": barIdArray_engagement] as [String : Any]
        
        do {
            let opt = try HTTP.POST(url, parameters: params)
            
            self.view.isUserInteractionEnabled = false
            
            
            //get from server
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.view.isUserInteractionEnabled = true
                        
                        // MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        return
                    })
                    
                }
                do {
                    
                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                    
                } catch {
                    // //Toast.toast("Json string error: \(error)")
                }
            }
        } catch let error {
            // //Toast.toast("Request error: \(error)")
        }
    }
    
    @IBAction func GotoWallet(_ sender: Any) {
        googleMapView.removeFromSuperview()
        Impression_Add() // Impression Api Call
        
        Common.search_string = ""
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddWalletView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @IBAction func Select_CategoryAction(_ sender: Any) {
        googleMapView.removeFromSuperview()
        Common.select_page_in = 0
        Common.flagOfMapViewFromCategory = false
        Common.category_name = ""
        Common.search_string = ""
        Common.search_switch_flag = 0
        
        Impression_Add() // Impression Api Call
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    // koloda part //////////////////////////////////////////
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        let position = koloda.currentCardIndex
//
//        locationInfo_card = [LocationModel]()
//        locationInfo_card += [LocationModel(index_num: locationInfo[Common.select_page_in].index_num, latitude: 0.0, longitude: 0.0, selectcategory_deal: locationInfo[Common.select_page_in].selectcategory_deal, barImage: "", barTitle: "", music_type: "", category_name: locationInfo[Common.select_page_in].category_name, address: "")]
//
//        if locationInfo_card[0].selectcategory_deal.count > 0 {
//            card_deals = [BarDetailModel]()
//            for j in 0...locationInfo_card[0].selectcategory_deal.count - 1 {
//
//                var deal_title = locationInfo_card[0].selectcategory_deal[j].deal_title
//                var deal_description = locationInfo_card[0].selectcategory_deal[j].deal_description
//                card_deals += [BarDetailModel(deal_title, deal_description, "", "", j)]
//            }
//            koloda.insertCardAtIndexRange(position..<position + card_deals.count, animated: true)
//        }
    }
    // for card view tap action
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
       googleMapView.removeFromSuperview()
        //        let superview = (sender as AnyObject).superview
        //        let cell = superview??.superview as? CustomerBarCell
        
        if locationInfo.count > 0 {
            for i in 0...locationInfo.count-1 {
                if select_bar_id == locationInfo[i].index_num {
                    Common.select_pos = i
                    //                    Common.select_page_in = i
                    Common.select_barid = select_bar_id
                    break
                } else {
                    Common.select_barid = locationInfo[0].index_num
                }
            }
        }
        
        Impression_Add() // Impression Api Call
        
//        Common.search_string = ""
        Common.fromBarDetail_toMap_flag = false
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerBarDetailViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        index_viewcount = card_deals.count
        
        return card_deals.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda : KolodaView, shouldSwipeCardAt index: Int, in direction : SwipeResultDirection)->Bool {
        
        temp_index_count = 1
        var get_index = koloda.currentCardIndex
        //
        locationInfo_card = [LocationModel]()
        locationInfo_card += [LocationModel(index_num: locationInfo[Common.select_page_in].index_num, latitude: 0.0, longitude: 0.0, selectcategory_deal: locationInfo[Common.select_page_in].selectcategory_deal, barImage: "", barTitle: "", music_type: "", category_name: locationInfo[Common.select_page_in].category_name, address: "", service_name:"")]
        card_deals = [BarDetailModel]()
        for j in 0...locationInfo_card[0].selectcategory_deal.count - 1 {
            
            var deal_title = locationInfo_card[0].selectcategory_deal[j].deal_title
            var deal_description = locationInfo_card[0].selectcategory_deal[j].deal_description
            card_deals += [BarDetailModel(deal_title, deal_description, "", "", j)]
        }
        
        //
        var card_deal_count = card_deals.count
        index_count = get_index + 1
        if index_count < card_deals.count  {
            var remaindata = locationInfo[Common.select_page_in].selectcategory_deal[index_count].remain
            
            let nextIndexPath:NSIndexPath = NSIndexPath(row: Common.select_page_in, section: (originIndexPath?.section)!)
            cell = self.viewPager.cellForItem(at: nextIndexPath as IndexPath) as! CustomerBarCell
            cell?.remainLabel.text = remaindata
            
            index_count += 1
            return true
        }else {
            koloda.resetCurrentCardIndex()
            koloda.reloadData()
            var get_index = koloda.currentCardIndex
            index_count = 0
            
            var remaindata = locationInfo[Common.select_page_in].selectcategory_deal[index_count].remain
            let nextIndexPath:NSIndexPath = NSIndexPath(row: Common.select_page_in, section: (originIndexPath?.section)!)
            cell = self.viewPager.cellForItem(at: nextIndexPath as IndexPath) as! CustomerBarCell
            cell?.remainLabel.text = remaindata
            return false
        }
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        var index = koloda.currentCardIndex
        
        return true
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        if temp_index_count == 0 {

            temp_index_count = 1

            koloda.reloadData()
        }
        let temp = temp_index_count
        var deal_image : String = ""
        
        let infoWindow = DetailInfoWindow_small.instanceFromNib() as! DetailInfoWindow_small
        
        infoWindow.layer.cornerRadius = 8
        infoWindow.layer.masksToBounds = true
        
        infoWindow.deal_title.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        infoWindow.deal_description.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        
        if index  > card_deals.count-1 {
            koloda.resetCurrentCardIndex()
        } else {
            infoWindow.deal_title.text = card_deals[index].deal_name
            infoWindow.deal_description.text = card_deals[index].deal_description
            
            if Common.flagOfMapViewFromCategory == true {
                if locationInfo_card[0].category_name == "Nightlife" {
                    
                    deal_image = "ico_ticket_active_category1"
                    
                }
                else if locationInfo_card[0].category_name == "Health & Fitness" {
                    
                    deal_image = "ico_ticket_active_category2"
                    
                }
                else if locationInfo_card[0].category_name == "Hair & Beauty" {
                    
                    deal_image = "ico_ticket_active_category3"
                    
                }
                else {
                    
                    deal_image = "ico_ticket_active"
                }
            }
            
            infoWindow.dealImageView.image = UIImage(named: deal_image)
        }
        
        return infoWindow
    }
    ////////////////////////////////////////////////////////////////////
}


// Array make without duplicate elements
extension Array where Element: Equatable {
    
    public func uniq() -> [Element] {
        var arrayCopy = self
        arrayCopy.uniqInPlace()
        return arrayCopy
    }
    
    mutating public func uniqInPlace() {
        var seen = [Element]()
        var index : Int = 0
        for element in self {
            if seen.contains(element) {
                remove(at: index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }
}

