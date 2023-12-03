//
//  GroupItemSearch.swift
//  ATrails
//
//  Created by Turing on 11/30/23.
//

import SwiftUI

struct GroupItemSearch: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var groupController: GroupController
    
    var groupData: Group
    
    var body: some View {
        VStack {
            HStack {
                Text(groupData.groupName)
                    .frame(maxWidth: 150, alignment: .leading)
                    .padding(.horizontal, 20)
                Spacer().frame(width: 50)
                if  let members: [String] = groupData.members,
                    members.contains(authController.currentUser!.username) {
                    Button(action: {groupController.removeUserFromGroup(groupName: groupData.groupName)}) {
                        Text("Leave")
                            .frame(maxWidth: 100, maxHeight: 45)
                            .padding(.horizontal, 20)
                    }
                } else {
                    Button(action: {groupController.addUserToGroup(groupName: groupData.groupName)}) {
                        Text("Join")
                            .frame(maxWidth: 100, maxHeight: 45)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .frame(maxHeight: 45)
    }
}

struct GroupItemSearch_Previews: PreviewProvider {
    static var previews: some View {
        var authController = AuthController()
        authController.currentUser = User(userID: "something", fullname: "Something", username: "Scrimblo64", password: "12345", email: "Scrim@gmail.com", profileBio: "", followers: [], following: [])
        
        return VStack {
            GroupItemSearch(groupController: GroupController(), groupData: Group(owner: "Someone", groupName: "Scrimblo Runners", members: ["ScrimbloMan"], messages: [])).environmentObject(authController)
            GroupItemSearch(groupController: GroupController(), groupData: Group(owner: "Someone", groupName: "Scrimblo Runners", members: ["Scrimblo64"], messages: [])).environmentObject(authController)
        }
    }
}
