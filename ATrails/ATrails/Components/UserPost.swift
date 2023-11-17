//
//  UserPost.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import SwiftUI

struct UserPost: View {
    var post: Post
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(post.text)
                    .padding(15)
                    .background(Color("ABlue"))
                    .cornerRadius(20)
            }
            .frame(maxWidth: 300)
        }
        .frame(maxWidth: .infinity)
        .padding(.trailing)
        .padding(.horizontal, 10)
    }
}

struct UserPost_Previews: PreviewProvider {
    static var previews: some View {
        let authController = AuthController()
        
        UserPost(post: Post(userID: "admin", userPFP: "", text: "This is an ATrails post!")).environmentObject(authController)
    }
}
