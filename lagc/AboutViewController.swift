//
//  AboutViewController.swift
//  lagc
//
//  Created by Patel Niket M on 10/12/17.
//  Copyright © 2017 ESyz Solutions. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
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
        
        let aboutURL = documentsURL.appendingPathComponent("about.html")
        
        let request = NSURLRequest(url: aboutURL);
        webView.loadRequest(request as URLRequest);
            
//        } else {
//            // handle the error
//            debugPrint("Failed to Load About")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

