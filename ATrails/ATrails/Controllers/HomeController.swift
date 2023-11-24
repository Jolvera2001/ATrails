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
    
    @Published var postArray: [Post] = []
    
    func fetchPosts(userID: String) {
        // first we need to get who this user is following
        let followerRef = db.collection("following").document(userID)
        var following: [String]?
        
        followerRef.getDocument { snapshot, error in
            if let error = error {
                print("Error fetching list of followers from current user")
            } else if let snapshot = snapshot {
                following = snapshot.data()?["followers"] as? [String]
            }
        }
        
        // we got the followers, now we need to get their posts
        
    }
}
