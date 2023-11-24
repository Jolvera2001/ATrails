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
    let atrailsTeamID = "0579138B-3592-4BC9-83A8-D8EF75DEE704"
    
    @Published var currentUser: User?
    
    // registering
    func register(user: User, completion: @escaping (Error?) -> Void) {
        var initialFollowers: [String] = [atrailsTeamID]
        var initialFollowing: [String] = [atrailsTeamID]
        let userID = uniqueID.uuidString
        
        db.collection("users").addDocument(data: [
            "userID": userID,
            "username": user.username,
            "fullname": user.fullname,
            "password": user.password,
            "email": user.email
        ]) {error in
            if error == nil {
                self.currentUser = user
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
            .getDocuments {
                (querySnapshot, error) in
                if let error = error {
                    print("Error getting docs: \(error)")
                    completion(false)
                } else {
                    guard let documents = querySnapshot?.documents else {
                        completion(false)
                        return
                    }
                    if let userDocument = documents.first, let storedPassword = userDocument["password"] as? String {
                        if password == storedPassword {
                            let user = User(
                                userID: userDocument["userID"] as? String ?? "",
                                fullname: userDocument["fullname"] as? String ?? "",
                                username: userDocument["username"] as? String ?? "",
                                password: storedPassword,
                                email: userDocument["email"] as? String ?? ""
                            )
                            self.currentUser = user
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
