//
//  WalkthroughDelegate.swift
//  Zo
//
//  Created by Natanael Jop on 29/01/2022.
//

import SwiftUI

struct WalkthroughDelegate: View {
    @Environment(\.colorScheme) var scheme
    @State var offsetOfFirstOne = CGSize.zero
    @State var offsetOfSecondOne = CGSize.zero
    @State var offsetOfThirdOne = CGSize.zero
    
    @State var isSkipped = false
    @State var isFinished = false
    
    @AppStorage("firstTime") var firstTime = true
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        ZStack{
            if isSkipped {
                SingInView(loggedIn: $loggedIn)
            }else{
                ZStack{
                    SingInView(loggedIn: $loggedIn)
                    WalkthroughThree(isSkipped: $isSkipped)
                        .background(scheme == .dark ? .black : .white)
                        .zIndex(1)
                        .offset(x: offsetOfThirdOne.width)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offsetOfThirdOne = gesture.translation
                                    if offsetOfThirdOne.width < 0 {
                                        offsetOfThirdOne.width = 0
                                    }
                            }
                                .onEnded({ _ in
                                    if offsetOfThirdOne.width > screenW/2 - 50 {
                                        withAnimation {
                                            offsetOfThirdOne.width = screenW
                                            isFinished = true
                                            firstTime = false
                                        }
                                    }else if offsetOfThirdOne.width < screenW {
                                        withAnimation {
                                            offsetOfSecondOne.width = 0
                                        }
                                    }
                                    else {
                                        withAnimation {
                                            offsetOfThirdOne.width = 0
                                        }
                                    }
                                })
                            
                        )
                        .disabled(isFinished)
                    WalkthroughTwo(isSkipped: $isSkipped)
                        .background(scheme == .dark ? .black : .white)
                        .zIndex(2)
                        .offset(x: offsetOfSecondOne.width)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offsetOfSecondOne = gesture.translation
                                    if offsetOfSecondOne.width < 0 {
                                        offsetOfSecondOne.width = 0
                                    }
                            }
                                .onEnded({ _ in
                                    if offsetOfSecondOne.width > screenW/2 - 50 {
                                        withAnimation {
                                            offsetOfSecondOne.width = screenW
                                        }
                                    }else if offsetOfSecondOne.width < screenW {
                                        withAnimation {
                                            offsetOfFirstOne.width = 0
                                        }
                                    }
                                    else {
                                        withAnimation {
                                            offsetOfSecondOne.width = 0
                                        }
                                    }
                                })
                            
                        )
                        .disabled(isFinished)
                    WalkthroughOne(isSkipped: $isSkipped)
                        .background(scheme == .dark ? .black : .white)
                        .offset(x: offsetOfFirstOne.width)
                        .zIndex(3)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offsetOfFirstOne = gesture.translation
                                    if offsetOfFirstOne.width < 0 {
                                        offsetOfFirstOne.width = 0
                                    }
                            }
                                .onEnded({ _ in
                                    if offsetOfFirstOne.width > screenW/2 - 50 {
                                        withAnimation {
                                            offsetOfFirstOne.width = screenW
                                        }
                                    }else {
                                        withAnimation {
                                            offsetOfFirstOne.width = 0
                                        }
                                    }
                                })
                            
                        )
                        .disabled(isFinished)
                       
                }
            }
        }
    }
}

//struct WalkthroughDelegate_Previews: PreviewProvider {
//    static var previews: some View {
//        WalkthroughDelegate()
//            .preferredColorScheme(.light)
//    }
//}
