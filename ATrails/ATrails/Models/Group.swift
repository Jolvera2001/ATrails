//
//  Group.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import Foundation

struct Group: Codable {
    var owner: String // userID
    var groupName: String
    var members: [User]
    var messages: [Message]
}
