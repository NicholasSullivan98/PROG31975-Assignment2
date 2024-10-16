//
//  ContentView.swift
//  MyPizzaOrderNicholas2
//
//  Created by Nicholas Sullivan on 2024-10-15.
//
//  Nicholas Sullivan
//  991612414
//  Assignment 2

import SwiftUI
import CoreData

struct ContentView: View {
    @State var selectedSize : Size = .Small
    @State var selectedToppings : Toppings = .Cheese
    @State var selectedCrust : Crust = .Regular
    @State var quantity : Int = 1
    @State var orders: [Order] = []
    
    @StateObject var vm = MyViewModel()
    
    // For Stepper:
    let step = 1
    let range = 1...10
    
    enum Size: String, CaseIterable, Identifiable {
        case Small, Medium, Large
        var id: Self { self }
    }
    
    enum Toppings: String, CaseIterable, Identifiable {
        case  Cheese, Pepperoni, Veggie, MeatLovers
        var id: Self { self }
    }
    
    enum Crust: String, CaseIterable, Identifiable {
        case Thin, Regular, Thick
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Pizza Ordering System")
                    .font(.title)
                Spacer()
                HStack {
                    Text("Pizza Size: ")
                    Picker("Pizza Size", selection: $selectedSize){
                        Text("Small").tag(Size.Small)
                        Text("Medium").tag(Size.Medium)
                        Text("Large").tag(Size.Large)
                    }
                }
                HStack {
                    Text("Toppings: ")
                    Picker("Toppings", selection: $selectedToppings){
                        Text("Cheese").tag(Toppings.Cheese)
                        Text("Pepperoni").tag(Toppings.Pepperoni)
                        Text("Veggie").tag(Toppings.Veggie)
                        Text("Meat Lovers").tag(Toppings.MeatLovers)
                    }
                }
                Text("Crust Type: ")
                    .padding(5)
                Picker("Crust", selection: $selectedCrust){
                    Text("Thin").tag(Crust.Thin)
                    Text("Regular").tag(Crust.Regular)
                    Text("Thick").tag(Crust.Thick)
                }.pickerStyle(.segmented)
                
                Stepper(
                    value: $quantity,
                    in: range,
                    step: step
                ) {
                    Text("Quantitiy: \(quantity) ")
                }
                .padding(10)
                
                
                Button("Add Pizza"){
                    vm.addOrder(pizza_type: selectedToppings.rawValue, size: selectedSize.rawValue, quantity: Int16(quantity), timestamp: Date())
                }
                
                NavigationLink(destination: PizzaOrders()){
                    Text("Go to Order Screen")
                }.padding(10)
                Spacer()
            }
            .padding(10)
        }
    }
}

#Preview {
    ContentView()
}
