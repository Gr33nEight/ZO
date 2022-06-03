//
//  CreateView.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct CreateView: View {
    @State var show = false
    @ObservedObject var bottomNavigationBarViewModel: BottomNavigationBarViewModel
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("CreateSnipBubble")
                        Spacer()
                    }
                    Spacer()
                }
                VStack{
                    HStack{
                        NavigationLink {
                            CreateTextSnip(bottomNavigationBarViewModel: bottomNavigationBarViewModel)
                        } label: {
                            CreateViewCell(image: "doc.text.image", color: "TextSnipColor", name: "Text Shortcut")
                        }

                        NavigationLink {
                            CreateURLSnip()
                        } label: {
                            CreateViewCell(image: "paperclip", color: "URLSnipColor", name: "URL Shortcut")
                        }
                    }
                    HStack{
                        NavigationLink {
                            CreatePhotoSnip()
                        } label: {
                            CreateViewCell(image: "photo", color: "ImageSnipColor", name: "Photo Shortcut")
                        }
                        NavigationLink {
                            CreateDocumentSnip()
                        } label: {
                            CreateViewCell(image: "doc.fill", color: "DocumentSnipColor", name: "Document Shortcut")
                        }

                    }
                    Text("Choose the type of Snip you want to create. You can will be able to access your Snips right from Snip Keyboard")
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 35)
                }.padding(.bottom, 50)
            }.navigationTitle("Create Snip")
            .ignoresSafeArea()
            
        }
    }
}

struct CustomCreateButton: View {
    let text: String
    let borderColor: Color
    let contentColor: Color
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(contentColor)
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(borderColor)
                
            HStack{
                Text(text)
                    .bold()
            }.foregroundColor(scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

struct CreateViewCell: View {
    let image: String
    let color: String
    let name: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(color))
                .frame(width: 160, height: 160)
            VStack{
                Image(systemName: image)
                    .font(.system(size: 35, weight: .bold))
                Text(name)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.top, 15)
                
            }.foregroundColor(.white)
            
        }
    }
}
