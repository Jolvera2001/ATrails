//
//  UserPost.swift
//  ATrails
//
//  Created by Turing on 11/16/23.
//

import SwiftUI
import Foundation

struct UserPost: View {
    var post: Post
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                AsyncImage(url: URL(string: post.userPFP))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                Text(post.username)
                    .foregroundColor(.white)
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            HStack {
                Text(post.text)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("ABlue"))
        .padding(30)
        .cornerRadius(30)
        .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.clear)
                        .background(Color("ABlue"))
                )
                .cornerRadius(30)
    }
}

struct UserPost_Previews: PreviewProvider {
    static var previews: some View {
        let authController = AuthController()
        
        UserPost(post: Post(userID: "admin", username:"admin", userPFP: "https://www.nyip.edu/images/cms/photo-articles/the-best-place-to-focus-in-a-landscape.jpg", text: "This is an ATrails post! Let's test to see how big we can make this post. Oh wow looks like it's handling it pretty well!"  )).environmentObject(authController)
    }
}
