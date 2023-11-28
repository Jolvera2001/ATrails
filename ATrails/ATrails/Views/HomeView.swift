//
//  HomeView.swift
//  ATrails
//
//  Created by Turing on 11/10/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var homeController = HomeController()
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x226EB6), Color(hex: 0x124271)]))
                .edgesIgnoringSafeArea(.all)
            
            if homeController.isLoading {
                ProgressView("Loading...")
            } else {
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(homeController.postArray) {post in
                                UserPost(post: post)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .onAppear {
                    // fetch the posts
                    homeController.setCurrentUser(userID: authController.currentUser?.userID)
                    homeController.fetchPosts()
                }
            }
        }
    }
}

struct GroupView: View {
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x226EB6), Color(hex: 0x124271)]))
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapView: View {
    @EnvironmentObject var authController: AuthController
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x226EB6), Color(hex: 0x124271)]))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Map(coordinateRegion: $region,
                    showsUserLocation: true)
                    .edgesIgnoringSafeArea(.top)
                    .padding(.bottom)
                    .onAppear {
                        locationManager.requestWhenInUseAuthorization()
                    }
            }
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var profileController = ProfileController()
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x226EB6), Color(hex: 0x124271)]))
                .edgesIgnoringSafeArea(.all)
            VStack {
                ProfileHeader()
                ScrollView {
                    VStack {
                        if profileController.postArray.isEmpty {
                            Spacer().frame(height: 150)
                            Text("You have no posts yet!")
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(maxWidth: 270)
                        } else {
                            ForEach(profileController.postArray) {post in
                                UserPost(post: post)
                            }
                        }
                    }
                }
                .frame(minHeight: 200, maxHeight: 500)
            }
        }
    }
}

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color(hex: 0xFFF), for: .tabBar)
            GroupView()
                .tabItem {
                    Label("Group", systemImage: "message")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
            MapView()
                .tabItem {
                    Label("Map", systemImage: "mountain.2")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color(hex: 0xBFDDFF))
    }
}

// ************************** PREVIEWS ***************************

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthController())
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView().environmentObject(AuthController())
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environmentObject(AuthController())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthController())
    }
}

struct TabBarView_Preview: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(AuthController())
    }
}

// **************** HELPER METHODS **************************


