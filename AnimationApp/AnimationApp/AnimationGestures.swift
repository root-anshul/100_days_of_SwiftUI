//
//  AnimationGestures.swift
//  AnimationApp
//
//  Created by anshul on 03/11/24.
//

import SwiftUI

struct AnimationGestures: View {
    
    let letter = Array("Hello SwiftUI")
    @State private var dragAmount = CGSize.zero
    @State private var enable = false
    
    var body: some View {
//        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300,height: 200)
//            .clipShape(.rect(cornerRadius: 20))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged{dragAmount = $0.translation}
//                    .onEnded{ _ in dragAmount = .zero}
//            )
//            .animation(.bouncy)
        HStack(spacing:0){
            ForEach(0..<letter.count, id:\.self){num in
                Text(String(letter[num]))
                    .padding(5)
                    .font(.title)
                    .background(enable ? .red:.blue)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num)/20), value: dragAmount)
            }
        }
        .gesture(DragGesture()
            .onChanged{dragAmount = $0.translation}
            .onEnded{_ in dragAmount = .zero
                enable.toggle()
            }
        )
       
        
    }
}

#Preview {
    AnimationGestures()
}
