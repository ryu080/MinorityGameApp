//
//  CreatePlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct CreatePlayerView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @Environment(\.dismiss) private var dismiss
    //imageに変更
    @State var imageData:Data? = nil
    @State var source: UIImagePickerController.SourceType = .photoLibrary

    @State var isActionSheet = false
    @State var isImagePicker = false
    @State var name:String = ""
    @State var nameLimitBool = false
    @State var personImageCount = 0
    @State var personImage:String?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack{
                    if let imageData = imageData, let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 300,height: 400)
                            .cornerRadius(20)
                    }else{
                        Rectangle()
                            .frame(width: 300,height: 400)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.mint, lineWidth: 3)
                            )
                        Text("No image")
                    }
                    HStack {
                        Button {
                            self.source = .camera
                            self.isImagePicker.toggle()
                        } label: {
                            Image(systemName: "camera.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .frame(width: 50,height: 50)
                        .background(.mint.opacity(0.8))
                        .clipShape(Circle())                        .overlay(
                            Circle()
                                .stroke(Color.mint, lineWidth: 3)
                        )
                        Spacer()
                        Button {
                            switch personImageCount {
                            case 0: personImage = PersonImages.dog.rawValue
                                personImageCount += 1
                            case 1:personImage = PersonImages.cat.rawValue
                                personImageCount += 1
                            case 2:personImage = PersonImages.man.rawValue
                                personImageCount += 1
                            case 3:personImage = PersonImages.woman.rawValue
                                personImageCount += 1
                            default: personImageCount = 0
                            }
                            imageData = UIImage(imageLiteralResourceName:personImage!).pngData()
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(width: 50,height: 50)
                        .background(.mint.opacity(0.8))
                        .clipShape(Circle())                        .overlay(
                            Circle()
                                .stroke(Color.mint, lineWidth: 3)
                        )
                        Spacer()
                        Button {
                            self.source = .photoLibrary
                            self.isImagePicker.toggle()
                        } label: {
                            Image(systemName: "photo.artframe")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .frame(width: 50,height: 50)
                        .background(.mint.opacity(0.8))
                        .clipShape(Circle())                        .overlay(
                            Circle()
                                .stroke(Color.mint, lineWidth: 3)
                        )
                    }
                    .padding()
                    .frame(width: 300,height: 400,alignment: .bottom)
                }
                Spacer()
                HStack {
                    Spacer()
                    TextField("プレイヤー名（8文字以内）", text: $name){
                        nameLimitBool = false
                    }
                        .font(.title2)
                        .padding(5)
                        .background(.white)
                        .cornerRadius(5)
                        .bold()
                        .frame(width: 300)
                    Spacer()
                }
                if nameLimitBool{
                    Text("８文字以内で入力してください")
                        .font(.title3)
                        .frame(width: 300,height: 50,alignment: .topTrailing)
                        .foregroundColor(Color.bittersweet)
                        .fontWeight(.black)
                }else{
                    Rectangle()
                    .frame(width: 300,height: 50)
                    .foregroundColor(.clear)
                }
                Button {
                    if 0 < name.count && name.count <= 8 {
                        gameViewModel.createUser(name: self.name,imageData: self.imageData)
                        name = ""
                        dismiss()
                    } else {
                        nameLimitBool = true
                    }
                } label: {
                    Text("追加")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }
                .frame(width: 300,height: 50)
                .background(.blue.opacity(0.8))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 3)
                )
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isImagePicker){
            ImagePickerView(show: $isImagePicker, image: $imageData, sourceType: source)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    CreatePlayerView()
        .environmentObject(GameViewModel())
        .environmentObject(AlertViewModel())
}
