//
//  SingUpView.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI
import AuthenticationServices

struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else { return nil }
        
        self.userId = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}


struct SingInView: View {
    @Environment(\.colorScheme) var scheme
    @AppStorage("signUp") var signedUp = false
    @Binding var loggedIn: Bool
    
    var body: some View {
        ZStack{
            HStack{
                VStack{
                    Spacer()
                    Image("LeftBubble")
                        .padding(.bottom, 200)
                }
                Spacer()
                VStack{
                    Image("RightBubble")
                        .padding(.top, 120)
                    Spacer()
                }
                            
            }
            
            VStack(alignment: .leading){
                Text("Create your account.")
                    .font(.system(size: 30, weight: .bold))
                Text("Start creating your own Ships once you successfully sign up")
                HStack{
                    Spacer()
                    SignInWithAppleButton(.signUp,
                                          onRequest: configure,
                                          onCompletion: handle)
                        .signInWithAppleButtonStyle(
                            scheme == .dark ? .white : .black
                        )
                        .frame(height: 45)
                    .padding()
                    .padding(.top, 30)
                    Spacer()
                }
            }.padding(30)
                .padding(.bottom, 70)
        
        }.overlay(alignment: .topLeading, content: {
            Logo()
                .padding(40)
        })
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }
    func configure(_ request: ASAuthorizationAppleIDRequest) {
            request.requestedScopes = [.fullName, .email]
    //        request.nonce = ""
        }
        
        func handle(_ authResult: Result<ASAuthorization, Error>) {
            switch authResult {
            case .success(let auth):
                signedUp = true
                loggedIn = true
                switch auth.credential {
                case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                    if let appleUser = AppleUser(credentials: appleIdCredentials),
                       let appleUserData = try? JSONEncoder().encode(appleUser) {
                        UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                        
                    } else {
                        guard
                            let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                            let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                        else { return }
                    }
                    
                default:
                    print(auth.credential)
                }
                
            case .failure(let error):
                print(error)
            }
        }
}
//
//struct SingUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingUpView()
//            .preferredColorScheme(.dark)
//    }
//}
