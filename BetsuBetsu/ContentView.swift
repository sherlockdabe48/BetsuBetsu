//
//  ContentView.swift
//  BetsuBetsu
//
//  Created by Antarcticaman on 16/6/2564 BE.
//


import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentageChoice = 2
    func checkNoTip() -> Bool {
        if tipPercentageChoice == 4 {
            return true
        } else {
            return false
        }
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
   var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentageChoice])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount * tipSelection / 100
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?").textCase(nil)) {
                    Picker("Tip Percentage", selection: $tipPercentageChoice) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount Per Person").textCase(nil)) {
                    Text("$\(totalPerPerson,specifier: "%.2f")")
                }
                
                Section(header: Text("Total Amount (Order + Tip)").textCase(nil)) {
                    Text("$\(totalPerPerson * Double(numberOfPeople + 2),specifier: "%.2f")")
                        .foregroundColor(self.checkNoTip() ? .red : .black)
                }
            }
            .navigationBarTitle("BetsuBetsu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
