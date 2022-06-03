//
//  ProfileView.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var scheme
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
                    Spacer()
                    VStack{
                        CustomButton(text: "Edit Account", isLogout: false, isDarkModeToggle: false)
                        Button {
                            if scheme == .light {
                                changeDarkMode(state: true)
                            }else{
                                changeDarkMode(state: false)
                            }
                        } label: {
                            CustomButton(text: "Toggle Dark Mode", isLogout: false, isDarkModeToggle: true)
                        }

                    }
                    Spacer()
                    VStack{
                        CustomButton(text: "Terms & Agreements", isLogout: false, isDarkModeToggle: false)
                        CustomButton(text: "Privacy Policy", isLogout: false, isDarkModeToggle: false)
                    }
                    Spacer()
                    VStack{
                        CustomButton(text: "Contact Us", isLogout: false, isDarkModeToggle: false)
                        CustomButton(text: "Logout", isLogout: true, isDarkModeToggle: false)
                        
                    }
                    Spacer()
                }.padding(.top, 100)
            }.navigationTitle("Settings")
            .ignoresSafeArea()
            
        }
    }
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}


struct CustomButton: View {
    let text: String
    let isLogout: Bool
    let isDarkModeToggle: Bool
    
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(isLogout ? Color("CustomRed") : scheme == .dark ? Color(.gray) : Color(.white))
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? .white : .black)
                
            HStack{
                if isDarkModeToggle{
                    Image(systemName: "moon.circle.fill")
                }
                Text(text)
                    .bold()
            }.foregroundColor(isLogout ? .white : scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
