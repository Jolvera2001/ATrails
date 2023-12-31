//
//  Post.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import Foundation

struct Post: Identifiable, Codable {
    var id = UUID().uuidString
    var userID: String
    var username: String
    var userPFP: String
    var text: String
    
    // optional things, URL's and Hikes
    var media: String?
    var hike: Hike?
}

//extension Post {
//    init?(data: [String: Any]) {
//        if let id = data["id"] as? String,
//        let userID = data["UserID"] as? String,
//        let username = data["username"] as? String,
//        let userPFP = data["userPFP"] as? String,
//        let text = data["text"] as? String,
//        let postTimestamp = data["postTimestamp"] as? Date
//        {
//            self.id = id
//            self.userID = userID
//            self.username = username
//            self.userPFP = userPFP
//            self.text = text
//            self.postTimestamp = postTimestamp
//        }
//        else {
//            return nil
//        }
//    }
//}

extension Post {
    init?(data: [String: Any]) {
        let dateFormatter = DateFormatter()
        guard let id = data["id"] as? String,
              let userID = data["userID"] as? String,
              let username = data["username"] as? String,
              let userPFP = data["userPFP"] as? String,
              let text = data["text"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.userID = userID
        self.username = username
        self.userPFP = userPFP
        self.text = text
        
        // Handling optional properties
        if let media = data["media"] as? String {
            self.media = media
        } else {
            self.media = nil
        }
    }
}
