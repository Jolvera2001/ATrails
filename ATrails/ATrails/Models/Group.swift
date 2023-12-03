//
//  Group.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import Foundation

struct Group: Codable, Identifiable {
    var id = UUID().uuidString
    var owner: String // userID
    var groupName: String
    var members: [String]?
    var messages: [Message]?
}

//extension Post {
//    init?(data: [String: Any]) {
//        let dateFormatter = DateFormatter()
//        guard let id = data["id"] as? String,
//              let userID = data["userID"] as? String,
//              let username = data["username"] as? String,
//              let userPFP = data["userPFP"] as? String,
//              let text = data["text"] as? String
//        else {
//            return nil
//        }
//
//        self.id = id
//        self.userID = userID
//        self.username = username
//        self.userPFP = userPFP
//        self.text = text
//
//        // Handling optional properties
//        if let media = data["media"] as? String {
//            self.media = media
//        } else {
//            self.media = nil
//        }
//    }
//}

extension Group {
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String,
              let owner = data["owner"] as? String,
              let groupName = data["groupName"] as? String,
              let members = data["members"] as? [String],
              let messages = data["messages"] as? [Message]
        else {
            return nil
        }
        self.id = id
        self.owner = owner
        self.groupName = groupName
        self.members = members
        self.messages = messages
    }
}
