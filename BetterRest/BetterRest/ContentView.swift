//
//  ContentView.swift
//  BetterRest
//
//  Created by anshul on 05/08/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeupTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeupTime:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Please enter the time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeAmount) cups", value: $coffeeAmount, in: 1...10)
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button("Calculate",action: calculateHours)
            }
            .alert(alertTitle,isPresented: $showAlert){
                Button("OK"){}
            }message: {
                Text(alertMessage)
            }
        }
    }
    func calculateHours(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0) * 60
            let pridiction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - pridiction.actualSleep
            
            alertTitle = "Your bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }
        catch{
            alertTitle = "Error"
            alertMessage = "There was a error in calculating your bedtime"
            }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
