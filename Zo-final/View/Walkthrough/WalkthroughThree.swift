//
//  WalkthroughThree.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct WalkthroughThree: View {
    @Binding var isSkipped: Bool
    @AppStorage("firstTime") var firstTime = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("UpperBubble2")
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LowerBubble2")
                }
                
            }
            VStack{
                Spacer()
                VStack{
                    Image("Phone")
                    Text("Using Shortcuts")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top)
                        .padding(.bottom, 2)
                    Text("Paste the content attached to a specific Shortcut, by tapping on it from the keyboard.")
                        .underline()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                Spacer()
                VStack{
                    Button {
                        withAnimation {
                            isSkipped = true
                            firstTime = false
                        }
                    } label: {
                        Image("CompleteBtn")
                    }

                    HStack(spacing: 10){
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                        Circle()
                            
                            .frame(width: 15, height: 15)
                    }.padding(.top, 30)
                }.padding(.bottom, 50)
            }
            
            
                
        }.ignoresSafeArea()
    }
}

struct WalkthroughThree_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughThree(isSkipped: .constant(false))
    }
}
