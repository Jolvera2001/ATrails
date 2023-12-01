//
//  GroupItemSearch.swift
//  ATrails
//
//  Created by Turing on 11/30/23.
//

import SwiftUI

struct GroupItemSearch: View {
    @EnvironmentObject var authController: AuthController
    var groupData: Group
    
    var body: some View {
        VStack {
            HStack {
                Text(groupData.groupName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(35)
                
//                if ((groupData.members?.) {
//                    Button {
//                    } label: {
//                        <#code#>
//                    }
//                } else {
//                    Button {
//                    } label: {
//                        <#code#>
//                    }
//                }
            }
        }
    }
}

struct GroupItemSearch_Previews: PreviewProvider {
    static var previews: some View {
        GroupItemSearch(groupData: Group(owner: "Someone", groupName: "Scrimblo Runners", members: [], messages: []))
    }
}
