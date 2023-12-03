//
//  UtilityViews.swift
//  ATrails
//
//  Created by Turing on 11/26/23.
//

import SwiftUI


// These views are for things like
// Create a Post <- this one will be interesting
// Profile actions
// Map actions
struct UtilityViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MakePost: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var homeController: HomeController
    
    @State private var textString: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x7BB4E3), Color(hex: 0x99E7F8)]))
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    HStack(spacing: 40) {
                        Button {
                            
                        } label: {
                            Text("Cancel")
                        }
                        .font(.title2)
                        
                        Text("Create a Post")
                            .font(.title2)
                            .frame(alignment: .leading)
                            .padding()
                        
                        Button {
                            
                        } label: {
                            Text("Post")
                        }
                        .font(.title2)
                        .padding(10)
                    }
                    
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: authController.currentUser?.profilePictureURL ?? ""))
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Text(authController.currentUser?.username ?? "Not Found")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                    
                    TextField("Share something on ATrails...", text: $textString, axis: .vertical)
                        .padding()
                        .font(.title3)
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .lineLimit(6, reservesSpace: true)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                VStack {
                    HStack(spacing: 30) {
                        Button {
                            
                        } label: {
                            VStack {
                                Label("", systemImage: "camera.fill")
                                Text("Photo")
                            }
                        }
                        .font(.title2)
                        .padding(10)
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Label("", systemImage: "photo.fill.on.rectangle.fill")
                                Text("Gallery")
                            }
                        }
                        .font(.title2)
                        .padding(10)
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Label("", systemImage: "map")
                                Text("Hikes")
                            }
                        }
                        .font(.title2)
                        .padding(10)
                    }
                }
            }
        }
    }
}

// **************************** PREVIEWS ********************************

struct UtilityViews_Previews: PreviewProvider {
    static var previews: some View {
        UtilityViews()
    }
}

struct MakePost_Previews: PreviewProvider {
    static var previews: some View {
        MakePost().environmentObject(AuthController())
    }
}
