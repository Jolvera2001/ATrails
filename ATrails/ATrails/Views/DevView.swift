//
//  DevView.swift
//  ATrails
//
//  Created by Turing on 12/4/23.
//

import SwiftUI

struct DevView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x7BB4E3), Color(hex: 0x99E7F8)]))
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                Button(action:{ presentationMode.wrappedValue.dismiss() }) {
                    Text("<- Back")
                }
                .foregroundColor(.white)
                
                Image("ATrails-logos_white")
                Text("Hey!")
                    .font(.title)
                    .foregroundColor(.white)
                Text("If you're seeing this, this is NOT implemened yet. This app may or may not continue but either way, there's a lot already implemented")
                    .padding(.horizontal, 45)
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
    }
}

struct DevView_Previews: PreviewProvider {
    static var previews: some View {
        DevView()
    }
}
