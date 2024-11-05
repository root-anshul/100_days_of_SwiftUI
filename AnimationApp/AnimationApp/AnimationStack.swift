//
//  AnimationStack.swift
//  AnimationApp
//
//  Created by anshul on 03/11/24.
//

import SwiftUI

struct AnimationStack: View {
    @State private var change = true
    var body: some View {
        Button("Tap me"){
            change.toggle()
        }
        .padding()
        .frame(width: 200,height: 200)
        .background(change ? Color.red:Color.blue)
        .foregroundStyle(Color.white)
        .animation(.default, value: change)
        .clipShape(.rect(cornerRadius: change ? 0 : 60))
        .animation(.spring(duration: 1,bounce: 0.9), value: change)
        
    }
}

#Preview {
    AnimationStack()
}
