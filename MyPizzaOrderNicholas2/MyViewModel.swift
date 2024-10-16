//
//  MyViewModel.swift
//  MyPizzaOrderNicholas2
//
//  Created by Nicholas Sullivan on 2024-10-15.
//
//  Nicholas Sullivan
//  991612414
//  Assignment 2

import Foundation
import CoreData

class MyViewModel : ObservableObject {
    
    @Published var orders : [Order] = []
    let viewContext : NSManagedObjectContext
    
    init() {
        viewContext = PersistenceController.shared.container.viewContext
        
        fetchOrders()
    }
    
    func fetchOrders(){
        let request = NSFetchRequest<Order>(entityName: "Order")
    
        do {
            orders = try viewContext.fetch(request)
        }catch{
            print("Errpr: \(error)")
        }
    }
    
    func saveData(){
        do{
            try viewContext.save()
        }catch{
            print("Error: \(error)")
        }
    }
    
    func addOrder(pizza_type: String, size: String, quantity: Int16, timestamp: Date){
        
        let order = Order(context: viewContext)
        order.id = UUID()
        order.pizza_type = pizza_type
        order.size = size
        order.quantity = quantity
        order.timestamp = timestamp
        
        saveData()
        fetchOrders()
    }
    
    func deleteOrder(indexSet: IndexSet){
        for index in indexSet {
            let order = orders[index]
            viewContext.delete(order)
        }
        saveData()
        fetchOrders()
        
        print("Deleted")
    }
    
    func updateOrder(order: Order, pizza_type: String, size: String, quantity: Int16, timestamp: Date){
        order.pizza_type = pizza_type
        order.size = size
        order.quantity = quantity
        order.timestamp = timestamp
        
        saveData()
        fetchOrders()
        
        print("Updated")
    }
    
    func updateQuantity(for order: Order, newQuantity: Int) {
        if let index = orders.firstIndex(where: { $0.id == order.id }) {
            orders[index].quantity = Int16(newQuantity)
            saveData()
            fetchOrders()
        }
    }
}
