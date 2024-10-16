//
//  PizzaOrders.swift
//  MyPizzaOrderNicholas2
//
//  Created by Nicholas Sullivan on 2024-10-15.
//
//  Nicholas Sullivan
//  991612414
//  Assignment 2

import SwiftUI

struct PizzaOrders: View {
    
    @StateObject var vm = MyViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.orders.sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })) { order in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(order.size ?? "Pizza Size")")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Text("\(order.pizza_type ?? "Pizza Type") Pizza")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        HStack {
                            Text("Qtny: \(order.quantity)")
                                .font(.body)
                            Stepper("", value: Binding(
                                get: { Int(order.quantity) },
                                set: { newValue in vm.updateQuantity(for: order, newQuantity: newValue) }
                            ), in: 1...100)
                            .labelsHidden()
                        }
                        Text("Order Date: \(formattedDate(order.timestamp))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
                .onDelete { indexSet in
                    vm.deleteOrder(indexSet: indexSet)
                }
            }
            .navigationTitle("Order View")
            .environmentObject(vm)
        }
    }
    
    // Function to format date
    func formattedDate(_ timestamp: Date?) -> String {
        guard let timestamp = timestamp else { return "No Date" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
    
}

#Preview {
    PizzaOrders()
}
