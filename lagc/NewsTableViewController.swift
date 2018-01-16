//
//  NewsTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = DownloadManager.shared.activate()

        if revealViewController() != nil {
//            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        startDownload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DownloadManager.shared.onProgress = { (progress) in
//            OperationQueue.main.addOperation {
//                self.progressView.progress = progress
//            }
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }
    
    var batchURL:[String] = [
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/about.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/flyers.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/donations.html",
        "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/committee.html"
    ]
    
    func startDownload() {
//        let url = URL(string: "https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/about.html")!
//        let task = DownloadManager.shared.activate().downloadTask(with: url)
//        task.resume()
        
        self.downloadFile(url: batchURL[0]);
        
    }
    
    
    
    // With Alamofire
//    func fetchAllRooms(completion: @escaping ([RemoteRoom]?) -> Void) {
//        Alamofire.request(
//            URL(string: "http://localhost:5984/rooms/_all_docs")!,
//            method: .get,
//            .validate()
//            .responseJSON { (response) -> Void in
//                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(response.result.error)")
//                    completion(nil)
//                    return
//                }
//                
//                guard let value = response.result.value as? [String: Any],
//                    let rows = value["rows"] as? [[String: Any]] else {
//                        print("Malformed data received from fetchAllRooms service")
//                        completion(nil)
//                        return
//                }
//                
//                let rooms = rows.flatMap({ (roomDict) -> RemoteRoom? in
//                    return RemoteRoom(jsonData: roomDict)
//                })
//                
//                completion(rooms)
//        }
//    }
//    
    
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "watchkit-intro")
            cell.postTitleLabel.text = "WatchKit Introduction: Building a Simple Guess Game"
            cell.authorLabel.text = "Simon Ng"
            cell.authorImageView.image = UIImage(named: "author")

        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "custom-segue-featured-1024")
            cell.postTitleLabel.text = "Building a Chat App in Swift Using Multipeer Connectivity Framework"
            cell.authorLabel.text = "Gabriel Theodoropoulos"
            cell.authorImageView.image = UIImage(named: "appcoda-300")
            
        } else {
            cell.postImageView.image = UIImage(named: "webkit-featured")
            cell.postTitleLabel.text = "A Beginner’s Guide to Animated Custom Segues in iOS 8"
            cell.authorLabel.text = "Gabriel Theodoropoulos"
            cell.authorImageView.image = UIImage(named: "appcoda-300")
            
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
