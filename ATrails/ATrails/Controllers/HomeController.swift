//
//  HomeController.swift
//  ATrails
//
//  Created by Turing on 11/24/23.
//

import Foundation
import Firebase

class HomeController: ObservableObject {
    let db = Firestore.firestore()
    var currentUserID: String?
    
    func setCurrentUser(userID: String?) {
        self.currentUserID = userID
    }
    
    @Published var postArray: [Post] = []
    
    func fetchPosts() {
        let postRef = db.collection("posts")
        
        
    }
}
