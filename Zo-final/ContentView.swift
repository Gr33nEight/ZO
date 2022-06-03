//
//  ContentView.swift
//  Zo-final
//
//  Created by Natanael Jop on 07/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bottomNavigationBarViewModel = BottomNavigationBarViewModel()
    @State var pickedView: TabView = .home
    var body: some View {
        VStack{
            switch(pickedView){
            case .home: AnyView(HomeView())
            case .add: AnyView(CreateView(bottomNavigationBarViewModel: bottomNavigationBarViewModel))
            case .settings: AnyView(SettingsView())
            }
            BottomTabBar(pickedView: $pickedView, bottomNavigationBarViewModel: bottomNavigationBarViewModel)
        }.ignoresSafeArea()
    }
}

struct BottomTabBar: View {
    
    @Binding var pickedView: TabView
    @Environment(\.colorScheme) var scheme
    
    @ObservedObject var bottomNavigationBarViewModel: BottomNavigationBarViewModel
    
    var body: some View {
        if bottomNavigationBarViewModel.showBottomBar {
            HStack{
                Spacer()
                Button {
                    withAnimation {
                        pickedView = .home
                    }
                } label: {
                    Image(systemName: "house.circle")
                        .foregroundColor(pickedView == .home ? scheme == .dark ? .white : .black : .gray)
                }
                Spacer()
                Button {
                    withAnimation {
                        pickedView = .add
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(pickedView == .add ? scheme == .dark ? .white : .black : .gray)
                }
                Spacer()
                Button {
                    withAnimation {
                        pickedView = .settings
                    }
                } label: {
                    Image(systemName: "gear.circle")
                        .foregroundColor(pickedView == .settings ? scheme == .dark ? .white : .black : .gray)
                }

                Spacer()
            }.font(.system(size: 27, weight: .bold))
                .frame(height: screenH/10)
        }else{
            
        }
    }
}

enum TabView{
    case home, add, settings
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
