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
    
    func fetchPosts() {
        // first we need to get who this user is following
        let currentUserID = AuthController().currentUser?.userID
        let followerRef = db.collection("following").document(currentUserID!)
        let postRef = db.collection("posts")
        
        // getting their following list
        followerRef.getDocument { snapshot, error in
            if error != nil {
                print("Error fetching list of followers from current user")
            } else if let snapshot = snapshot {
                if let following = snapshot.data()?["followers"] as? [String] {
                    // we got the users, let's find their posts
                    for user in following {
                        let postQuery = postRef.whereField("userID", isEqualTo: user).limit(to: 3)
                        postQuery.getDocuments { snapshot, error in
                            if let error = error {
                                print("Error in gathering following's posts")
                            } else if let snapshot = snapshot {
                                for document in snapshot.documents {
                                    let post = Post(data: document.data())
                                    self.postArray.append(post!)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
