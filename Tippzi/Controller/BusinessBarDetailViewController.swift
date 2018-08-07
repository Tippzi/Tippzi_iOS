//
//  BusinessBarDetailViewController.swift
//  Tippzi
//
//  Created by Admin on 11/26/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Koloda
import ImageSlideshow
import SDWebImage

class BusinessBarDetailViewController: UIViewController, KolodaViewDelegate,  KolodaViewDataSource {
    
    @IBOutlet weak var imageslideshow: ImageSlideshow!
    @IBOutlet weak var barTitleLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var detailmodeals = [BarDetailModel]()
    var index_count : Int = 0
    var downloadImage : [AlamofireSource] = [AlamofireSource]()
    
    var weekday: Int = 0
    var opentime : String = ""
    
    var height : [CGFloat]?
    var add_all_Height : CGFloat = 0
    
    var myView_ypos : CGFloat = 0.0
    var imageslideshow_ypos : CGFloat = 0.0
    var kolodaView_ypos : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeIndicator.isHidden = true
        
        //font size set
        barTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        pageLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        //
        if Common.businessModel.bars[0].deal.count > 0 {
            for i in 0...Common.businessModel.bars[0].deal.count-1 {
                var remain_value = "Hurry, only " + String(Int(Common.businessModel.bars[0].deal[i].qty!)! - Int(Common.businessModel.bars[0].deal[i].claimed!)!) + " left"
                var exp_duration = "Exp " + Common.businessModel.bars[0].deal[i].duration!
                var title = Common.businessModel.bars[0].deal[i].title
                var deal_description = Common.businessModel.bars[0].deal[i].description
                detailmodeals += [BarDetailModel(title!, deal_description!, exp_duration,remain_value,i)]
            }
            
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date = formatter.string(from: date)
        
        // get current day of week
        weekday = getDayOfWeek(today: current_date)
        
        display_opentime(index_count)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        
        
        barTitleLabel.text = Common.businessModel.bars[0].business_name
        pageLabel.text = String(index_count + 1) + " of " + String(Common.businessModel.bars[0].deal.count) + " deals"
        index_count = 1
        
        height = [CGFloat]()
        let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        
        if !(Common.businessModel.bars[0].background1?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.businessModel.bars[0].background1!))!)
            height?.append(CGFloat(Float(Common.businessModel.bars[0].background1_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.businessModel.bars[0].background2?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.businessModel.bars[0].background2!))!)
            height?.append(CGFloat(Float(Common.businessModel.bars[0].background2_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.businessModel.bars[0].background3?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.businessModel.bars[0].background3!))!)
            height?.append(CGFloat(Float(Common.businessModel.bars[0].background3_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.businessModel.bars[0].background4?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.businessModel.bars[0].background4!))!)
            height?.append(CGFloat(Float(Common.businessModel.bars[0].background4_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.businessModel.bars[0].background5?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.businessModel.bars[0].background5!))!)
            height?.append(CGFloat(Float(Common.businessModel.bars[0].background5_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.businessModel.bars[0].background6?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.businessModel.bars[0].background6!))!)
            height?.append(CGFloat(Float(Common.businessModel.bars[0].background6_height!)!)*SCREEN_WIDTH)
        }
        
        myView_ypos = -20
        imageslideshow_ypos = myView_ypos + myView.frame.height
        
        if downloadImage.count == 0 {
            
            myView.frame = CGRect.init(x: 0, y: myView_ypos + 20, width: myView.frame.width, height: myView.frame.height)
            add_all_Height += myView.frame.height
            
            imageslideshow.isHidden = true
            imageslideshow.frame = CGRect.init(x: 0, y: imageslideshow_ypos , width: imageslideshow.frame.width, height: 0)
            
            kolodaView_ypos = kolodaView.frame.origin.y + 20
            kolodaView.frame = CGRect.init(x: kolodaView.frame.origin.x, y: kolodaView_ypos , width: kolodaView.frame.width, height: kolodaView.frame.height)
            
            self.scrollView.addSubview(self.myView)
            self.scrollView.addSubview(self.imageslideshow)
            self.scrollView.addSubview(self.kolodaView)
            
            scrollView.contentSize.height = add_all_Height
            
            let testView = UIView(frame : CGRect.init(x:0, y: SCREEN_HEIGHT, width:self.myView.frame.width, height:300))
            testView.backgroundColor = MyColor.CusBarDetailBackground()
            self.myView.addSubview(testView)
            
        }
        else if downloadImage.count == 1 {
            
            imageslideshow.backgroundColor = MyColor.customCircleFillColor()
            imageslideshow.slideshowInterval = 5.0
            imageslideshow.pageControl.isHidden = true
            imageslideshow.contentScaleMode = UIViewContentMode.scaleToFill
            
            self.myView.frame = CGRect.init(x: 0, y: self.myView_ypos , width: self.myView.frame.width, height: self.myView.frame.height)
            self.add_all_Height += self.myView.frame.height
            
            imageslideshow.activityIndicator = DefaultActivityIndicator()
            self.imageslideshow.frame = CGRect.init(x: 0, y: self.imageslideshow_ypos , width: self.imageslideshow.frame.width, height: self.height![0])
            self.add_all_Height += self.height![0]
            
            self.imageslideshow.setImageInputs(downloadImage)
            
            self.scrollView.addSubview(self.myView)
            self.scrollView.addSubview(self.imageslideshow)
            self.scrollView.addSubview(self.kolodaView)
            
            self.scrollView.contentSize.height = self.add_all_Height - 20
            
            let testView = UIView(frame : CGRect.init(x:0, y: SCREEN_HEIGHT, width:self.myView.frame.width, height:300))
            testView.backgroundColor = MyColor.CusBarDetailBackground()
            self.myView.addSubview(testView)
            
            self.add_all_Height = 0
                
        }
        else
        {
            self.imageslideshow.backgroundColor = MyColor.customCircleFillColor()
            self.imageslideshow.slideshowInterval = 5.0
            self.imageslideshow.pageControl.isHidden = true
            self.imageslideshow.contentScaleMode = UIViewContentMode.scaleToFill
            
            self.imageslideshow.activityIndicator = DefaultActivityIndicator()
            self.imageslideshow.currentPageChanged = { page in
                
                self.myView.frame = CGRect.init(x: 0, y: self.myView_ypos , width: self.myView.frame.width, height: self.myView.frame.height)
                self.add_all_Height += self.myView.frame.height
                
                self.imageslideshow.frame = CGRect.init(x: 0, y: self.imageslideshow_ypos , width: self.imageslideshow.frame.width, height: self.height![page])
                self.add_all_Height += self.height![page]
                
                self.scrollView.addSubview(self.myView)
                self.scrollView.addSubview(self.imageslideshow)
                self.scrollView.addSubview(self.kolodaView)
                
                self.scrollView.contentSize.height = self.add_all_Height - 20
                
                let testView = UIView(frame : CGRect.init(x:0, y: SCREEN_HEIGHT, width:self.myView.frame.width, height:300))
                testView.backgroundColor = MyColor.CusBarDetailBackground()
                self.myView.addSubview(testView)
               
                self.add_all_Height = 0
                
            }
            
            self.imageslideshow.setImageInputs(self.downloadImage)
         }
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    func display_opentime(_ index_num : Int){
        let barModel = Common.businessModel.bars[0]
        let dealModel = Common.businessModel.bars[0].deal[index_num]
        
        if weekday == 2 {
            
            opentime = (barModel.openHour?.mon_start)! + " - " + (barModel.openHour?.mon_end)!
        }
        else if weekday == 3 {
            
            opentime = (barModel.openHour?.tue_start)! + " - " + (barModel.openHour?.tue_end)!
        }
        else if weekday == 4 {
            
            opentime = (barModel.openHour?.wed_start)! + " - " + (barModel.openHour?.wed_end)!
        }
        else if weekday == 5 {
            
            opentime = (barModel.openHour?.thur_start)! + " - " + (barModel.openHour?.thur_end)!
        }
        else if weekday == 6 {
            
            opentime = (barModel.openHour?.fri_start)! + " - " + (barModel.openHour?.fri_end)!
        }
        else if weekday == 7 {
            
            opentime = (barModel.openHour?.sat_start)! + " - " + (barModel.openHour?.sat_end)!
        }
        else if weekday == 1 {
            
            opentime = (barModel.openHour?.sun_start)! + " - " + (barModel.openHour?.sun_end)!
        }
        
        if opentime == " - " {
            
            timeLabel.text = "Closed"
        }
        else{
            
            timeLabel.text = opentime
        }
        
        //        timewalkBtn.setTitle(cal_walk_time(distance: barModel.distance!) + " mins walk", for: .normal)
    }
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
        
    }
    
    @IBAction func ExistDealCardAction(_ sender: Any) {
        
        if index_count < detailmodeals.count {
            kolodaView?.swipe(.right)
        } else {
            kolodaView?.swipe(.right)
        }
    }
    
    @IBAction func RevertCardAction(_ sender: Any) {
        
        if index_count > 0 {
            index_count = index_count - 1
            if index_count == 0 {
                index_count = 1
            }
            pageLabel.text = String(index_count) + " of " + String(Common.businessModel.bars[0].deal.count) + " deals"
            kolodaView?.revertAction()
        }
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = koloda.currentCardIndex
        
        if Common.businessModel.bars[0].deal.count > 0 {
            for i in 0...Common.businessModel.bars[0].deal.count-1 {
                var remain_value = "Hurry, only " + String(Int(Common.businessModel.bars[0].deal[i].qty!)! - Int(Common.businessModel.bars[0].deal[i].claimed!)!) + " left"
                var exp_duration = "Exp " + Common.businessModel.bars[0].deal[i].duration!
                var title = Common.businessModel.bars[0].deal[i].title
                var deal_description = Common.businessModel.bars[0].deal[i].description
                detailmodeals += [BarDetailModel(title!, deal_description!, exp_duration,remain_value,i)]
            }
            koloda.insertCardAtIndexRange(position..<position + detailmodeals.count, animated: true)
        }
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return detailmodeals.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda : KolodaView, shouldSwipeCardAt index: Int, in direction : SwipeResultDirection)->Bool {
        var get_index = koloda.currentCardIndex
        index_count = get_index + 1
        if index_count < detailmodeals.count  {
            pageLabel.text = String(index_count + 1) + " of " + String(Common.businessModel.bars[0].deal.count) + " deals"
            index_count += 1
            return true
        } else {
            koloda.resetCurrentCardIndex()
            koloda.reloadData()
            var get_index = koloda.currentCardIndex
            index_count = get_index + 1
            pageLabel.text = String(index_count) + " of " + String(Common.businessModel.bars[0].deal.count) + " deals"
            return false
        }
        
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        var index = koloda.currentCardIndex
        
        return true
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let infoWindow = DetailInfoWindow.instanceFromNib() as! DetailInfoWindow
        
        infoWindow.layer.cornerRadius = 8
        infoWindow.layer.masksToBounds = true
        
        infoWindow.deal_title.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        infoWindow.deal_description.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].deal_name_size))
        infoWindow.remainLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        infoWindow.durationLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        infoWindow.deal_title.text = detailmodeals[index].deal_name
        infoWindow.deal_description.text = detailmodeals[index].deal_description
        infoWindow.remainLabel.text = detailmodeals[index].remain
        infoWindow.durationLabel.text = detailmodeals[index].duration
        
        return infoWindow
    }
    
    @objc func finishedResponse() {
        
        self.view.isUserInteractionEnabled = true
        
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessMapView")
        if toViewController != nil {
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            timer.invalidate()
            self.activeIndicator.isHidden = true
            self.activeIndicator.stopAnimating()
            self.present(toViewController!, animated: false, completion:nil)
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        
    }
    
}

