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
    @IBOutlet weak var remainTimeLabel: UILabel!
    
    var remainTime: Int? = 0
    let defaults = UserDefaults.standard
    let locationTracker = LocationTracker(threshold: 10.0)
    var locationInfo = [TippziCoinModel]()
    var timer: Timer?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleMapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude, longitude: Common.Coordinate.longitude, zoom: 15.0)
        self.googleMapView.camera = camera
        
        wallet_countLabel.layer.cornerRadius = wallet_countLabel.frame.width / 2
        wallet_countLabel.layer.masksToBounds = true
        
        let collectedTime: Double? = UserDefaults.standard.value(forKey: "CollectedTime") as? Double
        
        if (collectedTime == nil) {
            self.remainTimeLabel.isHidden = true
        } else {
            self.remainTime = 90 - (Int(Date().timeIntervalSince1970 - collectedTime!))
            if (self.remainTime! <= 0) {
                self.remainTime = 0
                self.remainTimeLabel.isHidden = true
            } else {
                self.remainTimeLabel.text = "Remain Time : \(self.remainTime!)"
                self.remainTimeLabel.isHidden = false
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TippziGoMapViewController.updateTimer)), userInfo: nil, repeats: true)
            }
        }
    }
    
    func updateTimer() {
        self.remainTime! -= 1
        self.remainTimeLabel.text = "Remain Time : \(self.remainTime!)"
        if (self.remainTime! <= 0) {
            self.timer?.invalidate()
            self.timer = nil
            self.remainTime = 0
            self.remainTimeLabel.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    // take care of the close event
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if (self.remainTime! > 0) {
            Toast.toast("You have to wait to gather a coin.")
            return false
        }
        self.get_enable_coin(marker.userData as! Int)
        
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func get_around_coins()
    {
        let url = Common.host + "api/coin/get_near_coins"
        let params = ["lat":String(Common.Coordinate.latitude),
                      "lon":String(Common.Coordinate.longitude),
                      "customer":Common.customerModel.user_id!] as [String : Any]
        self.locationInfo.removeAll()
        do {
            let opt = try HTTP.POST(url, parameters: params)
            
            opt?.run { response in
                if let error = response.error {
                    return
                }
                do {
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
    
    func get_enable_coin(_ id: Int)
    {
        print (id)
        let url = Common.host + "api/coin/get_coin_available"
        let params = ["coin":id] as [String : Any]
        do {
            let opt = try HTTP.POST(url, parameters: params)
            opt?.run { response in
                if let error = response.error {
                    DispatchQueue.main.sync(execute: {
                        Toast.toast("You can't get this coin.")
                    })
                }
                do {
                    print (response.text!)
                    let decoder: JSONLoader = JSONLoader(response.text!)
                    let flag : Bool! = try decoder["result"].get() as Bool
                    if (flag == true) {
                        DispatchQueue.main.sync(execute: {
                            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "LetPlayViewController")
                            self.navigationController?.pushViewController(toViewController!, animated: true)
                        })
                    } else {
                        DispatchQueue.main.sync(execute: {
                            Toast.toast("You can't get this coin.")
                        })
                    }
                } catch {
                    DispatchQueue.main.sync(execute: {
                        Toast.toast("You can't get this coin.")
                    })
                }
            }
        } catch let error {
            DispatchQueue.main.sync(execute: {
                Toast.toast("You can't get this coin.")
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        Common.Coordinate = CLLocationCoordinate2D(latitude: 51.508742, longitude:-0.120850 )
        
        self.get_around_coins()
        self.wallet_countLabel.text = String(Common.customerModel.wallets.count)
        self.locationTracker.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                Common.Coordinate = location.physical.coordinate
                self.get_around_coins()
            case .failure: break

            }
        }
    }
    
    @IBAction func actionGotoWallet(_ sender: Any) {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController")
        self.navigationController?.pushViewController(toViewController!, animated: true)
    }
    func refreshMapView() {
        googleMapView.clear()
        googleMapView.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude,
                                              longitude: Common.Coordinate.longitude,
                                              zoom: 15)
        
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = true
        googleMapView.camera = camera
        
        for i in 0 ..< self.locationInfo.count {
            let position = CLLocationCoordinate2D(latitude: Double(self.locationInfo[i].latitude)! , longitude: Double(self.locationInfo[i].longitude)!)
            let marker = GMSMarker(position: position)
            marker.title = ""
            
            marker.userData = self.locationInfo[i].id
            marker.map = googleMapView
            
            marker.icon = self.imageWithImage(image: UIImage(named: "img_tippzi_coin.png")!, scaledToSize: CGSize(width: 15, height: 15))
        }
    }
    @IBAction func gotoTippziGoGame(_ sender: Any) {
    }
    @IBAction func gotoMyLocation(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: Common.Coordinate.latitude,
                                              longitude: Common.Coordinate.longitude,
                                              zoom: 15)
        googleMapView.camera = camera
    }
}

