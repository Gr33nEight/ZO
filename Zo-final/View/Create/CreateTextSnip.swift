//
//  CreateTextSnip.swift
//  Zo
//
//  Created by Natanael Jop on 31/01/2022.
//

import SwiftUI

struct CreateTextSnip: View {
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var scheme
        
    @State var text = ""
    @State var content = ""
    @ObservedObject var bottomNavigationBarViewModel: BottomNavigationBarViewModel
    
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    @Environment(\.managedObjectContext) var moc
    
    @State var defaultsSnip: [Sniptest] = []
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("TextSnipBubble")
                    Spacer()
                }
                Spacer()
            }

            
            VStack{
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(scheme == .dark ? Color("CustomDarkGray") : Color.white)
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 3)
                        .fill(scheme == .dark ? Color("CustomDarkGray") : Color.black)
                    HStack{
                        TextEditor(text: $content)
                            
                        Spacer()
                    }.padding()
                        .onAppear {
                            UITextView.appearance().backgroundColor = .clear
                        }
                    
                }.frame(height: 200)

                .padding(.horizontal, 30)
                    .padding(.bottom)

                CustomTextField(text: $text)
                Spacer()
                
                
                Button {
                    
                    let coreDataSnip = Snip(context: moc)
                    
                    coreDataSnip.name = text
                    coreDataSnip.color = "TextSnipColor"
                    coreDataSnip.image = "doc.text.image"
                    coreDataSnip.content = content
                    
                    try? moc.save()
                    
                    updateDefaults()
                    
                    mode.wrappedValue.dismiss()
                    
                } label: {
                    CustomCreateButton(text: "CREATE SNIP", borderColor: scheme == .dark ? Color("CustomDarkGray") : .black , contentColor: scheme == .dark ?  Color("CustomDarkGray") : .white)
                }.padding(.bottom, 50)

            }.padding(.bottom, 50)
            
            
        }.overlay(
            HStack{
                Text("Text Snip")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image("CancelButton")
                }.padding(.trailing, 40)
            }
                .padding(.top, 80)
            , alignment: .topTrailing
        ).navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .onAppear {
            bottomNavigationBarViewModel.showBottomBar = false
        }
        .onDisappear {
            withAnimation {
                bottomNavigationBarViewModel.showBottomBar = true
            }
        }
    }
    func update() {
        for snip in snips {
            let defaultSnip = Sniptest(name: snip.name ?? "", content: snip.content ?? "", color: snip.color ?? "", image: snip.image ?? "", picked: snip.pickedimage ?? Data())
            defaultsSnip.append(defaultSnip)
        
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(defaultsSnip) {
                shareDefault.set(encoded, forKey: "snip")
            }
            
            print(defaultsSnip)
            
        }
    }
    func updateDefaults() {
        let snip = Sniptest(name: text, content: content, color: "TextSnipColor", image: "doc.text.image", picked: Data())

        if let savedSnips = shareDefault.object(forKey: "snip") as? Data {
            let decoder = JSONDecoder()
            if let loadedSnip = try? decoder.decode([Sniptest].self, from: savedSnips) {
                for i in loadedSnip {
                    defaultsSnip.append(i)
                }
                defaultsSnip.append(snip)
            }
        }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(defaultsSnip) {
            shareDefault.set(encoded, forKey: "snip")
        }
    }
}

//struct CreateTextSnip_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTextSnip()
//    }
//}


