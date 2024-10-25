//
//  ContentView.swift
//  practice
//
//  Created by anshul on 05/08/24.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}


extension View{
    func watermarked(with text:String)-> some View{
       modifier(Watermark(text: text))
    }
}



struct ContentView: View {
    var body: some View {
        VStack{
            Color.blue
                //.frame(width: 3000,height: 200)
                .watermarked(with: "Anshul Tanwar")
        }
    }
}

#Preview {
    ContentView()
}
