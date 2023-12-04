//
//  ContentView.swift
//  ATrails
//
//  Created by Turing on 11/10/23.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var authController: AuthController
    @State private var isRegistered = false
    @State private var isLogged = false
    
    var body: some View {
        NavigationStack() {
            ZStack() {
                Rectangle()
                // Use the color gradient extension
                    .fill(Color.gradient(colors: [Color(hex: 0x539DE2), Color(hex: 0x124271)]))
                // Fill the entire view, ignoring safe areas
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Image("ATrails-logos_white")
                        .frame(maxWidth: .infinity)
                    Text("Welcome To ATrails")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity)
                    Spacer().frame(height: 160)
                    Text("Get Started By Logging In Or Registering Below")
                        .padding()
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: RegistrationView(isRegistered: $isRegistered)) {
                        Text("Register")
                            .frame(width: 350, height: 60)
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .background(Color("ABlue"))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                    .padding(2)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    
                    NavigationLink(destination: LoginView(isLogged: $isLogged)) {
                        Text("I already have an account!")
                            .frame(width: 350, height: 60)
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .background(Color("ALightBlue"))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    NavigationLink(destination: TabBarView(),
                                   isActive: Binding<Bool>(get: {isLogged || isRegistered}, set: { _ in })) {
                        
                    }
                }
            }
        }
    }
}

struct RegistrationView: View {
    @State private var user = User(userID: "", fullname: "", username: "", password: "", email: "", profileBio: "Something", followers: [], following: [])
    @Binding var isRegistered: Bool
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        ZStack() {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x539DE2), Color(hex: 0x124271)]))
            // Fill the entire view, ignoring safe areas
                .edgesIgnoringSafeArea(.all)
            VStack() {
                VStack {
                    Text("Register")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                    
                    TextField("Full Name", text: $user.fullname)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    TextField("Username", text: $user.username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    TextField("Email", text: $user.email)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    SecureField("Password", text: $user.password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    Spacer().frame(height: 50)
                    
                    Button(action: {
                        authController.register(user: user) {
                            error in
                            if let error = error {
                                print("Registration failed: \(error.localizedDescription)")
                            } else {
                                print("Registration successful!")
                                isRegistered = true
                                authController.currentUser = user
                            }
                        }
                    }) {
                        Text("Submit")
                            .frame(width: 350, height: 60)
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .background(Color("ABlue"))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                    .padding(2)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    
                }
            }
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var authController: AuthController
    
    @State private var username = ""
    @State private var password = ""
    @Binding var isLogged: Bool
    
    var body: some View {
        ZStack() {
            Rectangle()
                // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x539DE2), Color(hex: 0x124271)]))
                // Fill the entire view, ignoring safe areas
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                Text("Login")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                
                Spacer().frame(height: 50)
                
                Button(action: {
                    authController.login(username: username, password: password) {
                        success in
                        if success {
                            isLogged = true
                        } else {
                            print("Login was not successful")
                        }
                    }
                }) {
                    Text("Submit")
                        .frame(width: 350, height: 60)
                        .font(.title2)
                }
                .foregroundColor(.white)
                .background(Color("ABlue"))
                .cornerRadius(5)
                .frame(maxWidth: .infinity)
                .padding(2)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                
                Spacer().frame(height: 110)
            }
        }
    }
}


// ********************** VIEW PREVIEWS ***************************


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    IntroView()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a State variable to simulate the binding
        struct IsRegisteredHolder: View {
            @State private var isRegistered = false
            var body: some View {
                RegistrationView(isRegistered: $isRegistered)
            }
        }
        // Use the container view in the preview
        return IsRegisteredHolder()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        struct isLoggedHolder: View {
            @State private var isLogged = false
            var body: some View {
                LoginView(isLogged: $isLogged)
            }
        }
        return isLoggedHolder()
    }
}



// ************************ HELPERS *****************************


extension Color {
    static func gradient(colors: [Color]) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double(hex & 0xff) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
