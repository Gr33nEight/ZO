//
//  Walkthrough2.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct WalkthroughTwo: View {
    @Binding var isSkipped: Bool
    @AppStorage("firstTime") var firstTime = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("UpperBubble1")
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LowerBubble1")
                }
                
            }
            VStack{
                Spacer()
                VStack{
                    ZStack{
                        Image("WalkthroughTwoBackground")
                        ZStack(alignment: .top){
                            Image("WalkthroughTwoKeyboard")
                            ZStack{
                                Image("WalkthroughTwoBackground")
                                VStack(alignment: .leading){
                                    Image("YourSnips")
                                    Image("WalkthroughTwoContent")
                                }
                            }
                            
                        }
                    }.padding(.top, 50)
                    Text("Accessing Shortcuts.")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 80)
                        .padding(.bottom, 2)
                    Text("Activate Zo's keyboard so you can access the Shortcuts you create inside the app.")
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
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                        Circle()
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

struct Walkthrough2_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughTwo(isSkipped: .constant(false))
    }
}
