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
    @State var isOnMakePost = false
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x226EB6), Color(hex: 0x124271)]))
                .edgesIgnoringSafeArea(.all)
            
            if homeController.isLoading {
                Spacer()
                ProgressView("Loading...")
                    .foregroundColor(.white)
                Spacer()
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
                    if authController.currentUser != nil {
                        homeController.setCurrentUser(userID: authController.currentUser?.userID)
                        homeController.fetchPosts()
                    } else {
                        // for preview purposes
                    }
                }
                VStack(spacing: 5) {
                    Button(action: { }){
                        Label("", systemImage: "plus.circle.fill")
                            .padding(25)
                            .font(.system(size: 50))
                    }
                    
                    NavigationLink(
                        destination: MakePost(homeController: homeController),
                        isActive: $isOnMakePost,
                        label: { EmptyView() }
                    )
                }
                .navigationTitle("Another View")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
    }
}

struct GroupView: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var groupController = GroupController()
    
    // 0 = group search, 1 = group chat
    @State var selectedTab = 0
    @State var searchString = ""
    
    // for group search bar
    @State var groupQuery = ""
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x226EB6), Color(hex: 0x124271)]))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Divider()
                HStack() {
                    Button(action: {
                        self.selectedTab = 0
                    }) {
                        Text("Group Search")
                            .foregroundColor(.white)
                            .font(.title2)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(
                                LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(selectedTab == 0 ? 0.6 : 0.2), Color.blue.opacity(selectedTab == 0 ? 0.2 : 0.1)]),
                                startPoint: .top,
                                endPoint: .bottom
                                )
                            )
                    }
                    Button(action: {
                        self.selectedTab = 1
                    }) {
                        Text("Group Chat")
                            .foregroundColor(.white)
                            .font(.title2)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(
                                LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(selectedTab == 1 ? 0.6 : 0.2), Color.blue.opacity(selectedTab == 1 ? 0.2 : 0.1)]),
                                startPoint: .top,
                                endPoint: .bottom
                                )
                            )
                    }
                }
                .frame(maxHeight: 100)
                VStack {
                    if self.selectedTab == 0 {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .font(.title2)
                            TextField("Search Groups", text: $groupQuery)
                                .padding()
                                .font(.body)
                                .background(Color.white.opacity(0.75))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .frame(maxWidth: 300)
                        }
                        Button(action: {groupController.searchGroups(groupQuery: groupQuery)}) {
                            Text("Search")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .contentShape(Rectangle()) // Defines the tappable area shape
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("ABlue"), lineWidth: 2)
                        )
                        .frame(maxWidth: 100, maxHeight: 40) // Define the button's frame
                        .background(Color("ABlue"))
                        .cornerRadius(10)
                        .padding()
                        
                        ScrollView {
                            // populate with controller function
                            VStack {
                                ForEach(groupController.groupItemSearchArray) { groupItem in
                                    GroupItemSearch(groupController: groupController, groupData: groupItem)
                                }
                            }
                        }
                    } else {
                        ScrollView {
                            // populate with controller function
                        }
                    }
                }
                .padding(.top)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct MapView: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var mapController = MapController()
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 30.227173695531633, longitude: -97.75500147698011),
        span: .init(latitudeDelta: 0.08, longitudeDelta: 0.08)
    )
    @State var place: String = ""
    
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
            VStack {
                HStack {
                    Button {
                    } label: {
                        Label("", systemImage: "map.circle.fill")
                    }
                    .padding(.leading)
                    .font(.largeTitle)
                    .foregroundColor(Color("ABlue"))
                    
                    TextField("Search Places", text: $place)
                        .background(Color.white.opacity(0.85))
                        .cornerRadius(8)
                        .frame(maxWidth: 350)
                        .padding(.trailing, 15)
                        .font(.title3)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
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
                .frame(minHeight: 200, maxHeight: 550)
            }
            .onAppear {
                // fetch the posts
                if authController.currentUser != nil {
                    profileController.setCurrentUser(userID: authController.currentUser?.userID)
                    profileController.fetchPosts()
                } else {
                    // preview purposes
                }
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


