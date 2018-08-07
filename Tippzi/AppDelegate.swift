//
//  AppDelegate.swift
//  Tippzi
//
//  Created by Admin on 11/2/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift
import FBSDKLoginKit
import GooglePlaces
import CoreLocation
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var flag : Bool!
    var flag1 : Bool!
    
    var locationManager = CLLocationManager()
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    var bgtimer = Timer()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var current_time = NSDate().timeIntervalSince1970
    var timer = Timer()
    var f = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyCt_Y2OAIB6iq04pMOv5QAA79VBkNr6Uzc")
        GMSPlacesClient.provideAPIKey("AIzaSyCt_Y2OAIB6iq04pMOv5QAA79VBkNr6Uzc")
//        AIzaSyDuHNel_hu03S8zYp4w8jOFrnlZq4eT2YA
        GPPSignIn.sharedInstance().clientID = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com"
        
//        IQKeyboardManager.sharedManager().enable = true
//        IQKeyboardManager.sharedManager().enableDebugging = true
//        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemImage = UIImage(named: "keydown")
//        IQKeyboardManager.sharedManager().shouldShowToolbarPlaceholder = true
//        IQKeyboardManager.sharedManager().shouldPlayInputClicks = false
        
        Twitter.sharedInstance().start(withConsumerKey:"55Z4U9O9m3AjM7EpLrzg4YauD", consumerSecret:"PHJXcdbELzqGtf2TByGs7AsvW4GYSPGumpZYChRY74AlH32IqC")
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app : UIApplication, open url : URL, options:[UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        flag = GPPURLHandler.handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        //let isFacebookURL = url.scheme != nil && url.scheme!.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"
        //if isFacebookURL {
        flag =  FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
//        flag = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        //}
        flag = Twitter.sharedInstance().application(app, open: url, options: options)
        return flag
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        GPPSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
    }
}

