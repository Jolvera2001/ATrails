//
//  UtilityViews.swift
//  ATrails
//
//  Created by Turing on 11/26/23.
//

import SwiftUI
import UIKit


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
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var posterController = PosterController()
    
    @State private var textString: String = ""
    @State var selectedImage: UIImage? = nil
    @State var selectedImageURL: URL?
    @State private var isImagePickerPresented = false
    @State private var messagePrompt = ""
    
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
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                        .font(.title2)
                        
                        Text("Create a Post")
                            .font(.title2)
                            .frame(alignment: .leading)
                            .padding()
                        
                        Button {
                            // do the post things then dismiss
                            // this has a completion handler so it will run the dismiss() whenever it finishes
                            // the only scary part of it doesn't do it correctly.
                            // Will it still finish or crash?
                            if (textString != "") {
                                if selectedImage == nil {
                                    posterController.createPost(currentUser: authController.currentUser!, postText: textString) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    posterController.createPost(currentUser: authController.currentUser!, postText: textString, image: selectedImageURL!) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                }
                            } else {
                                messagePrompt = "You can't make an empty post"
                            }
                        } label: {
                            Text("Post")
                        }
                        .font(.title2)
                        .padding(10)
                    }
                    ScrollView {
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
                        
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(width: 350, height: 200)
                                .cornerRadius(5)
                                .padding(.top, 10)
                        } else {
                            // nothing...
                        }
                        
                        TextField("Share something on ATrails...", text: $textString, axis: .vertical)
                            .padding()
                            .font(.title3)
                            .background(Color.white.opacity(0.15))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .lineLimit(6, reservesSpace: true)
                        Text("\(messagePrompt)")
                            .font(.title2)
                            .foregroundColor(.pink)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                
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
                            isImagePickerPresented.toggle()
                        } label: {
                            VStack {
                                Label("", systemImage: "photo.fill.on.rectangle.fill")
                                Text("Gallery")
                            }
                        }
                        .font(.title2)
                        .padding(10)
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImage: $selectedImage, selectedImageURL: $selectedImageURL)
                        }
                        
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
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfileOptions: View {
    @EnvironmentObject var authController: AuthController
    @Environment(\.presentationMode) var presentationMode
    
    @State var isButtonTapped = false
    
    var body: some View {
        ZStack {
            Rectangle()
            // Use the color gradient extension
                .fill(Color.gradient(colors: [Color(hex: 0x7BB4E3), Color(hex: 0x99E7F8)]))
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 15) {
                HStack {
                    Button(action:{ presentationMode.wrappedValue.dismiss() }) {
                        Text("<- Back")
                    }
                    .foregroundColor(.white)
                    Text("Profile Options")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Button(action:{ isButtonTapped.toggle() }) {
                        Image(systemName: "person.circle.fill").font(.title)
                        Text("Edit Profile")
                    }
                    .foregroundColor(.indigo)
                    .fullScreenCover(isPresented: $isButtonTapped) {
                        NavigationView {
                            DevView()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 60)
                Divider().frame(maxWidth: 300)
                HStack {
                    Button(action: { isButtonTapped.toggle() }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill").font(.title)
                        Text("Log Out")
                    }
                    .foregroundColor(.indigo)
                    .fullScreenCover(isPresented: $isButtonTapped) {
                        NavigationView {
                            DevView()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 60)
                Divider().frame(maxWidth: 300)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

// *********************** HELPER METHODS ****************************************************

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedImageURL: URL?
    @Environment(\.presentationMode) private var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = pickedImage
                
                if let imageData = pickedImage.jpegData(compressionQuality: 1.0) {
                    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("pickedImage.jpg")
                    do {
                        try imageData.write(to: tempURL)
                        parent.selectedImageURL = tempURL
                    } catch {
                        print("Error writing image data: \(error.localizedDescription)")
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
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

struct ProfileOptions_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOptions().environmentObject(AuthController())
    }
}
