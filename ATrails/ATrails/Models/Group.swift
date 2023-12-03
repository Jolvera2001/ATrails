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
