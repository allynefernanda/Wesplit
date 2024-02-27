
//  ContentView.swift
//  Wesplit
//
//  Created by allyne fernanda  on 20/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,25,50,75] //armazena as porcentagens de gorjeta disponíveis
    
    //uma função computada, que calcula o valor total por pessoa e 
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople+2)
        let TipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * TipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
   // Este é o corpo principal da estrutura de visualização, onde a aparência e o comportamento da interface do usuário são definidos.
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }//.pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    //Text("How much do you want to tip?")
                    Picker("tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }//.focused($amountIsFocused)
                    }.pickerStyle(.segmented)
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                }
            }.navigationTitle("WeSplit")
                .toolbar{
                    if amountIsFocused{
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }.navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
    #Preview {
        ContentView()
    }
