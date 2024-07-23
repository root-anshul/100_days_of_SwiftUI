//
//  ContentView.swift
//  WeSplit
//
//  Created by anshul on 22/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkamount = 0.0
    @State private var numberofpeople = 2
    @State private var tippercent = 10
    
    let tippercentage = [0,10,15,20,25]
    
    var totalPerPerson:Double{
        let totaltip:Double = checkamount * Double(tippercent)/100
        let totalamt:Double = checkamount+totaltip
        let perpersonamt:Double = totalamt / Double(numberofpeople+2)
        return perpersonamt
    }
    
    var totalAmount:Double{
        var grandTotal:Double = checkamount + (checkamount * Double(tippercent)/100)
        return  grandTotal
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amout", value: $checkamount, format: .currency(code: Locale.current.currency?.identifier ?? "INR") )
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people ",selection: $numberofpeople){
                        ForEach(2..<100){people in
                            Text("\(people) people")
                        }
                    }
                }
                NavigationStack{
                    Section("How much do you want to tip"){
                        Picker("Tip percentage",selection: $tippercent){
                            ForEach(0..<101){
                                Text($0, format: .percent)
                            }
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
                
                Section("Total Amount and tip percentage"){
                    Text(totalAmount,format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
            }
                .navigationTitle("WeSplit")
               
        }
    }
}

#Preview {
    ContentView()
}
