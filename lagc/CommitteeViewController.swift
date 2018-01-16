//
//  CommitteeViewController.swift
//  lagc
//
//  Created by Patel Niket M on 10/15/17.
//  Copyright © 2017 ESyz Solutions. All rights reserved.
//

import UIKit
import Firebase

class CommitteeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    var storage: Storage!
    var memberList: Data!
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath as IndexPath) as! CommitteeMembersTableViewCell
        
        CommitteeMember.fetchCommitteeMembers { committeMember in
            cell.memberAvatar.image = nil
            print(committeMember)
//            cell.memberDesignation.text = committeMember.designation
//            cell.memberName.text = committeMember.name
//            cell.memberContactDetails.text = committeMember.contact
        }
        
        cell.memberAvatar.image = nil
        cell.memberDesignation.text = "President"
        cell.memberName.text = "Thakkar, Tushar"
        cell.memberContactDetails.text = "tusharmt@att.net"
        
        return cell
    }
    
    
    // [START downloadimage]
//    storageRef.child(storagePath).write(toFile: fileURL, completion: { (url, error) in
//    if let error = error {
//    print("Error downloading:\(error)")
//    self.statusTextView.text = "Download Failed"
//    return
//    } else if let imagePath = url?.path {
//    self.statusTextView.text = "Download Succeeded!"
//    self.imageView.image = UIImage.init(contentsOfFile: imagePath)
//    }
//    })
    // [END downloadimage]
    
    func loadMemberList(){
        // Create a reference from a Google Cloud Storage URI
        let gsCommitteeMembersList = storage.reference(forURL: "gs://lagc-b71b7.appspot.com/pages/CommitteeMembers.json")
//        https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/CommitteeMembers.json
        
        gsCommitteeMembersList.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                    memberList = jsonResponse.committeeMembers
                    
                    print(jsonResponse as! NSDictionary)
                } catch let myJSONError {
                    print(myJSONError)
                }
                // Data for "images/island.jpg" is returned
//                let image = UIImage(data: data!)
            }
        }

//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory = paths[0]
//        let filePath = "file:\(documentsDirectory)/myimage.jpg"
//        guard let fileURL = URL.init(string: filePath) else { return }
//        guard let storagePath = UserDefaults.standard.object(forKey: "storagePath") as? String else {
//            return
//        }
        
//        let url = "http:here.com/" + String(authorid) + "/"
//        println(url)
//        Alamofire.request(.GET, url).responseJSON { (Request, response, json, error) -> Void in
//            if (json != nil){
//                var jsonObj = JSON(json!)
//                if let data = jsonObj["articles"].arrayValue as [JSON]?{
//                    self.articles = data
//                    self.authorArticlesTableView.reloadData()
//                }
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        storage = Storage.storage()
        self.loadMemberList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

