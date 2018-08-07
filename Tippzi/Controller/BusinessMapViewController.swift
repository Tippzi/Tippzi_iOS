//
//  BusinessMapViewController.swift
//  Tippzi
//
//  Created by Admin on 11/23/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import Koloda
import SDWebImage

class BusinessMapViewController: UIViewController, GMSMapViewDelegate, UICollectionViewDataSource, HWSwiftyViewPagerDelegate, KolodaViewDelegate,  KolodaViewDataSource  {
    
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var businessListLabel: UILabel!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var barViewPager: HWSwiftyViewPager!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var locationInfo = [LocationModel]()
    
    var card_deals = [BarDetailModel]()
    var index_count : Int = 0
    var card_index : Int = 0
    var bar_cell : BarItemCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activeIndicator.isHidden = true
        
        self.barViewPager.dataSource = self
        self.barViewPager.pageSelectedDelegate = self
        
        //font size set
        businessListLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        remainLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        
        view.addConstraint(NSLayoutConstraint(item: self.barViewPager, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 500))
        
        var latitude = Double(Common.businessModel.bars[0].lat!)
        var longitude = Double(Common.businessModel.bars[0].lon!)
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude!,
                                              longitude: longitude!,
                                              zoom: 15)
        
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = false
//        googleMapView.settings.myLocationButton = true
//        if DeviceType.IS_IPHONE_5 {
//            googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 190, right: 0)
//        }
//        else {
//            googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 230, right: 0)
//        }
        
        googleMapView.camera = camera
        
        locationInfo = [LocationModel]()
        
        googleMapView.delegate = self
        
        //add multiple markers on mapview
        
        var barImage : String = ""
        
        if !(Common.businessModel.bars[0].background1?.isEmpty)! {
            barImage = Common.download + Common.businessModel.bars[0].background1!
        } else if (!(Common.businessModel.bars[0].background2?.isEmpty)!) {
            barImage = Common.download +  Common.businessModel.bars[0].background2!
        } else if (!(Common.businessModel.bars[0].background3?.isEmpty)!) {
            barImage = Common.download + Common.businessModel.bars[0].background3!
        } else if (!(Common.businessModel.bars[0].background4?.isEmpty)!) {
            barImage = Common.download + Common.businessModel.bars[0].background4!
        } else if (!(Common.businessModel.bars[0].background5?.isEmpty)!) {
            barImage = Common.download + Common.businessModel.bars[0].background5!
        } else if (!(Common.businessModel.bars[0].background6?.isEmpty)!) {
            barImage = Common.download + Common.businessModel.bars[0].background6!
        }
        
        var barTitle = Common.businessModel.bars[0].business_name
        var music_type = Common.businessModel.bars[0].music_type
        var address = Common.businessModel.bars[0].address
        var service_name = Common.businessModel.bars[0].service_name
        
        let lat = CLLocationDegrees(Common.businessModel.bars[0].lat!)
        let long = CLLocationDegrees(Common.businessModel.bars[0].lon!)
        
        var category_deal = [SelectCategoryDeal]()
        var remain_number : Int = 0
        for i in 0 ..< Common.businessModel.bars[0].deal.count {
            
            var deal_title = Common.businessModel.bars[0].deal[i].title
            var deal_description = Common.businessModel.bars[0].deal[i].description
            remain_number = Int(Common.businessModel.bars[0].deal[i].qty!)! - Int(Common.businessModel.bars[0].deal[i].claimed!)!
            var remain = String(remain_number) + " remaining Exp " + Common.businessModel.bars[0].deal[i].duration!
            
            category_deal += [SelectCategoryDeal(deal_title: deal_title!, deal_description: deal_description!, remain: remain)]
        }
        
        locationInfo += [LocationModel(index_num: 1, latitude: latitude!, longitude: longitude!, selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle!, music_type: music_type!, category_name: Common.businessModel.bars[0].category!, address: address!, service_name: service_name!)]
        
        if locationInfo[0].selectcategory_deal.count > 0 {
            
            for i in 0...locationInfo[0].selectcategory_deal.count - 1 {
                
                var deal_title = locationInfo[0].selectcategory_deal[i].deal_title
                var deal_description = locationInfo[0].selectcategory_deal[i].deal_description
                card_deals += [BarDetailModel(deal_title, deal_description, "", "", i)]
            }
        }
        
        let position = CLLocationCoordinate2D(latitude: lat! , longitude: long! )
        let marker = GMSMarker(position: position)
        marker.title = Common.businessModel.bars[0].business_name
        
        //Here pass object you want to show in card it can be array or any thing
        marker.userData = 1 //Pass some object
        marker.map = googleMapView
        
        googleMapView.selectedMarker = marker
        
        marker.icon = self.imageWithImage(UIImage(named: "ico_selected_location")!, scaledToSize: CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        //        self.barViewPager.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.barViewPager.reloadData()
    }
    @IBAction func MyLocationView(_ sender: Any) {
        googleMapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude, longitude: Common.Coordinate.longitude, zoom: 15.0)
        
        self.googleMapView.camera = camera
    }
    
    func changeremainLabel(_ flag: Bool) {
        
    }
    // make custom mapinfowindow
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UILabel? {
        
        var length = marker.title?.characters.count
        if length! > 20 {
            length = 20
        }
        var width = CGFloat(Common.fontsizeModel[0].scale_value)*CGFloat(length!) + 20
        let label = UIBorderedLabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 20))
        label.text = marker.title
        label.font = UIFont.systemFont(ofSize: Common.fontsizeModel[0].small_comment_size)
        label.layer.cornerRadius = label.frame.height / 2
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = MyColor.customCircleFillColor()
        label.layer.masksToBounds = true
        return label
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        //Get data passed to marker and you can show in card view or do any thing on marker click. This data object is associated to particular marker
        let data = marker.userData
        let i:Int = data as! Int
        // remove color from currently selected marker
        if mapView.selectedMarker != nil {
            marker.icon = self.imageWithImage(UIImage(named: "ico_selected_location")!, scaledToSize:CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
        }
        
        // select new marker and make green
        mapView.selectedMarker = marker
        
        //showCardView()
        self.barViewPager.setPage(i, isAnimation: true)
        
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bar_cell", for: indexPath) as! BarItemCell
        bar_cell = cell
        //font size set
        cell.remainLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        cell.barTitlelabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        cell.musicTypeLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        cell.remainLabel.text = locationInfo[indexPath.row].selectcategory_deal[0].remain
        remainLabel.text = locationInfo[indexPath.row].selectcategory_deal[card_index].remain
        var img = locationInfo[indexPath.row].barImage
//        if img != "" {
            let url = URL(string: locationInfo[indexPath.row].barImage)
//            let data = try? Data(contentsOf: url!)
//            cell.barImageView.image = self.imageWithImage(UIImage(data: data!)!, scaledToSize: CGSize(width: 30.0, height: 30.0))
            cell.barImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ico_app_logo"))
            cell.barImageView.layer.masksToBounds = false
            cell.barImageView.layer.cornerRadius = cell.barImageView.frame.size.height/2
            cell.barImageView.clipsToBounds = true
//        }
//        else {
//            cell.barImageView.image = self.imageWithImage(UIImage(named:"ico_ticket_active")!, scaledToSize: CGSize(width: 30.0, height: 30.0))
//        }
        
        cell.barTitlelabel.text = locationInfo[indexPath.row].barTitle
        cell.musicTypeLabel.text = locationInfo[indexPath.row].music_type
        cell.barView.layer.cornerRadius = 5
        
        cell.kolodaView.dataSource = self
        cell.kolodaView.delegate = self
        cell.kolodaView.layer.zPosition = 1
        cell.remainView.layer.cornerRadius = 5
        
        cell.detailviewBtn.addTarget(self, action: #selector(BarDetail), for: .touchUpInside)
        return cell
    }
    
    @IBAction func BarDetail(_ sender: Any){
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessBarDetailViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
        
    }
    
    //MARK: HWSwiftyViewPagerDelegate
    func pagerDidSelecedPage(_ selectedPage: Int) {
        
        let camera = GMSCameraPosition.camera(withLatitude: locationInfo[selectedPage].latitude,
                                              longitude: locationInfo[selectedPage].longitude,
                                              zoom: 15)
        
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = false
//        googleMapView.settings.myLocationButton = true
//        if DeviceType.IS_IPHONE_5 {
//            googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 190, right: 0)
//        }
//        else {
//            googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 230, right: 0)
//        }
        
        googleMapView.camera = camera
        googleMapView.delegate = self
        //add multiple markers on mapview
        for i in 0 ..< locationInfo.count {
            let lat = CLLocationDegrees(locationInfo[i].latitude)
            let long = CLLocationDegrees(locationInfo[i].longitude)
            
            let position = CLLocationCoordinate2D(latitude: lat , longitude: long )
            let marker = GMSMarker(position: position)
            marker.title = locationInfo[i].barTitle
            
            //Here pass object you want to show in card it can be array or any thing
            marker.userData = i //Pass some object
            marker.map = googleMapView
            
            //On load show first marker as selected marker
            googleMapView.selectedMarker = marker
            self.imageWithImage(UIImage(named: "ico_selected_location")!, scaledToSize:CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
            
        }
    }
    
    // koloda part //////////////////////////////////////////
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        let position = koloda.currentCardIndex
//
//        if locationInfo[0].selectcategory_deal.count > 0 {
//            for i in 0...locationInfo[0].selectcategory_deal.count - 1 {
//                var deal_title = locationInfo[0].selectcategory_deal[i].deal_title
//                var deal_description = locationInfo[0].selectcategory_deal[i].deal_description
//                card_deals += [BarDetailModel(deal_title, deal_description, "", "", i)]
//            }
//            koloda.insertCardAtIndexRange(position..<position + card_deals.count, animated: true)
//        }
    }
    
    // for card view tap action
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessBarDetailViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        var remaindata = locationInfo[0].selectcategory_deal[0].remain
        remainLabel.text = remaindata
        return card_deals.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda : KolodaView, shouldSwipeCardAt index: Int, in direction : SwipeResultDirection)->Bool {
        var get_index = koloda.currentCardIndex
        index_count = get_index + 1
        if index_count < card_deals.count  {
            bar_cell.remainLabel.text = locationInfo[0].selectcategory_deal[index_count].remain
            index_count += 1
            return true
        }
        else {
//            koloda.resetCurrentCardIndex()
//            koloda.reloadData()
//            var get_index = koloda.currentCardIndex
//            index_count = get_index + 1
            
            return false
        }
        
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        var index = koloda.currentCardIndex
        
        return true
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let infoWindow = DetailInfoWindow_small.instanceFromNib() as! DetailInfoWindow_small
        
        infoWindow.layer.cornerRadius = 8
        infoWindow.layer.masksToBounds = true
        
        infoWindow.deal_title.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        infoWindow.deal_description.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        
        infoWindow.deal_title.text = card_deals[index].deal_name
        infoWindow.deal_description.text = card_deals[index].deal_description
        
        self.card_index = index
        //        self.barViewPager.reloadData()
        
        return infoWindow
    }
    ////////////////////////////////////////////////////////////////////
    
    @objc func finishedResponse() {
        
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        if toViewController != nil {

            self.activeIndicator.isHidden = true
            self.activeIndicator.stopAnimating()
            
            let transition = CATransition()
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: false, completion:nil)
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        
    }
    func imageWithImage(_ image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        //image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

