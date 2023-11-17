//
//  Hike.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import Foundation
import Firebase

struct Hike: Codable {
    var post: Post
    var hikeStart: [Double]
    var hikeEnd: [Double]
}
