//
//  AuthController.swift
//  ATrails
//
//  Created by Turing on 11/11/23.
//

import Foundation
import Firebase

class AuthController: ObservableObject {
    let db = Firestore.firestore()
    let uniqueID = UUID()
    let atrailsTeamID = "FEC9A016-0762-4309-B765-164A7074889E"
    
    @Published var currentUserID: String?
    
    // registering
    func register(user: User, completion: @escaping (Error?) -> Void) {
        let initialFollowers: [String] = [atrailsTeamID]
        let initialFollowing: [String] = [atrailsTeamID]
        let userID = uniqueID.uuidString
        
        db.collection("users").document(userID).setData([
            "userID": userID,
            "username": user.username,
            "fullname": user.fullname,
            "password": user.password,
            "following": [atrailsTeamID],
            "followers": [atrailsTeamID],
            "email": user.email
        ]) {error in
            if error == nil {
                self.currentUserID = userID
            }
            completion(error)
        }
        
        // then we should add the Atrails user as a follower and following user to instantiate the other documents
        
        // adding as following
        db.collection("following").addDocument(data: [
            "userID": userID,
            "following": initialFollowing
        ]) {error in
            if error == nil {
                
            }
            completion(error)
        }
        
        // adding as follower
        db.collection("followers").addDocument(data: [
            "userID": userID,
            "followers": initialFollowers
        ]) {error in
            if error == nil {
                
            }
            completion(error)
        }
    }
    
    // Loggin in
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .whereField("username", isEqualTo: username)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting docs: \(error)")
                    completion(false)
                } else {
                    guard let documents = querySnapshot?.documents else {
                        completion(false)
                        return
                    }
                    if let userDocument = documents.first, let storedPassword = userDocument["password"] as? String {
                        print("Successfully got user logged in document")
                        
                        if password == storedPassword {
                            self.currentUserID = userDocument["userID"] as? String
                            completion(true)
                        } else {
                            completion(false)
                        }
                    } else {
                        completion(false)
                    }
                }
            }
    }
}
