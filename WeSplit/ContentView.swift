//
//  ContentView.swift
//  WeSplit
//
//  Created by Mehmet Alp Sönmez on 16.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    var totalPerPerson: (Double, Double) {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return (amountPerPerson, grandTotal)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
//                    .pickerStyle(.navigationLink)
                }
                Section("How much do you want to tip?"){
                    Picker("Tip percentage", selection: $tipPercentage) {
//                    shows as section    ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
//                    .pickerStyle(.segmented) "not in a new page"
                    .pickerStyle(.navigationLink)
                    
                }
              Section("Amount Per Person") {
                  Text(totalPerPerson.0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
               }
                Section("Total Amount of Check") {
                    Text("Total Amount before splitting: \(totalPerPerson.1, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        .foregroundStyle(tipPercentage == 0 ? .red : .blue)
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused{
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .toolbarBackground(.red, for: .navigationBar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
