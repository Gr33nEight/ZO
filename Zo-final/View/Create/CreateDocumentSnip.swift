//
//  CreateDocumentSnip.swift
//  Zo
//
//  Created by Natanael Jop on 31/01/2022.
//

import SwiftUI

struct CreateDocumentSnip: View {
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var scheme
    
    @State var text = ""
    
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    @State private var isImporting: Bool = false
    
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    @Environment(\.managedObjectContext) var moc
    
    @State var defaultsSnip: [Sniptest] = []
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("DocumentSnipBubble")
                    Spacer()
                }
                Spacer()
            }

            
            VStack{
                Spacer()
                Button {
                    isImporting = true
                } label: {
                    CustomCreateButton(text: "Upload Document", borderColor: scheme == .dark ? Color("CustomDarkGray") : Color("CustomGray") , contentColor: scheme == .dark ? Color("CustomDarkGray") : Color("CustomGray"))
                }.padding(.bottom, 5)

                CustomTextField(text: $text)
                Spacer()
                
                
                Button {
                    
                    let coreDataSnip = Snip(context: moc)
                    
                    coreDataSnip.name = text
                    coreDataSnip.color = "DocumentSnipColor"
                    coreDataSnip.image = "doc.fill"
                    coreDataSnip.content = document.message
                    
                    try? moc.save()
                    
                    updateDefaults()
                    
                    mode.wrappedValue.dismiss()
                    
                } label: {
                    CustomCreateButton(text: "CREATE SNIP", borderColor: scheme == .dark ? Color("CustomDarkGray") : .black , contentColor: scheme == .dark ?  Color("CustomDarkGray") : .white)
                }.padding(.bottom, 50)
                    .fileImporter(
                        isPresented: $isImporting,
                        allowedContentTypes: [.plainText],
                        allowsMultipleSelection: false
                    ) { result in
                        do {
                            guard let selectedFile: URL = try result.get().first else { return }
                            if (CFURLStartAccessingSecurityScopedResource(selectedFile as CFURL)) {
                                guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                                document.message = message
                                CFURLStopAccessingSecurityScopedResource(selectedFile as CFURL)
                            }
                            else {
                                print("Permission error!")
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }

            }.padding(.bottom, 50)
            
            
        }.overlay(
            HStack{
                Text("Document Snip")
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
    }
    func updateDefaults() {
        let snip = Sniptest(name: text, content: document.message, color: "DocumentSnipColor", image: "doc.fill", picked: Data())

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

struct CustomTextField: View {
    @Environment(\.colorScheme) var scheme
    @Binding var text: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(scheme == .dark ? Color("CustomDarkGray") : Color.white)
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? Color("CustomDarkGray") : Color.black)
            HStack{
                TextField("Snip Name...", text: $text)
                Spacer()
            }.padding()
            
        }
        .frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

struct CreateDocumentSnip_Previews: PreviewProvider {
    static var previews: some View {
        CreateDocumentSnip()
            .preferredColorScheme(.dark)
    }
}
