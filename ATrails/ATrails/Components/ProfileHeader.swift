//
//  ProfileHeader.swift
//  ATrails
//
//  Created by Turing on 11/26/23.
//

import SwiftUI

struct ProfileHeader: View {
    @EnvironmentObject var authController: AuthController
    @State var isInProfileOptions = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button {
                    isInProfileOptions.toggle()
                } label: {
                    Label("", systemImage: "gearshape.fill")
                        .font(.title)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.fullScreenCover(isPresented: $isInProfileOptions) {
                    NavigationView {
                        ProfileOptions()
                    }
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
            Divider().overlay(.white)
        }
        .padding(5)
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        let authController = AuthController()
        
        authController.currentUser = User(userID: "12345", fullname: "ATrails Team", username: "AtrailsTeam", password: "12345", email: "AtrailsTeam@gmail.com",  profileBio: "Hi There! This is a test for the profile section of this app! Hoping that this will be sometihng that could be useful as we move forward!", followers: ["something", "something"], following: ["something"], profilePictureURL: "https://i5.walmartimages.com/seo/Zebco-Slingshot-Spincast-Reel-and-Fishing-Rod-Combo-Blue_8d16437b-53df-4afe-86bd-ed757bba138f.9f6fb8efb9ebe56a55bd4a70ea059e47.png")
        
        return ProfileHeader().environmentObject(authController)
    }
}
