//
//  ProfileController.swift
//  ATrails
//
//  Created by Turing on 11/26/23.
//

import Foundation
import Firebase

class ProfileController: ObservableObject {
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
        
        let postRef = db.collection("posts").whereField("userID", isEqualTo: currentUserID!)
        
        // getting user's followers using their ID
        postRef.getDocuments(source: .server) { (snapshot, error) in
            if let error = error {
                print("There was an error fetching user's posts: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                for documents in snapshot.documents {
                    // creating a post for each doc
                    let post = Post(data: documents.data())
                    
                    // adding it to list
                    self.postArray.append(post!)
                }
            }
        }
        
        // we are no longer loading
        isLoading.toggle()
    }
}
