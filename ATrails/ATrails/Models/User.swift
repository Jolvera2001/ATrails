//
//  User.swift
//  ATrails
//
//  Created by Turing on 11/10/23.
//

import Foundation

struct User: Codable {
    var userID: String
    var fullname: String
    var username: String
    var password: String
    var email: String
    var profilePictureURL: String?
    var profileBio: String?
}
