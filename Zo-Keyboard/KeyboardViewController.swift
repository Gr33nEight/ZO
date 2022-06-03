//
//  KeyboardViewController.swift
//  Zo-Keyboard
//
//  Created by Natanael Jop on 07/02/2022.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices
import MessageUI

class KeyboardViewController: UIInputViewController {

    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        var snip: [Sniptest] = []
        
        if let savedSnips = shareDefault.object(forKey: "snip") as? Data {
            let decoder = JSONDecoder()
            if let loadedSnip = try? decoder.decode([Sniptest].self, from: savedSnips) {
                snip = loadedSnip.uniqued()
            }
        }
        
        let child = UIHostingController(rootView: KeyboardView(snip: snip, printOut: { content in
            self.textDocumentProxy.insertText(content)
        }))
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.view.backgroundColor = .clear
        view.addSubview(child.view)
        addChild(child)
        

    }
}


struct KeyboardView: View {
    
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    @State private var isExporting: Bool = false
    
    var snip: [Sniptest]
    var printOut: (String) -> Void
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("Your Snips")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                }.padding()
                if snip.isEmpty {
                    Spacer()
                    Text("You don't have any snips yet.")
                        .bold()
                    Spacer()
                }else{
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 10){
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading) {
                                ForEach(snip, id: \.self){ snip in
                                    Button {
                                        if snip.image == "photo" {
                                            UIPasteboard.general.setData(snip.picked, forPasteboardType: UTType.png.identifier)
                                        }else if snip.image == "doc.fill" {
                                            if !MFMessageComposeViewController.canSendText() {
                                                
                                            }
                                        }else{
                                            printOut(snip.content)
                                        }
                                    } label: {
                                        HStack{
                                            Image(systemName: snip.image)
                                            Text(snip.name)
                                        }.padding()
                                        .foregroundColor(.white)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color(snip.color))
                                                .frame(height: 50)
                                        )
                                    }
                                }
                            }

                        }.padding()
                    }
                }
                Spacer()
            }
            Spacer()
        }.onAppear {
            print("👾👾👾👾👾👾👾👾👾")
            print(snip)
        }
    }
}

