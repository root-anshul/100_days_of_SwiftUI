//
//  ContentView.swift
//  edutainment
//
//  Created by anshul on 04/11/24.
//

import SwiftUI
//import UIKit

struct ContentView: View {
    init() {
     // Large Navigation Title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
     // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
   }
    
    @State private var answer = ""
    @State private var animateIcon = false
    @State private var ispresented = false
    @State private var animationAmount = 0.0
    @State private var number = Int.random(in:0..<15)
    @State private var question = 5
    @State private var score = 0
    
    @State private var alert = ""
    @State private var alertTitle = ""
    @State private var restartGame = false
    @State private var questionalert = false
    @State private var noToMultiply = 2
    @State private var icons = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat","gorilla", "hippo", "horse", "monkey", "moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra"].shuffled()

    let questions = [5,10,20]
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.black,.pink], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack {
                        Text("Score = \(score)")
                            .font(.title)
                            .bold()
                        Text("Choose the table from 2 to 12")
                            .font(.title3)
                        Stepper("\(noToMultiply)", value: $noToMultiply, in: 2...12,step: 1)
                            .frame(maxWidth: 150)
                       
                        Picker("", selection: $question) {
                            
                            ForEach(questions,id:\.self){ques in
                                Text("\(ques)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: 150)
                    }
                    .frame(width:375)
                    .padding(.vertical, 25)
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 20))
                    Spacer()
                    Spacer()
                    
                    Image(icons[number])
                        .rotation3DEffect(.degrees(animateIcon ? animationAmount : 0.0),axis: (x: 0.0, y: 1.0, z: 0.0))
                        .animation(.default, value: animateIcon)
                   
                 Text("Questions remaining = \(question)")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    
                    VStack(spacing:15){
                        Text("What is \(noToMultiply) x \(number)")
                            .foregroundStyle(Color.white)
                            .bold()
                            .font(.title2)
                        
                        HStack {
                            TextField("Enter your answer", text: $answer)
                                .padding(.leading,10)
                                .frame(width: 200,height: 40)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                                .alert(alertTitle, isPresented: $ispresented) {
                                    Button("OK", role: .cancel) { }
                                    
                                }message:{
                                    Text("\(alert)")
                                }
                            
                                .alert(alertTitle, isPresented: $questionalert) {
                                    Button("Ok", role: .cancel) { }
                                    
                                }message:{
                                    Text("\(alert)")
                                        .font(.title2)
                                }
                            
                                .alert(isPresented:$restartGame) {
                                         Alert(
                                             title: Text("Are you sure you want to restart game?"),
                                             primaryButton: .destructive(Text("Yes")) {
                                                 startOver()
                                             },
                                             secondaryButton: .cancel()
                                         )
                                     }
                                
                                    
                            Button{
                                checktextfield()
                                checkAns()
                                number = Int.random(in:0..<15)
                                answer = ""
                                if(question == 0){
                                    alert = "You have answered all the question"
                                    questionalert.toggle()
                                    startOver()
                                }
                                    }
                                    label:{
                                        Image(systemName: "chevron.right.circle.fill")
                                            .font(.title)
                                            .background(
                                                Color.white
                                                    .clipShape(Circle())
                                            )
                                            .foregroundStyle(Color.green)
                                            .padding(.leading,10)
                                    }
                                } .padding(.leading,60)
                            
                        }
                        Button{
                            restartGame.toggle()
                           
                        }
                        label:{
                            Text("Play again")
                                .foregroundStyle(Color.white)
                                .font(.title2)
                                .frame(width: 125,height: 50)
                                .background(Color.green)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(10)
                        
                        Spacer()
                        
                    }
                    
                    
                }
                .navigationBarTitle(Text("Edutainment"))
                
                
            }
        }
    
    func checkAns(){
        question -= 1
        
       let ans = noToMultiply*number
        if(ans == Int(answer)){
            score += 1
        }else{
            score -= 1
            
        }
        if(score < 0){
            score = 0
        }
    }
    func startOver(){
        score = 0
        noToMultiply = 2
        question = 5
    }
    
    func askquestions(){
        if count < question{
//            number = Int.random(in:0..<15)
            count += 1
        }else{
            startOver()
        }
    }
    
    func checktextfield(){
        if(answer == ""){
            alertTitle = "No answer found"
            alert = "Please enter your answer"
            ispresented.toggle()
            return
        }
    }

}

#Preview {
    ContentView()
}
