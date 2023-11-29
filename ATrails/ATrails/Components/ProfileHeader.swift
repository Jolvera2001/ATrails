//
//  ProfileHeader.swift
//  ATrails
//
//  Created by Turing on 11/26/23.
//

import SwiftUI

struct ProfileHeader: View {
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button {
                    print("Edit Profile Button was tapped")
                } label: {
                    Label("", systemImage: "gearshape.fill")
                        .font(.title)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            HStack {
                AsyncImage(url: URL(string: authController.currentUser?.profilePictureURL ?? ""))
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                VStack {
                    Text(authController.currentUser?.username ?? "Not Found")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(5)
                    
                    HStack {
                        if let followerCount = authController.currentUser?.followers.count {
                            Text("Followers: \(followerCount)")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        } else {
                            Text("Followers: Error")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        
                        if let followingCount = authController.currentUser?.following.count {
                            Text("Following: \(followingCount)")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        } else {
                            Text("Followers: Error")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            
            Text("Bio: ")
                .foregroundColor(.white)
                .font(.title3)
                .padding(.horizontal, 30)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let bio = authController.currentUser?.profileBio {
                Text("\(bio)")
                    .font(.system(size: 18.5))
                    .padding(.horizontal, 25)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
            } else {
                Text("Error with reading bio from DB")
            }
        }
        .border(.black)
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        let authController = AuthController()
        
        authController.currentUser = User(userID: "12345", fullname: "ATrails Team", username: "AtrailsTeam", password: "12345", email: "AtrailsTeam@gmail.com", followers: ["something", "something"], following: ["something"], profilePictureURL: "https://www.nyip.edu/images/cms/photo-articles/the-best-place-to-focus-in-a-landscape.jpg", profileBio: "Hi There! This is a test for the profile section of this app! Hoping that this will be sometihng that could be useful as we move forward!")
        
        return ProfileHeader().environmentObject(authController)
    }
}
