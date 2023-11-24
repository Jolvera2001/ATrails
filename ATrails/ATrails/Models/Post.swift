//
//  Post.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import Foundation

struct Post: Codable {
    var userID: String
    var username: String
    var userPFP: String
    var text: String
    
    // optional things, URL's and Hikes
    var media: String?
    var hike: Hike?
}
