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
    var isLoading: Bool = false
    var currentUserID: String?
    
    func setCurrentUser(userID: String?) {
        self.currentUserID = userID
    }
    
    @Published var postArray: [Post] = []
    
    func fetchPosts() {
        // we are loading
        isLoading.toggle()
        
        // let's empty the posts we have
        postArray = []
        
        let postRef = db.collection("posts")
        let userRef = db.collection("users").document(currentUserID!)
        
        // getting user's followers using their ID
        userRef.getDocument(source: .server) { (document, error) in
            if let document = document {
                let followingList = document.get("following") as? [String]
                
                // now we iterate through the following list
                for userID in followingList! {
                    postRef.whereField("userID", isEqualTo: userID).getDocuments(source: .server) { (snapshot, error) in
                        if let error = error {
                            print("There was an error in fetching this user's posts: \(error)")
                        } else if let snapshot = snapshot {
                            for documents in snapshot.documents {
                                // creating a post for each doc
                                let post = Post(data: documents.data())
                                
                                // adding it to list
                                self.postArray.append(post!)
                            }
                        }
                    }
                }
            } else {
                print("error getting list of people this user is following")
            }
        }
        
        // we are no longer loading
        isLoading.toggle()
    }
}
