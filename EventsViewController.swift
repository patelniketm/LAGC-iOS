//
//  EventsViewController.swift
//  lagc
//
//  Created by Patel Niket M on 1/15/18.
//  Copyright © 2018 ESyz Solutions. All rights reserved.
//

import UIKit
import Alamofire

class EventsViewController: UIViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.downloadFile(url: batchURL[0]);
        
        let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false)
        
        let aboutURL = documentsURL.appendingPathComponent("events.html")
        
        let request = NSURLRequest(url: aboutURL);
        webView.loadRequest(request as URLRequest);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    var batchURL:[String] = [
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/events.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/donations.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/about.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/flyers.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/committee.html"
    ]
    
    func downloadFile(url: String)->Void{
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        
        Alamofire.download(
            url,
            method: .get,
            //            encoding: UTF16.default,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
                OperationQueue.main.addOperation {
                    self.progressView.progress = Float(progress.fractionCompleted)
                }
                
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
                self.batchURL.removeFirst()
                if DefaultDownloadResponse.response?.statusCode == 200 {
                    
                    print(DefaultDownloadResponse.destinationURL)
                    
                    if !self.batchURL.isEmpty{
                        self.downloadFile(url: self.batchURL[0])
                    }
                }
            })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
