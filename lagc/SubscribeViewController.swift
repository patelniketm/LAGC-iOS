//
//  AboutViewController.swift
//  lagc
//
//  Created by Patel Niket M on 10/12/17.
//  Copyright © 2018 ESyz Solutions. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localHtmlFile = Bundle.main.url(forResource: "about", withExtension: "html");
        
        
        let request = NSURLRequest(url: localHtmlFile!);
        
        webView.loadRequest(request as URLRequest);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

