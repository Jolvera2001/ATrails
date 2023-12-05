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
    
    func createPost() {
        
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not get JPEG representation of image")
            return
        }
        
        let storageRef = storage.reference()
        let imageName = generateShortUniqueString(length: 8)
        let imageRef = storageRef.child("images/\(imageName)")
        
        let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Image uploaded successfully.")
            
            // getting the image URL
            imageRef.downloadURL{ (url, error) in
                if let downloadedURL = url {
                    self.imageURL = downloadedURL.absoluteString
                } else {
                    print("Error fetching URL: \(error?.localizedDescription ?? "")")
                }
            }
        }
        
    }
    
    func generateShortUniqueString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}


