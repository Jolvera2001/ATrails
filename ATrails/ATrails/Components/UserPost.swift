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
        ZStack {
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
                
                // this is where either the media or hike will be, not both
                // we can handle error checking that in the make a post view
                // we may need to come back later to put this in
                
                HStack {
                    Text(post.text)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(Color("ABlue"))
            .cornerRadius(10)
            .padding(25)
            .shadow(radius: 2)
        }
    }
}

struct UserPost_Previews: PreviewProvider {
    static var previews: some View {
        let authController = AuthController()
        
        UserPost(post: Post(userID: "admin", username:"admin", userPFP: "https://www.nyip.edu/images/cms/photo-articles/the-best-place-to-focus-in-a-landscape.jpg", text: "This is an ATrails post! Let's test to see how big we can make this post. Oh wow looks like it's handling it pretty well!", postTimestamp: Date()  )).environmentObject(authController)
    }
}
