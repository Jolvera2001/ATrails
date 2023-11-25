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
        // first we need to get who this user is following
        // let followerRef: Query = db.collection("following").whereField("userID", isEqualTo: currentUserID!)
        let postRef = db.collection("posts")
        
        // getting following list
        db.collection("following").whereField("userID", isEqualTo: currentUserID!).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching list of following from current user: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                for userDocument in snapshot.documents {
                    if let userID  = userDocument["userID"] as? String {
                        let userPostQuery = postRef.whereField("userID", isEqualTo: userID).limit(to: 3)
                        userPostQuery.getDocuments(completion: { (postSnapshot, postError) in
                            if let error = postError {
                                print("Error fetching posts for user \(userID): \(error.localizedDescription)")
                            } else if let postSnapshot = postSnapshot {
                                for document in postSnapshot.documents {
                                    if let post = Post(data: document.data()) {
                                        self.postArray.append(post)
                                    }
                                }
                            }
                        })
                    }
                }
            }
        }
    }
}
