//
//  ContactViewController.swift
//  lagc
//
//  Created by Patel Niket M on 1/15/18.
//  Copyright © 2018 ESyz Solutions. All rights reserved.
//

import Foundation

class ContactViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let contactURL = URL(string: "https://www.lagc.us/contact-us")
        
        let request = NSURLRequest(url: contactURL!);
        webView.loadRequest(request as URLRequest);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

