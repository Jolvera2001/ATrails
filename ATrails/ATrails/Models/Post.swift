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
    var postTimestamp: Date
    
    // optional things, URL's and Hikes
    var media: String?
    var hike: Hike?
}
