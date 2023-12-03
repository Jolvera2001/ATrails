//
//  GroupController.swift
//  ATrails
//
//  Created by Johan Olvera on 11/30/23.
//

import Foundation
import Firebase

class GroupController: ObservableObject {
    let db = Firestore.firestore()
    var currentUserID: String?
    
    var groupArray: [Group] = []
    var groupItemSearchArray: [Group] = []
    
    func setCurrentUserID(userID: String?) {
        self.currentUserID = userID
    }
    
    func searchGroups(groupQuery: String) {
        // debugging purposes
        // print("\(groupQuery), is your query")
        
        //empty group
        groupItemSearchArray = []
        
        let groupRef = db.collection("groups")
            .whereField("groupName", isGreaterThanOrEqualTo: groupQuery)
            .whereField("groupName", isLessThanOrEqualTo: groupQuery)
        
        groupRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("error with query: \(error.localizedDescription)")
            } else if let querySnapshot = querySnapshot {
                for documents in querySnapshot.documents {
                    let groupSearchItem = Group(data: documents.data())
                    
                    // adding it to search list
                    self.groupItemSearchArray.append(groupSearchItem ?? Group(owner: "Something is wrong", groupName: "Something went wrong"))
                }
            }
        }
    }
    
    func addUserToGroup(groupName: String, userToAdd: String) {
        // we just add the user to the members list
    }
    
    func removeUserFromGroup(groupName: String, userToRemove: String) {
        // we just need to remove the user from the members list
    }
    
    // both views would need their own functions
    
    // the search bar would need to do something
    
    // the group chats would also need their own fetch function
}
