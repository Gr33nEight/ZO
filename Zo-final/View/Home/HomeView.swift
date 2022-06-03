//
//  HomeView.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct HomeView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var longPressed = false
    @State var startAnimation = false
    
    var animation: Animation {
        Animation
            .default
            .speed(5)
    }
    
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    
    @State var defaultsSnipsArray: [Sniptest] = []
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("HomeBubble")
                        Spacer()
                    }
                    Spacer()
                } .ignoresSafeArea()
                
                
                if snips.isEmpty {
                    HStack{
                        Image("homeEmpty")
                            .onAppear {
                                longPressed = false
                                startAnimation = false
                            }
                            .padding(.bottom, 150)
                    }
                }else{
                    
                    ScrollView{
                        VStack{
                            LazyVGrid(columns: columns){
                                ForEach(snips){ snip in
                                    if longPressed {
                                        CustomGridCell(snip: snip, longPressed: $longPressed)
                                            .rotationEffect(Angle.degrees(startAnimation ? 2 : 0))
                                            .rotationEffect(Angle.degrees(longPressed ? -1 : 0))
                                        
                                    }else{
                                        CustomGridCell(snip: snip, longPressed: $longPressed)
                                            .onTapGesture {  }
                                            .simultaneousGesture(
                                                LongPressGesture(minimumDuration: 1)
                                                    .onEnded { _ in
                                                        longPressed = true
                                                        withAnimation(animation.repeat(while: longPressed)){
                                                            startAnimation = true
                                                        }
                                                    }
                                            )
                                    }
                                }
                                
                            }
                        }.padding()
                            .padding(.horizontal, 25)
                        
                    }
                    
                }
            }.navigationTitle("Home")
            
        }.onTapGesture {
            longPressed = false
            startAnimation = false
                
        }
        .onAppear(perform: {
            update()
        })
        
    }
    func update() {
        for snip in snips {
            let defaultSnip = Sniptest(name: snip.name ?? "", content: snip.content ?? "", color: snip.color ?? "", image: snip.image ?? "", picked: snip.pickedimage ?? Data())
            defaultsSnipsArray.append(defaultSnip)
        
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(defaultsSnipsArray) {
                shareDefault.set(encoded, forKey: "snip")
            }
        }
    }
}

struct CustomGridCell: View {
    let snip: Snip
    @Binding var longPressed: Bool
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(snip.color ?? ""))
                .frame(width: 160, height: 160)
            VStack{
                Image(systemName: snip.image ?? "")
                    .font(.system(size: 35, weight: .bold))
                Text(snip.name ?? "")
                    .font(.system(size: 15, weight: .bold))
                    .padding(.top, 15)
                
            }.foregroundColor(.white)
            
        }.overlay(
            
            ZStack{
                if longPressed {
                    Button(action: {
                        moc.delete(snip)
                        try? moc.save()
                    }, label: {
                        ZStack{
                            Circle()
                                .fill(.red)
                                .frame(width: 30, height: 30)
                        }
                    })
                    Image(systemName: "minus")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                }
            }.offset(x: 5, y: -10)
            , alignment: .topTrailing
            
        )
    }
}

