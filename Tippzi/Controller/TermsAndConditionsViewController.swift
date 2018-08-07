//
//  TermsAndConditionsViewController.swift
//  Tippzi
//
//  Created by Admin on 4/5/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class TermsAndConditionsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        webView.loadRequest(URLRequest.init(urlString: Common.webUrl)!)
    }
    
    @IBAction func actionAccept(_ sender : Any) {
        Common.isAccepted = true
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionDecline(_ sender : Any) {
        Common.isAccepted = false
        
        self.dismiss(animated: true, completion: nil)
    }
}

