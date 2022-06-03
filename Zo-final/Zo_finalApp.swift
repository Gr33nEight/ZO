//
//  Zo_finalApp.swift
//  Zo-final
//
//  Created by Natanael Jop on 07/02/2022.
//

import SwiftUI
import Foundation

@main
struct ZoApp: App {
    

    @AppStorage("signUp") var signedUp = false
    @AppStorage("firstTime") var firstTime = true
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    @State var loggedIn = false
    
    @StateObject var dataController = DataController()
    
    init(){
        setAppTheme()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            if firstTime {
                WalkthroughDelegate(loggedIn: $loggedIn)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
            }else{
                if signedUp {
                    if loggedIn {
                        ContentView()
                            .environment(\.managedObjectContext, dataController.container.viewContext)
                            .environmentObject(dataController)
                    }else{
                        LogInView(loggedIn: $loggedIn)
                    }
                }else{
                    SingInView(loggedIn: $loggedIn)
                }
            }
        }
    }
    func setAppTheme(){
        //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: isDarkModeOn)
        //MARK: or use device theme
        if (colorScheme == .dark)
        {
            isDarkModeOn = true
        }
        else{
            isDarkModeOn = false
        }
        changeDarkMode(state: isDarkModeOn)
    }
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}

