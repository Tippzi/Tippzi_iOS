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

class TippziGoMapViewController: UIViewController, GMSMapViewDelegate
{
    
    @IBOutlet weak var wallet_countLabel: UILabel!
    @IBOutlet weak var googleMapView: GMSMapView!
    
    let defaults = UserDefaults.standard
    
    let locationTracker = LocationTracker(threshold: 10.0)
    
    var locationInfo = [TippziCoinModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let data = marker.userData
        let i:Int = data as! Int
        
        for index in 0 ..< locationInfo.count {
            let lat = CLLocationDegrees(locationInfo[index].latitude)
            let long = CLLocationDegrees(locationInfo[index].longitude)
            
            let position = CLLocationCoordinate2D(latitude: lat! , longitude: long! )
            let marker = GMSMarker(position: position)
            marker.title = ""
            //Here pass object you want to show in card it can be array or any thing
            marker.userData = index //Pass some object
            marker.map = googleMapView
            mapView.selectedMarker = marker
            marker.zIndex = 1
            
            marker.icon = self.imageWithImage(image: UIImage(named: "img_tippzi_coin.png")!, scaledToSize:CGSize(width: Common.imageSize[0].width, height: Common.imageSize[0].height))
        }
        
        return true
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        //image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UILabel? {
//
//        var length = marker.title?.characters.count
//        if length! > 20 {
//            length = 20
//        }
//
//        var width = CGFloat(Common.fontsizeModel[0].scale_value)*CGFloat(length!) + 20.0
//
//        let label = UIBorderedLabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: Common.fontsizeModel[0].deal_name_size))
//        label.text = marker.title
//        label.font = UIFont.systemFont(ofSize: Common.fontsizeModel[0].small_comment_size)
//        label.layer.cornerRadius = label.frame.height / 2
//        label.textColor = UIColor.white
//        label.textAlignment = NSTextAlignment.center
//
//        let data = marker.userData
//        let i:Int = data as! Int
//
//        label.layer.masksToBounds = true
//        return label
//    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func get_around_coins()
    {
        let url = Common.host + "api/coin/get_near_coins"
        let params = ["lat":String(Common.Coordinate.latitude),
                      "lon":String(Common.Coordinate.longitude),
                      "customer":Common.customerModel.user_id!] as [String : Any]
        print(params)
        self.locationInfo.removeAll()
        do {
            let opt = try HTTP.POST(url, parameters: params)
            
            opt?.run { response in
                if let error = response.error {
                    return
                }
                do {
                    print (response.text!)
                    let decoder: JSONLoader = JSONLoader(response.text!)
                    
                    guard let decoderArray = decoder.getOptionalArray() else {throw JSONError.wrongType}
                    for decoderT in decoderArray {
                        let location = try TippziCoinModel(decoderT)
                        if (location.status == 1) {
                            self.locationInfo.append(location)
                        }
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        self.refreshMapView()
                    })
                } catch {
                }
            }
        } catch let error {
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Common.Coordinate = CLLocationCoordinate2D(latitude: 51.508742, longitude:-0.120850 )
        get_around_coins()
        
        self.locationTracker.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                Common.Coordinate = location.physical.coordinate
                print("dragon")
                print (location.physical.coordinate.latitude)
                print (location.physical.coordinate.longitude)
                self.get_around_coins()
            case .failure: break
                
            }
        }
    }
    
    func refreshMapView() {
        googleMapView.clear()
        googleMapView.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude,
                                              longitude: Common.Coordinate.longitude,
                                              zoom: 19)
        
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = true
        googleMapView.camera = camera
        
        for i in 0 ..< self.locationInfo.count {
            let position = CLLocationCoordinate2D(latitude: Double(self.locationInfo[i].latitude)! , longitude: Double(self.locationInfo[i].longitude)!)
            let marker = GMSMarker(position: position)
            marker.title = ""
            
            marker.userData = i
            marker.map = googleMapView
            
            marker.icon = self.imageWithImage(image: UIImage(named: "img_tippzi_coin.png")!, scaledToSize: CGSize(width: 20, height: 20))
        }
    }
    @IBAction func gotoTippziGoGame(_ sender: Any) {
    }
    @IBAction func gotoMyLocation(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude,
                                              longitude: Common.Coordinate.longitude,
                                              zoom: 19)
        googleMapView.camera = camera
    }
}

