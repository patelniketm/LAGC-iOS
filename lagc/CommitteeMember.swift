//
//  committeeMember.swift
//  lagc
//
//  Created by Patel Niket M on 10/31/17.
//  Copyright © 2017 ESyz Solutions. All rights reserved.
//

import Foundation

struct CommitteeMember {
    let id: Int16
    
    let name: String
    let designation: String
    let email: String
    
    let avatarURL: URL
}

extension CommitteeMember {
    
    init?(json: [String: Any]) throws {
        
        guard let name = json["name"] as? String,
            let designation = json["designation"] as? String,
            let email = json["email"] as? String,
            
            let id = json["id"] as? Int,
            let avatarURL = json["avatarURL"] as? URL
            else {
                return nil
        }
        
        self.name = name
        self.designation = designation
        self.email = email
        
        self.avatarURL = avatarURL
        self.id = Int16(id)
    }
    
//    let session: URLSession.shared // shared session for interacting with the web service
    
    static func fetchCommitteeMembers(completion: @escaping ([CommitteeMember]) -> Void) {
        let jsonURL = URL(string:"https://storage.googleapis.com/lagc-b71b7.appspot.com/pages/CommitteeMembers.json")
        let session: URLSession
        
//        session.dataTask(with: jsonURL!, completionHandler: {(data, response, error) in
//            print(data)
//        }).resume()
        
//        session.dataTask(with: jsonURL!, completionHandler: { (data, response, error) in
//            
//            var committeeMemberList: [CommitteeMember] = []
//            
//            if let data = data,
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    print(json)
////                for case let result in json?["committeeMembers"] {
////                    if let committeeMember = CommitteeMember(json: result) {
////                        committeeMemberList.append(committeeMember)
////                    }
////                }
//            }
//        
//            completion(committeeMemberList)
//            
//        }).resume()
        
    }
}
