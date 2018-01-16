//
//  FlyersViewController.swift
//  lagc
//
//  Created by Patel Niket M on 1/15/18.
//  Copyright © 2018 ESyz Solutions. All rights reserved.
//

import UIKit

class FlyersViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false)
        
        let flyerURL = documentsURL.appendingPathComponent("flyers.html")
        
        let request = NSURLRequest(url: flyerURL);
        webView.loadRequest(request as URLRequest);
        
        //        } else {
        //            // handle the error
        //            debugPrint("Failed to Load About")
        //        }

//        
//        
//        let localHtmlFile = Bundle.main.url(forResource: "flyers", withExtension: "html");
//        
//        
//        let request = NSURLRequest(url: localHtmlFile!);
//        
//        webView.loadRequest(request as URLRequest);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

