import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SecondView()) {
                    Text("Ir para a Tela Principal")
                }
                Spacer()
            }.navigationBarTitleDisplayMode(.inline)
            .padding()
            .navigationTitle("Pagina Inicial")
        }
    }
}

struct SecondView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 25, 50, 75]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
            }
            
            Section(header: Text("How much do you want to tip?")) {
                Picker("Tip Percentage", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            
                
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                }
            
            Section {
                NavigationLink(destination: ThreeView()) {
                    Text("Ir para a segunda tela")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
struct SecondNavigationView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Estamos na segunda navegação!")
                NavigationLink(destination: SecondView()) {
                    Text("Ir para a Segunda Tela")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Segunda Navegação")
        }
    }
}

struct ThreeView: View {
    var body: some View {
        Text("Segunda Tela")
            .navigationTitle("Segunda Tela")
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

