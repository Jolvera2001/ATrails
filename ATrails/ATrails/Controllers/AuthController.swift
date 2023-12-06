//
//  AuthController.swift
//  ATrails
//
//  Created by Turing on 11/11/23.
//

import Foundation
import Firebase

class AuthController: ObservableObject {
    @Published var isLogged = false
    @Published var isRegistered = false
    let db = Firestore.firestore()
    let uniqueID = UUID()
    let atrailsTeamID = "FEC9A016-0762-4309-B765-164A7074889E"
    
    @Published var currentUser: User?
    
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
            "following": initialFollowing,
            "followers": initialFollowers,
            "profileBio": user.profileBio,
            "email": user.email
        ]) {error in
            if error == nil {
                self.currentUser = user
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
                            let user = User(
                                userID: userDocument["userID"] as? String ?? "",
                                fullname: userDocument["fullname"] as? String ?? "",
                                username: userDocument["username"] as? String ?? "",
                                password: storedPassword,
                                email: userDocument["email"] as? String ?? "",
                                profileBio: userDocument["profileBio"] as? String ?? "",
                                followers: userDocument["followers"] as? [String] ?? [],
                                following: userDocument["following"] as? [String] ?? []
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
