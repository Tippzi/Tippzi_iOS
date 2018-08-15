//
//  ShareDealPopUpViewController.swift
//  Tippzi
//
//  Created by Admin on 12/12/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import Accounts
import Social
import FacebookShare
import Social

class ShareDealPopUpViewController: UIViewController, GPPShareDelegate, GPPSignInDelegate {

    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var shareyourdealtitle: UILabel!
    
    @IBOutlet weak var explainLabel: UILabel!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    @IBOutlet weak var twitterBtn: UIButton!
    
    @IBOutlet weak var googleBtn: UIButton!
    
    var button_width : CGFloat = 0
    var button_height : CGFloat = 0
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //font size set
        if DeviceType.IS_IPAD {
            button_width = 80
            button_height = 80
            facebookBtn.frame = CGRect.init(x: facebookBtn.frame.origin.x, y: facebookBtn.frame.origin.y, width: button_width, height: button_height)
            twitterBtn.frame = CGRect.init(x: twitterBtn.frame.origin.x, y: twitterBtn.frame.origin.y, width: button_width, height: button_height)
            googleBtn.frame = CGRect.init(x: googleBtn.frame.origin.x, y: googleBtn.frame.origin.y, width: button_width, height: button_height)
        } else if DeviceType.IS_IPAD_PRO_9_7 {
            button_width = 80
            button_height = 80
            facebookBtn.frame = CGRect.init(x: facebookBtn.frame.origin.x, y: facebookBtn.frame.origin.y, width: button_width, height: button_height)
            twitterBtn.frame = CGRect.init(x: twitterBtn.frame.origin.x, y: twitterBtn.frame.origin.y, width: button_width, height: button_height)
            googleBtn.frame = CGRect.init(x: googleBtn.frame.origin.x, y: googleBtn.frame.origin.y, width: button_width, height: button_height)
        } else if DeviceType.IS_IPAD_PRO_12_9 {
            button_width = 90
            button_height = 90
            facebookBtn.frame = CGRect.init(x: facebookBtn.frame.origin.x, y: facebookBtn.frame.origin.y, width: button_width, height: button_height)
            twitterBtn.frame = CGRect.init(x: twitterBtn.frame.origin.x, y: twitterBtn.frame.origin.y, width: button_width, height: button_height)
            googleBtn.frame = CGRect.init(x: googleBtn.frame.origin.x, y: googleBtn.frame.origin.y, width: button_width, height: button_height)
        }
 
        
        myView.layer.cornerRadius = 25
        myView.layer.borderColor = UIColor.white.cgColor
        myView.layer.borderWidth = 2
        
        shareyourdealtitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        explainLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        self.image = UIImage(named: "ico_app_logo.png")
        GPPSignIn.sharedInstance().clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com"
        
        
        
//        var signIn = GPPSignIn.sharedInstance();
//        signIn?.shouldFetchGooglePlusUser = true;
//        signIn?.clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com";
//        signIn?.shouldFetchGoogleUserEmail = true;
//        signIn?.shouldFetchGoogleUserID = true;
//        signIn?.scopes = [kGTLAuthScopePlusLogin];
//        signIn?.trySilentAuthentication();
//        signIn?.delegate = self;
        // Do any additional setup after loading the view.
    }
    func share<C: ContentProtocol>(_ content: C) {
        var title: String = ""
        var message: String = ""
        
        do {
            try GraphSharer.share(content) { result in
                switch result {
                case .success(let contentResult):
                    title = "Share Success"
                    message = "Succesfully shared: \(contentResult)"
                case .cancelled:
                    title = "Share Cancelled"
                    message = "Sharing was cancelled by user."
                case .failed(let error):
                    title = "Share Failed"
                    message = "Sharing failed with error \(error)"
                }
//                let alertController = UIAlertController(nibName: title, bundle: message)
//                self.present(alertController, animated: true, completion: nil)
            }
        } catch (let error) {
            title = "Share API Fail"
            message = "Failed to invoke share API with error: \(error)"
//            let alertController = UIAlertController(nibName: title, bundle: message)
//            present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func facebookBtnClick(_ sender: Any) {
////        let url = URL(string:"http://162.13.192.72/Tippzi/ico_app_logo.png")
        let url = URL(string:"https://www.tippzi.com")
        var content = LinkShareContent(url: url!)
        content.quote = Common.select_dealtitle_descrip
        showShareDialog(content, mode: .automatic)
        
//        let permissions : [Any] = ["public_profile", "email", "user_friends", "publish_actions"]
//        let currentAccessToken = FBSDKAccessToken.current()
//
//        let newAccessToken = FBSDKAccessToken(tokenString: currentAccessToken?.tokenString, permissions: permissions as! [AnyObject], declinedPermissions: [], appID: currentAccessToken?.appID, userID: currentAccessToken?.userID, expirationDate: currentAccessToken?.expirationDate, refreshDate: currentAccessToken?.refreshDate)
//
//        FBSDKAccessToken.setCurrent(newAccessToken)sky.dragon1988@hotmail.com
//
//        let photo = Photo(image: self.image!, userGenerated: true)
//        let content = PhotoShareContent(photos: [photo])
//        share(content)
        
        
//        let photo = Photo(image: self.image!, userGenerated: true)
//        let content = PhotoShareContent(photos: [photo])
//        var dlg = FBSDKShareDialog()
//        let con = FBSDKSharingContent(coder: nil)
//
//        dlg.fromViewController = self
//        dlg.shareContent = con
//        dlg.mode = .native
//        if !dlg.canShow() {
//            dlg.mode = .feedBrowser
//        }
//        dlg.show()
        
        
//        let share_image : UIImage = UIImage(named: "ico_app_logo.png")!
//        let share_photo : FBSDKSharePhoto  = FBSDKSharePhoto (image: share_image, userGenerated: true);
//        var content = FBSDKSharePhotoContent()
//        content.photos = [share_photo]
//
//
//        let fbPhotoShareContent = FBSDKSharePhotoContent()
//        let photo = FBSDKSharePhoto(image: self.image!,
//                                    userGenerated: true)
//        fbPhotoShareContent.photos = [photo as Any]
//        fbPhotoShareContent.hashtag = FBSDKHashtag(string: "#MapOSnap")
//
//
////        let fbPhotoShareContent = createFacebookPhotoContent()
//        let shareDialog = FBSDKShareDialog()
//        shareDialog.fromViewController = self
////        shareDialog.delegate = self
//        shareDialog.shareContent = content
//        shareDialog.mode = .automatic
//        shareDialog.show()
        
        
        
        
        
//        showShareDialog(content, mode: .native)
        
//        content.ref = "asdas"
////        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
//
//
//        var dlg = FBSDKShareDialog()
//        dlg.fromViewController = self
//        dlg.shareContent = content
//        dlg.mode = FBSDKShareDialogMode.shareSheet
//        dlg.show()
        
//
//        do {
//            try ShareDialog.show(from: self, content: content)
//        } catch {
//
//        }
//        try ShareDialog.show(from: self, content: content) {
//
//        }
    }
    
    func showShareDialog<C: ContentProtocol>(_ content: C, mode: ShareDialogMode = .automatic) {
        let dialog = ShareDialog(content: content)
        dialog.presentingViewController = self
        dialog.mode = mode
        do {
            try dialog.show()
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
            let transition = CATransition()
            transition.type =  kCATransitionFromBottom
            transition.subtype = kCATransitionFromBottom
            transition.duration = 0.2
            self.view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
        } catch (let error) {
            print("fail")
        }
    }
    
    @IBAction func twitterBtnClick(_ sender: Any) {
        let composer = TWTRComposer()
        composer.setText(Common.select_dealtitle_descrip)
        composer.setImage(self.image)
        composer.show(from: self) { (result) in
            if result == .done {
//                DispatchQueue.main.async {
                    let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
                    let transition = CATransition()
                    transition.type =  kCATransitionFromBottom
                    transition.subtype = kCATransitionFromBottom
                    transition.duration = 0.2
                    self.view.window!.layer.add(transition, forKey: kCATransition)
                    toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                    self.present(toViewController!, animated: true, completion:nil)
//                }
            } else {
                let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
                let transition = CATransition()
                transition.type =  kCATransitionFromBottom
                transition.subtype = kCATransitionFromBottom
                transition.duration = 0.2
                self.view.window!.layer.add(transition, forKey: kCATransition)
                toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                self.present(toViewController!, animated: true, completion:nil)
                print("Cancelled composing")
            }
        }
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        self.view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }

    func finished(withAuth auth: GTMOAuth2Authentication!, error: Error!) {
//        if (error != nil) {
//
//        } else {
//            let shareBuilder = GPPShare.sharedInstance().nativeShareDialog()
//            shareBuilder?.attach(self.image)
//            shareBuilder?.setPrefillText(Common.select_dealtitle_descrip)
//            shareBuilder?.open()
//
//        }
    }
    @IBAction func googleBtnClick(_ sender: Any) {
//        var signIn : GPPSignIn = GPPSignIn.sharedInstance()
//        signIn.shouldFetchGooglePlusUser = true
//        //signIn.shouldFetchGoogleUserEmail = YES  // Uncomment to get the user's email
//
//        // You previously set kClientId in the "Initialize the Google+ client" step
//        signIn.clientID = Common.kClientId
//        signIn.clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com"
//        // Uncomment one of these two statements for the scope you chose in the previous step
//        signIn.scopes = [ kGTLAuthScopePlusLogin ]  // "https://www.googleapis.com/auth/plus.login" scope
//        //signIn.scopes = [ @"profile" ]            // "profile" scope
//
//        // Optional: declare signIn.actions, see "app activities"
//        signIn.delegate = self
//        GPPSignIn.sharedInstance().authenticate()
//
//
//
//        return
        
        
//        let activityItems = [ Common.select_dealtitle_descrip, self.image! ] as [Any]
//        let gppShareActivity = GPPShareActivity()
//        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: [gppShareActivity])
//        self.present(activityViewController, animated: true, completion: nil)
        
        
        
        GPPShare.sharedInstance().delegate = self

        let shareBuilder : GPPShareBuilder  = GPPShare.sharedInstance().shareDialog()
        shareBuilder.setPrefillText(Common.select_dealtitle_descrip)
        shareBuilder.setURLToShare(URL.init(string: "http://tippzi.com/"))
        shareBuilder.open()

        
//        var signIn = GPPSignIn.sharedInstance();
//        signIn?.authenticate();
        
//        var shareDialog = GPPShare.sharedInstance().nativeShareDialog();
//
//        // This line will fill out the title, description, and thumbnail from
//        // the URL that you are sharing and includes a link to that URL.
////        shareDialog.setURLToShare(NSURL(fileURLWithPath: kShareURL));
//shareDialog?.setPrefillText("sdfsdf")
//        shareDialog?.open();
        
        
//        let signIn = GPPSignIn.sharedInstance()
//        signIn?.shouldFetchGooglePlusUser = true
//        signIn?.clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com"
//        signIn?.scopes = [kGTLAuthScopePlusLogin]
//        signIn?.delegate = self
//        signIn?.trySilentAuthentication()
//        signIn?.authenticate()

        

//
//
//        activityViewController.completionWithItemsHandler = { activityViewController, success, items, error in
//            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
//            let transition = CATransition()
//            transition.type =  kCATransitionFromBottom
//            transition.subtype = kCATransitionFromBottom
//            transition.duration = 0.2
//            self.view.window!.layer.add(transition, forKey: kCATransition)
//            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//            self.present(toViewController!, animated: true, completion:nil)
//        }
        
        
//        let data : NSData!
//        let datalent : Int?
//        data = UIImageJPEGRepresentation(self.image!, 0.0001) as NSData!
//        datalent = data.length
//
//        let gppShareActivity = GPPShareActivity()
//        let activityViewController = UIActivityViewController(activityItems: self.activityItems(), applicationActivities: [gppShareActivity])
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
//        activityViewController.completionWithItemsHandler = { activityViewController, success, items, error in
//            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
//            let transition = CATransition()
//            transition.type =  kCATransitionFromBottom
//            transition.subtype = kCATransitionFromBottom
//            transition.duration = 0.2
//            self.view.window!.layer.add(transition, forKey: kCATransition)
//            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//            self.present(toViewController!, animated: true, completion:nil)
//        }
        
    }

    func finishedSharingWithError(_ error: Error!) {
//        GPPShare.sharedInstance().closeActiveNativeShareDialog()
    }
    func finishedSharing(_ shared: Bool) {
//        GPPShare.sharedInstance().closeActiveNativeShareDialog()
    }
    
    func activityItems() -> [AnyObject]
    {
        // set up items to share, in this case some text and an image
        let activityItems = [ Common.select_dealtitle_descrip, self.image! ] as [Any]
        return activityItems as [AnyObject]
    }
    
    @IBAction func gotoTicket(_ sender: Any) {
        
//        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
//        let transition = CATransition()
//        transition.type =  kCATransitionFromBottom
//        transition.subtype = kCATransitionFromBottom
//        transition.duration = 0.2
//        view.window!.layer.add(transition, forKey: kCATransition)
//        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//        self.present(toViewController!, animated: true, completion:nil)
        self.dismiss(animated: true, completion: nil);
    }
    
    
}
