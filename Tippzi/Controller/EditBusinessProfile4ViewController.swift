//
//  EditBusinessProfile4ViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class EditBusinessProfile4ViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnBackup: UIButton!
    
    @IBOutlet weak var labBusinessName: UILabel!
    
    @IBOutlet weak var backgroundImage1: UIImageView!
    @IBOutlet weak var backgroundImage2: UIImageView!
    @IBOutlet weak var backgroundImage3: UIImageView!
    @IBOutlet weak var backgroundImage4: UIImageView!
    @IBOutlet weak var backgroundImage5: UIImageView!
    @IBOutlet weak var backgroundImage6: UIImageView!
    
    @IBOutlet weak var selectGallerybtn1: UIButton!
    @IBOutlet weak var selectGallerybtn2: UIButton!
    @IBOutlet weak var selectGallerybtn3: UIButton!
    @IBOutlet weak var selectGallerybtn4: UIButton!
    @IBOutlet weak var selectGallerybtn5: UIButton!
    @IBOutlet weak var selectGallerybtn6: UIButton!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var closeImage1: UIButton!
    @IBOutlet weak var closeImage2: UIButton!
    @IBOutlet weak var closeImage3: UIButton!
    @IBOutlet weak var closeImage4: UIButton!
    @IBOutlet weak var closeImage5: UIButton!
    @IBOutlet weak var closeImage6: UIButton!
    
    var select_gallery1 : String = ""
    var select_gallery2 : String = ""
    var select_gallery3 : String = ""
    var select_gallery4 : String = ""
    var select_gallery5 : String = ""
    var select_gallery6 : String = ""
    
    @IBOutlet weak var edit4HeaderTitleLabel: UILabel!
    @IBOutlet weak var createGalleryLabel: UILabel!
    @IBOutlet weak var editgalleryLabel2: UILabel!
    @IBOutlet weak var edit4galleryLabel1: UIButton!
    
    var imgStr: String = ""
    var select_index : String = ""
    
    let picker = UIImagePickerController()
    
    //Timer format
    var url : String = ""
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var location : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //font size set
        labBusinessName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        edit4HeaderTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        createGalleryLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        editgalleryLabel2.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        edit4galleryLabel1.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        doneBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        //
        labBusinessName.text = Common.editBarModel.business_name
        picker.delegate = self
        doneBtn.layer.cornerRadius = doneBtn.frame.height/2
        doneBtn.layer.borderWidth = 2
        doneBtn.layer.borderColor = UIColor.white.cgColor
        
        activeIndicator.isHidden = true
        edit4galleryLabel1.isEnabled = false
        
        btnBack.isEnabled = true
        btnBackup.isEnabled  = true
        
        backgroundImage1.layer.cornerRadius = 5
        backgroundImage1.layer.borderColor = MyColor.customPinkColor().cgColor
        backgroundImage1.layer.borderWidth = 2
        backgroundImage2.layer.cornerRadius = 5
        backgroundImage2.layer.borderColor = MyColor.customPinkColor().cgColor
        backgroundImage2.layer.borderWidth = 2
        backgroundImage3.layer.cornerRadius = 5
        backgroundImage3.layer.borderColor = MyColor.customPinkColor().cgColor
        backgroundImage3.layer.borderWidth = 2
        backgroundImage4.layer.cornerRadius = 5
        backgroundImage4.layer.borderColor = MyColor.customPinkColor().cgColor
        backgroundImage4.layer.borderWidth = 2
        backgroundImage5.layer.cornerRadius = 5
        backgroundImage5.layer.borderColor = MyColor.customPinkColor().cgColor
        backgroundImage5.layer.borderWidth = 2
        backgroundImage6.layer.cornerRadius = 5
        backgroundImage6.layer.borderColor = MyColor.customPinkColor().cgColor
        backgroundImage6.layer.borderWidth = 2
        
        
        if !((Common.editBarModel.galleryModel?.background1.isEmpty)!) {
            
            var imgurl1 = Common.download + (Common.editBarModel.galleryModel?.background1)!
            let url = URL(string: imgurl1)
            backgroundImage1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            backgroundImage1.contentMode = .scaleAspectFill
            backgroundImage1.layer.masksToBounds = false
            backgroundImage1.clipsToBounds = true
            backgroundImage1.layer.borderWidth = 2
            backgroundImage1.layer.borderColor = UIColor.white.cgColor
            
        }
        
        if !((Common.editBarModel.galleryModel?.background2.isEmpty)!) {
            
            var imgurl2 = Common.download + (Common.editBarModel.galleryModel?.background2)!
            let url = URL(string: imgurl2)
            backgroundImage2.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            backgroundImage2.contentMode = .scaleAspectFill
            backgroundImage2.layer.masksToBounds = false
            backgroundImage2.clipsToBounds = true
            backgroundImage2.layer.borderWidth = 2
            backgroundImage2.layer.borderColor = UIColor.white.cgColor
            
        }
        
        if !((Common.editBarModel.galleryModel?.background3.isEmpty)!) {
            
            var imgurl3 = Common.download + (Common.editBarModel.galleryModel?.background3)!
            let url = URL(string: imgurl3)
            backgroundImage3.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            backgroundImage3.contentMode = .scaleAspectFill
            backgroundImage3.layer.masksToBounds = false
            backgroundImage3.clipsToBounds = true
            backgroundImage3.layer.borderWidth = 2
            backgroundImage3.layer.borderColor = UIColor.white.cgColor
            
        }
        
        if !((Common.editBarModel.galleryModel?.background4.isEmpty)!) {
            
            var imgurl4 = Common.download + (Common.editBarModel.galleryModel?.background4)!
            let url = URL(string: imgurl4)
            backgroundImage4.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            backgroundImage4.contentMode = .scaleAspectFill
            backgroundImage4.layer.masksToBounds = false
            backgroundImage4.clipsToBounds = true
            backgroundImage4.layer.borderWidth = 2
            backgroundImage4.layer.borderColor = UIColor.white.cgColor
            
        }
        
        if !((Common.editBarModel.galleryModel?.background5.isEmpty)!) {
            
            var imgurl5 = Common.download + (Common.editBarModel.galleryModel?.background5)!
            let url = URL(string: imgurl5)
            backgroundImage5.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            backgroundImage5.contentMode = .scaleAspectFill
            backgroundImage5.layer.masksToBounds = false
            backgroundImage5.clipsToBounds = true
            backgroundImage5.layer.borderWidth = 2
            backgroundImage5.layer.borderColor = UIColor.white.cgColor
            
        }
        
        if !((Common.editBarModel.galleryModel?.background6.isEmpty)!) {
            
            var imgurl6 = Common.download + (Common.editBarModel.galleryModel?.background6)!
            let url = URL(string: imgurl6)
            backgroundImage6.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            backgroundImage6.contentMode = .scaleAspectFill
            backgroundImage6.layer.masksToBounds = false
            backgroundImage6.clipsToBounds = true
            backgroundImage6.layer.borderWidth = 2
            backgroundImage6.layer.borderColor = UIColor.white.cgColor
            
        }
        
        
        closeImage1.isHidden = true
        closeImage1.layer.cornerRadius = 5
        closeImage1.isEnabled = false
        closeImage2.isHidden = true
        closeImage2.layer.cornerRadius = 5
        closeImage2.isEnabled = false
        closeImage3.isHidden = true
        closeImage3.layer.cornerRadius = 5
        closeImage3.isEnabled = false
        closeImage4.isHidden = true
        closeImage4.layer.cornerRadius = 5
        closeImage4.isEnabled = false
        closeImage5.isHidden = true
        closeImage5.layer.cornerRadius = 5
        closeImage5.isEnabled = false
        closeImage6.isHidden = true
        closeImage6.layer.cornerRadius = 5
        closeImage6.isEnabled = false
        
        //Long function will call when user long press on button.
        let longGesture1 = UILongPressGestureRecognizer(target: self, action: #selector(EditBusinessProfile4ViewController.Long1))
        let longGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(EditBusinessProfile4ViewController.Long2))
        let longGesture3 = UILongPressGestureRecognizer(target: self, action: #selector(EditBusinessProfile4ViewController.Long3))
        let longGesture4 = UILongPressGestureRecognizer(target: self, action: #selector(EditBusinessProfile4ViewController.Long4))
        let longGesture5 = UILongPressGestureRecognizer(target: self, action: #selector(EditBusinessProfile4ViewController.Long5))
        let longGesture6 = UILongPressGestureRecognizer(target: self, action: #selector(EditBusinessProfile4ViewController.Long6))
        
        selectGallerybtn1.addGestureRecognizer(longGesture1)
        selectGallerybtn2.addGestureRecognizer(longGesture2)
        selectGallerybtn3.addGestureRecognizer(longGesture3)
        selectGallerybtn4.addGestureRecognizer(longGesture4)
        selectGallerybtn5.addGestureRecognizer(longGesture5)
        selectGallerybtn6.addGestureRecognizer(longGesture6)
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    @objc func Long1() {
        
        closeImage1.layer.cornerRadius = 10
        closeImage1.isHidden = false
        closeImage1.isEnabled = true
        
    }
    @objc func Long2() {
        
        closeImage2.isHidden = false
        closeImage2.isEnabled = true
        
    }
    
    @objc func Long3() {
        
        closeImage3.isHidden = false
        closeImage3.isEnabled = true
        
    }
    
    @objc func Long4() {
        
        closeImage4.isHidden = false
        closeImage4.isEnabled = true
        
    }
    
    @objc func Long5() {
        
        closeImage5.isHidden = false
        closeImage5.isEnabled = true
        
    }
    
    @objc func Long6() {
        
        closeImage6.isHidden = false
        closeImage6.isEnabled = true
        
    }
    
    
    @IBAction func closeImg1Click(_ sender: Any) {
        select_gallery1 = "close"
        Common.editBarModel.galleryModel?.background1 = "close";
        closeImage1.isHidden = true
        closeImage1.isEnabled = false
        backgroundImage1.image = UIImage(named: "ico_camera.png")
        backgroundImage1.layer.borderColor = MyColor.customPinkColor().cgColor
    }
    @IBAction func closeImg2Click(_ sender: Any) {
        select_gallery2 = "close"
        Common.editBarModel.galleryModel?.background2 = "close";
        closeImage2.isHidden = true
        closeImage2.isEnabled = false
        backgroundImage2.image = UIImage(named: "ico_camera.png")
        backgroundImage2.layer.borderColor = MyColor.customPinkColor().cgColor
    }
    
    @IBAction func closeImg3Click(_ sender: Any) {
        select_gallery3 = "close"
        Common.editBarModel.galleryModel?.background3 = "close";
        closeImage3.isHidden = true
        closeImage3.isEnabled = false
        backgroundImage3.image = UIImage(named: "ico_camera.png")
        backgroundImage3.layer.borderColor = MyColor.customPinkColor().cgColor
    }
    
    @IBAction func closeImg4Click(_ sender: Any) {
        select_gallery4 = "close"
        Common.editBarModel.galleryModel?.background4 = "close";
        closeImage4.isHidden = true
        closeImage4.isEnabled = false
        backgroundImage4.image = UIImage(named: "ico_camera.png")
        backgroundImage4.layer.borderColor = MyColor.customPinkColor().cgColor
    }
    @IBAction func closeImg5Click(_ sender: Any) {
        select_gallery5 = "close"
        Common.editBarModel.galleryModel?.background5 = "close";
        closeImage5.isHidden = true
        closeImage5.isEnabled = false
        backgroundImage5.image = UIImage(named: "ico_camera.png")
        backgroundImage5.layer.borderColor = MyColor.customPinkColor().cgColor
    }
    @IBAction func closeImg6Click(_ sender: Any) {
        select_gallery6 = "close"
        Common.editBarModel.galleryModel?.background6 = "close";
        closeImage6.isHidden = true
        closeImage6.isEnabled = false
        backgroundImage6.image = UIImage(named: "ico_camera.png")
        backgroundImage6.layer.borderColor = MyColor.customPinkColor().cgColor
    }
    //back
    @IBAction func BackAction(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile3")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    func finishedResponse1() {
        
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
    
    @IBAction func goto_dashboardAction(_ sender: Any) {
        Common.category = ""
        Common.selectAddress = ""
        self.finishedResponse1()
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
//        self.activeIndicator.isHidden = false
//        self.activeIndicator.startAnimating()
        
    }
    
    @IBAction func SelectGallery1(_ sender: Any) {
        
        select_index = "1"
        let myActionSheet = UIAlertController(title:"Select Image", message:"", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style:UIAlertActionStyle.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.delegate = self
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }
        
        let photolibraryAction = UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default) { (action) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel) { (action) in
            
        }
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(photolibraryAction)
        myActionSheet.addAction(cancelAction)
        
        myActionSheet.popoverPresentationController?.sourceView = self.selectGallerybtn1
        myActionSheet.popoverPresentationController?.sourceRect = self.selectGallerybtn1.bounds
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func SelectGallery2(_ sender: Any) {
        select_index = "2"
        let myActionSheet = UIAlertController(title:"Select Image", message:"", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style:UIAlertActionStyle.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.delegate = self
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }
        
        let photolibraryAction = UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default) { (action) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel) { (action) in
            
        }
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(photolibraryAction)
        myActionSheet.addAction(cancelAction)
        
        myActionSheet.popoverPresentationController?.sourceView = self.selectGallerybtn2
        myActionSheet.popoverPresentationController?.sourceRect = self.selectGallerybtn2.bounds
        self.present(myActionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func SelectGallery3(_ sender: Any) {
        select_index = "3"
        let myActionSheet = UIAlertController(title:"Select Image", message:"", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style:UIAlertActionStyle.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.delegate = self
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }
        
        let photolibraryAction = UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default) { (action) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel) { (action) in
            
        }
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(photolibraryAction)
        myActionSheet.addAction(cancelAction)
        
        myActionSheet.popoverPresentationController?.sourceView = self.selectGallerybtn3
        myActionSheet.popoverPresentationController?.sourceRect = self.selectGallerybtn3.bounds
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func SelectGallery4(_ sender: Any) {
        select_index = "4"
        let myActionSheet = UIAlertController(title:"Select Image", message:"", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style:UIAlertActionStyle.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.delegate = self
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }
        
        let photolibraryAction = UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default) { (action) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel) { (action) in
            
        }
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(photolibraryAction)
        myActionSheet.addAction(cancelAction)
        
        myActionSheet.popoverPresentationController?.sourceView = self.selectGallerybtn4
        myActionSheet.popoverPresentationController?.sourceRect = self.selectGallerybtn4.bounds
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func SelectGallery5(_ sender: Any) {
        select_index = "5"
        let myActionSheet = UIAlertController(title:"Select Image", message:"", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style:UIAlertActionStyle.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.delegate = self
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }
        
        let photolibraryAction = UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default) { (action) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel) { (action) in
            
        }
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(photolibraryAction)
        myActionSheet.addAction(cancelAction)
        
        myActionSheet.popoverPresentationController?.sourceView = self.selectGallerybtn5
        myActionSheet.popoverPresentationController?.sourceRect = self.selectGallerybtn5.bounds
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func SelectGallery6(_ sender: Any) {
        select_index = "6"
        let myActionSheet = UIAlertController(title:"Select Image", message:"", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style:UIAlertActionStyle.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.delegate = self
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }
        
        let photolibraryAction = UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default) { (action) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel) { (action) in
            
        }
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(photolibraryAction)
        myActionSheet.addAction(cancelAction)
        
        myActionSheet.popoverPresentationController?.sourceView = self.selectGallerybtn6
        myActionSheet.popoverPresentationController?.sourceRect = self.selectGallerybtn6.bounds
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        if select_index == "1" {
            select_gallery1 = "galler1"
            backgroundImage1.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage1.contentMode = .scaleAspectFill //3
            backgroundImage1.image = chosenImage //4
            backgroundImage1.layer.masksToBounds = false
            backgroundImage1.clipsToBounds = true
            backgroundImage1.layer.borderWidth = 2
            backgroundImage1.layer.borderColor = UIColor.white.cgColor
            dismiss(animated:true, completion: nil) //5
            
            if let imageData = UIImageJPEGRepresentation(chosenImage, 0.001) {
                Common.editBarModel.galleryModel?.background1 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "2" {
            select_gallery2 = "galler2"
            backgroundImage2.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage2.contentMode = .scaleAspectFill //3
            backgroundImage2.image = chosenImage //4
            backgroundImage2.layer.masksToBounds = false
            backgroundImage2.clipsToBounds = true
            backgroundImage2.layer.borderWidth = 2
            backgroundImage2.layer.borderColor = UIColor.white.cgColor
            dismiss(animated:true, completion: nil) //5
            
            if let imageData = UIImageJPEGRepresentation(chosenImage, 0.001) {
                Common.editBarModel.galleryModel?.background2 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "3" {
            select_gallery3 = "galler3"
            backgroundImage3.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage3.contentMode = .scaleAspectFill //3
            backgroundImage3.image = chosenImage //4
            backgroundImage3.layer.masksToBounds = false
            backgroundImage3.clipsToBounds = true
            backgroundImage3.layer.borderWidth = 2
            backgroundImage3.layer.borderColor = UIColor.white.cgColor
            dismiss(animated:true, completion: nil) //5
            
            if let imageData = UIImageJPEGRepresentation(chosenImage, 0.001) {
                Common.editBarModel.galleryModel?.background3 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "4" {
            select_gallery4 = "galler4"
            backgroundImage4.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage4.contentMode = .scaleAspectFill //3
            backgroundImage4.image = chosenImage //4
            backgroundImage4.layer.masksToBounds = false
            backgroundImage4.clipsToBounds = true
            backgroundImage4.layer.borderWidth = 2
            backgroundImage4.layer.borderColor = UIColor.white.cgColor
            dismiss(animated:true, completion: nil) //5
            
            if let imageData = UIImageJPEGRepresentation(chosenImage, 0.001) {
                Common.editBarModel.galleryModel?.background4 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "5" {
            select_gallery5 = "galler5"
            backgroundImage5.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage5.contentMode = .scaleAspectFill //3
            backgroundImage5.image = chosenImage //4
            backgroundImage5.layer.masksToBounds = false
            backgroundImage5.clipsToBounds = true
            backgroundImage5.layer.borderWidth = 2
            backgroundImage5.layer.borderColor = UIColor.white.cgColor
            dismiss(animated:true, completion: nil) //5
            
            if let imageData = UIImageJPEGRepresentation(chosenImage, 0.001) {
                Common.editBarModel.galleryModel?.background5 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "6" {
            select_gallery6 = "galler6"
            backgroundImage6.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage6.contentMode = .scaleAspectFill //3
            backgroundImage6.image = chosenImage //4
            backgroundImage6.layer.masksToBounds = false
            backgroundImage6.clipsToBounds = true
            backgroundImage6.layer.borderWidth = 2
            backgroundImage6.layer.borderColor = UIColor.white.cgColor
            dismiss(animated:true, completion: nil) //5
            
            if let imageData = UIImageJPEGRepresentation(chosenImage, 0.001) {
                Common.editBarModel.galleryModel?.background6 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        }
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
        if select_index == "1" {
            select_gallery1 = "galler1"
            backgroundImage1.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage1.contentMode = .scaleAspectFill //3
            backgroundImage1.image = image //4
            backgroundImage1.layer.masksToBounds = false
            backgroundImage1.clipsToBounds = true
            backgroundImage1.layer.borderWidth = 2
            backgroundImage1.layer.borderColor = UIColor.white.cgColor
            self.dismiss(animated: true, completion: nil);
            if let imageData = UIImageJPEGRepresentation(image, 0.001) {
                Common.editBarModel.galleryModel?.background1 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                imgStr = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "2" {
            select_gallery2 = "galler2"
            backgroundImage2.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage2.contentMode = .scaleAspectFill //3
            backgroundImage2.image = image //4
            backgroundImage2.layer.masksToBounds = false
            backgroundImage2.clipsToBounds = true
            backgroundImage2.layer.borderWidth = 2
            backgroundImage2.layer.borderColor = UIColor.white.cgColor
            self.dismiss(animated: true, completion: nil);
            if let imageData = UIImageJPEGRepresentation(image, 0.001) {
                Common.editBarModel.galleryModel?.background2 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "3" {
            select_gallery3 = "galler3"
            backgroundImage3.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage3.contentMode = .scaleAspectFill //3
            backgroundImage3.image = image //4
            backgroundImage3.layer.masksToBounds = false
            backgroundImage3.clipsToBounds = true
            backgroundImage3.layer.borderWidth = 2
            backgroundImage3.layer.borderColor = UIColor.white.cgColor
            if let imageData = UIImageJPEGRepresentation(image, 0.001) {
                imgStr = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                Common.editBarModel.galleryModel?.background3 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                
            }
        } else if select_index == "4" {
            select_gallery4 = "galler4"
            backgroundImage4.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage4.contentMode = .scaleAspectFill //3
            backgroundImage4.image = image //4
            backgroundImage4.layer.masksToBounds = false
            backgroundImage4.clipsToBounds = true
            backgroundImage4.layer.borderWidth = 2
            backgroundImage4.layer.borderColor = UIColor.white.cgColor
            self.dismiss(animated: true, completion: nil);
            if let imageData = UIImageJPEGRepresentation(image, 0.001) {
                Common.editBarModel.galleryModel?.background4 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "5" {
            select_gallery5 = "galler5"
            backgroundImage5.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage5.contentMode = .scaleAspectFill //3
            backgroundImage5.image = image //4
            backgroundImage5.layer.masksToBounds = false
            backgroundImage5.clipsToBounds = true
            backgroundImage5.layer.borderWidth = 2
            backgroundImage5.layer.borderColor = UIColor.white.cgColor
            self.dismiss(animated: true, completion: nil);
            if let imageData = UIImageJPEGRepresentation(image, 0.001) {
                Common.editBarModel.galleryModel?.background5 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        } else if select_index == "6" {
            select_gallery6 = "galler6"
            backgroundImage6.layer.borderColor = UIColor.blue.cgColor;
            backgroundImage6.contentMode = .scaleAspectFill //3
            backgroundImage6.image = image //4
            backgroundImage6.layer.masksToBounds = false
            backgroundImage6.clipsToBounds = true
            backgroundImage6.layer.borderWidth = 2
            backgroundImage6.layer.borderColor = UIColor.white.cgColor
            self.dismiss(animated: true, completion: nil);
            if let imageData = UIImageJPEGRepresentation(image, 0.001) {
                Common.editBarModel.galleryModel?.background6 = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        Common.editBarModel = EditBarModel()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    func getCoordinate( _ addressString : String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error != nil {// Address is incorrect
                print(addressString)
                MessageBoxViewController.showAlert(self, title: "Alert", message: "Your address is invalid \n Please check address again")
                self.activeIndicator.stopAnimating()
                self.activeIndicator.isHidden = true
                self.view.isUserInteractionEnabled = true
                
                self.timer.invalidate()
                
                self.btnBack.isEnabled = true
                self.btnBackup.isEnabled  = true
                self.doneBtn.isEnabled = true
                
                //transition effect
                let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile4")
                
                let transition = CATransition()
                transition.type = kCATransitionFromBottom
                transition.subtype = kCATransitionFromBottom
                transition.duration = 0.2
                self.view.window!.layer.add(transition, forKey: kCATransition)
                toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                self.present(toViewController!, animated: true, completion:nil)
            }
            else {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    let location1 : CLLocationCoordinate2D = location.coordinate
                    self.input_business_data(location1)
                    return
                }
            }
        }
    }
    
    @IBAction func EditProfileSendToSever(_ sender: Any) {
        
        btnBack.isEnabled = false
        btnBackup.isEnabled  = false
        doneBtn.isEnabled = false
        
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        getCoordinate( Common.editBarModel.address)
    }
    
    func input_business_data(_ getlocation : CLLocationCoordinate2D) {
       
        let bar_id = Common.editBarModel.bar_id
        let address = Common.editBarModel.address
        //        let address = "1 Infinite Loop, CA, USA"
        let business_name = Common.editBarModel.business_name
        let category_name = Common.editBarModel.category_name
        let description = Common.editBarModel.description
        let email = Common.editBarModel.email
        let music_type = Common.editBarModel.music_type
        let post_code = Common.editBarModel.post_code
        let website = Common.editBarModel.website
        let telephone = Common.editBarModel.telephone
        
        self.defaults.set(Common.editBarModel.textview_lines, forKey: "textview_lines")
        
        var open_time : Dictionary = [String : String]()
        open_time["mon_start"] = Common.editBarModel.editopenHour?.mon_start
        open_time["mon_end"] = Common.editBarModel.editopenHour?.mon_end
        open_time["tue_start"] = Common.editBarModel.editopenHour?.tue_start
        open_time["tue_end"] = Common.editBarModel.editopenHour?.tue_end
        open_time["wed_start"] = Common.editBarModel.editopenHour?.wed_start
        open_time["wed_end"] = Common.editBarModel.editopenHour?.wed_end
        open_time["thur_start"] = Common.editBarModel.editopenHour?.thur_start
        open_time["thur_end"] = Common.editBarModel.editopenHour?.thur_end
        open_time["fri_start"] = Common.editBarModel.editopenHour?.fri_start
        open_time["fri_end"] = Common.editBarModel.editopenHour?.fri_end
        open_time["sat_start"] = Common.editBarModel.editopenHour?.sat_start
        open_time["sat_end"] = Common.editBarModel.editopenHour?.sat_end
        open_time["sun_start"] = Common.editBarModel.editopenHour?.sun_start
        open_time["sun_end"] = Common.editBarModel.editopenHour?.sun_end
        
        
        if select_gallery1 == "" {
            Common.editBarModel.galleryModel?.background1 = ""
        }
        if select_gallery2 == "" {
            Common.editBarModel.galleryModel?.background2 = ""
        }
        if select_gallery3 == "" {
            Common.editBarModel.galleryModel?.background3 = ""
        }
        if select_gallery4 == "" {
            Common.editBarModel.galleryModel?.background4 = ""
        }
        if select_gallery5 == "" {
            Common.editBarModel.galleryModel?.background5 = ""
        }
        if select_gallery6 == "" {
            Common.editBarModel.galleryModel?.background6 = ""
        }
        var gallery : Dictionary = ["background1" : Common.editBarModel.galleryModel?.background1,
                                    "background2" : Common.editBarModel.galleryModel?.background2,
                                    "background3" : Common.editBarModel.galleryModel?.background3,
                                    "background4" : Common.editBarModel.galleryModel?.background4,
                                    "background5" : Common.editBarModel.galleryModel?.background5,
                                    "background6" : Common.editBarModel.galleryModel?.background6]
        
        
        
        //up to server
        let url = Common.api_location + "edit_business_profile.php"
        
        let params = ["bar_id": bar_id,
                      "address": address,
                      "lat": String(getlocation.latitude),
                      "lon": String(getlocation.longitude),
                      "business_name": business_name,
                      "category": category_name,
                      "description": description,
                      "email": email,
                      "music_type": music_type,
                      "post_code": post_code,
                      "website": website,
                      "telephone": telephone,
                      "galleryModel": gallery,
                      "open_time" : open_time] as [String : Any]
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        do {
            let opt = try HTTP.POST(url, parameters: params)
            self.view.isUserInteractionEnabled = false
            
            
            //get from server
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.view.isUserInteractionEnabled = true
                        
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        // stop timer
                        self.activeIndicator.stopAnimating()
                        self.activeIndicator.isHidden = true
                        self.timer.invalidate()
                        
                        self.btnBack.isEnabled = true
                        self.btnBackup.isEnabled  = true
                        self.doneBtn.isEnabled = true
                        
                        return
                    })
                    
                }
                do {
                    
                    Common.businessModel = try BusinessModel(JSONLoader(response.text!))
                    if Common.businessModel.success == "true" {
                        self.flag = true
                        
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            self.btnBack.isEnabled = true
                            self.btnBackup.isEnabled  = true
                            self.doneBtn.isEnabled = true
                            
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
}
public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    public func base64(_ format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(self)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString()
    }
}
