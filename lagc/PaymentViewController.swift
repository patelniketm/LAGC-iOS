//
//  PaymentViewController.swift
//  lagc
//
//  Created by Patel Niket M on 10/12/17.
//  Copyright © 2017 ESyz Solutions. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
        let localHtmlFile = Bundle.main.url(forResource: "donations", withExtension: "html");
        
        
        let request = NSURLRequest(url: localHtmlFile!);
        
        webView.loadRequest(request as URLRequest);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

