//
//  Logo.swift
//  Zo
//
//  Created by Brian Heralall on 1/29/22.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        ZStack{
            Image("Zwhite")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .opacity(0.99)
            Image("Zblack")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .offset(x: 5)
        }
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
