//
//  ContentView.swift
//  Conversion of unit
//
//  Created by anshul on 25/07/24.
//

import SwiftUI

extension UnitTemperature:CaseIterable{
    public static var allCases: [UnitTemperature]{
        return [.celsius,.fahrenheit,.kelvin]
    }
}

func UnitTemperatureDescription(_ unit: UnitTemperature) -> String {
    return unit.symbol
}

struct ContentView: View {
    @State private var input = "0.0"
    
    @State private var inputUnit:UnitTemperature = .celsius
    @State private var outputUnit:UnitTemperature = .kelvin
    
    let units = UnitTemperature.allCases
    
    var output:Double{
        guard let input = Double(input) else {return 0}
        var output = Measurement(value: input, unit: inputUnit)
        return output.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("From") ){
                    TextField("Value", text: $input)
                        .keyboardType(.decimalPad)
                    
                    Picker("Select", selection: $inputUnit){
                        ForEach(units,id:\.self){unit in
                            Text("\(UnitTemperatureDescription(unit))")
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                Section(header: Text("To")) {
                    Picker("To", selection: $outputUnit){
                        ForEach(units,id:\.self){unit in
                            Text("\(UnitTemperatureDescription(unit))")
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("\(output, specifier: "%.2f")")
                    
                  
                }
            }
            .navigationTitle("Unit Conversion")
        }
    }
}

#Preview {
    ContentView()
}
