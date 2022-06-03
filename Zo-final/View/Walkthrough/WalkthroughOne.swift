//
//  WalkthroughOne.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct WalkthroughOne: View {
    @Binding var isSkipped: Bool
    @AppStorage("firstTime") var firstTime = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("UpperBubble")
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LowerBubble")
                }
                
            }
            VStack{
                Spacer()
                VStack{
                    HStack{
                        Image("Snip-4")
                        Image("Snip-1")
                    }
                    HStack{
                        Image("Snip-2")
                        Image("Snip-3")
                    }

                    Text("Create Shortcuts.")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 80)
                        .padding(.bottom, 2)
                    Text("Constantly sharing the same pictures, text, phrases, files or links? Create a Snip")
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
                        Image("SkipBtn")
                    }

                    HStack(spacing: 10){
                        Circle()
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                    }.padding(.top, 30)
                }.padding(.bottom, 50)
            }
            
            
                
        }.ignoresSafeArea()
    }
}

//struct WalkthroughOne_Previews: PreviewProvider {
//    static var previews: some View {
//        WalkthroughOne()
//    }
//}
