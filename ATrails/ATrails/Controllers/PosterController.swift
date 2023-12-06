//
//  PosterController.swift
//  ATrails
//
//  Created by Turing on 12/4/23.
//

import Foundation
import Firebase
import FirebaseStorage

class PosterController: ObservableObject {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var imageURL: String?
    
    // we could use two different createPost functions
    func createPost(currentUser: User, postText: String, completion: @escaping () -> Void) {
        let postToSave = Post(userID: currentUser.userID, username: currentUser.username, userPFP: currentUser.profilePictureURL ?? "", text: postText)
        
        // now we put it into firestore
        let postRef = db.collection("posts")
        let data: [String: Any] = [
            "id": postToSave.id,
            "userID": postToSave.userID,
            "username": postToSave.username,
            "text": postToSave.text,
            "userPFP": postToSave.userPFP,
            "media": "",
            "hike": "",
            "postTimeStamp": Date()
        ]
        
        postRef.addDocument(data: data) { error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            } else {
                print("file successfully saved")
            }
        }
       
    }
    
    func createPost(currentUser: User, postText: String, image: URL, completion: @escaping () -> Void) {
        var postToSave = Post(userID: currentUser.userID, username: currentUser.username, userPFP: currentUser.profilePictureURL ?? "", text: postText)
        
        // this will set the URL string
        uploadImage(image: image)
        
        postToSave.media = imageURL
        
        // now we put it into firestore
        let postRef = db.collection("posts")
        let data: [String: Any] = [
            "id": postToSave.id,
            "userID": postToSave.userID,
            "username": postToSave.username,
            "text": postToSave.text,
            "userPFP": postToSave.userPFP,
            "media": postToSave.media ?? "",
            "hike": "",
            "postTimeStamp": Date()
        ]
        
        postRef.addDocument(data: data) { error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            } else {
                print("file successfully saved")
                self.imageURL = ""
            }
        }
       
    }
    
    func uploadImage(image: URL) {
        let storageRef = storage.reference()
        let imageName = generateShortUniqueString(length: 8)
        let imageRef = storageRef.child("images/\(imageName)")
        
        let uploadTask = imageRef.putFile(from: image, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                return
            }
            
            imageRef.downloadURL{ (url, error) in
                guard let downloadURL = url else {
                    return
                }
                self.imageURL = downloadURL.absoluteString
            }
        }
    }
    
    func generateShortUniqueString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}


