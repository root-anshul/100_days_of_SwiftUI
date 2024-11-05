//
//  showingandhiding.swift
//  AnimationApp
//
//  Created by anshul on 04/11/24.
//

import SwiftUI

struct showingandhiding: View {
    @State private var isShow = true
    var body: some View {
        VStack{
            Button("Tap me"){
                withAnimation {
                    isShow.toggle()
                }
              
            }
            if isShow {
                Rectangle()
                    .frame(width: 300,height: 300)
                    .foregroundStyle(Color.red)
                    .transition(.symbolEffect)
                  
            }
        }
    }
}

#Preview {
    showingandhiding()
}
