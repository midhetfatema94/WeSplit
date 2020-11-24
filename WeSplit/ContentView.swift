//
//  ContentView.swift
//  WeSplit
//
//  Created by Waveline Media on 11/4/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentageIndex = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var amount: Double {
        return Double(checkAmount) ?? 0
    }
    
    var tipAmount: Double {
        let realTipPercentage: Double = Double(tipPercentages[tipPercentageIndex])
        return round((realTipPercentage * amount)/100)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return ((amount + tipAmount)/peopleCount).rounded()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople, content: {
                        ForEach(2 ..< 101) {
                            Text("\($0) People")
                        }
                    })
                }
                
                Section(header: Text("How much tip are you going to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentageIndex, content: {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                    Text("Your tip amount will be: $\(tipAmount, specifier: "%.2f")")
                        .foregroundColor(tipAmount > 0 ? .black : .red)
                }
                
                Section {
                    Text("$ \(totalPerPerson, specifier: "%.2f") per person")
                }
            }
        }.navigationTitle("WeSplit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
