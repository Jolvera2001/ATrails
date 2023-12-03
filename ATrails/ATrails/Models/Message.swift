//
//  Message.swift
//  ATrails
//
//  Created by Turing on 11/10/23.
//

import Foundation

struct Message: Codable {
    var username: String
    var userID: String
    var messageText: String
    var messageTimestamp: Date
}
