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
    
    func setCurrentUserID(userID: String?) {
        self.currentUserID = userID
    }
    
    // both views would need their own functions
    
    // the search bar would need to do something
    
    // the group chats would also need their own fetch function
}
