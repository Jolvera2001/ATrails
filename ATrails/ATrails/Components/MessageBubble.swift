//
//  MessageBubble.swift
//  ATrails
//
//  Created by Turing on 11/10/23.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    
    @State private var showTime = false
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        VStack( alignment: message.userID != authController.currentUser?.userID ? .leading : .trailing) {
            HStack {
                Text(message.messageText)
                    .padding(13)
                    .background(message.userID != authController.currentUser?.userID ? Color.gray : Color("ALightBlue"))
                    .cornerRadius(20)
                
            }
            .frame(maxWidth: 300, alignment: message.userID != authController.currentUser?.userID ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.messageTimestamp.formatted(.dateTime.hour().minute()))")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(message.userID != authController.currentUser?.userID ? .trailing : .leading, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.userID != authController.currentUser?.userID ? .leading : .trailing)
        .padding(.trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        let authController = AuthController()
        authController.currentUser = User(userID: "admin", fullname: "", username: "", password: "", email: "", followers: [], following: [])
        
       return VStack{
            MessageBubble(message: Message(userID: "admin", messageText: "Hello I am the admin. I should be on the right", messageTimestamp: Date())).environmentObject(authController)
           MessageBubble(message: Message(userID: "notAdmin", messageText: "Hello I am not the admin", messageTimestamp: Date())).environmentObject(authController)
        }
    }
}
