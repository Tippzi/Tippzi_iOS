//
//  Tutorial3ViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class Tutorial3ViewController: UIViewController {

    @IBOutlet weak var btnSkip: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSkip.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        self.prepareSwipe()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    func prepareSwipe()
    {
        let swipefromleft = UISwipeGestureRecognizer(target:self, action: #selector(rightSwiping))
        swipefromleft.direction = .right
        view.addGestureRecognizer(swipefromleft)
        
        let swipefromright = UISwipeGestureRecognizer(target:self, action: #selector(leftSwiping))
        swipefromright.direction = .left
        view.addGestureRecognizer(swipefromright)
        
    }
    
    @objc func rightSwiping()
    {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "Tutorial2View")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @objc func leftSwiping()
    {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "Tutorial4View")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func btnSkipClick(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    

}
