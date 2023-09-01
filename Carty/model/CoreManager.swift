//
//  CoreManager.swift
//  Carty
//
//  Created by Jimmy on 29/08/2023.
//

import Foundation
import CoreData
import UIKit

class CoreManager{
    
    static let CM = CoreManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    func fetchProducts() -> [Product]{
        do{
           let products = try context.fetch(Product.fetchRequest())
            return products
        }catch{
            return [Product]()
        }
    }
    
    func fetch(id: Int64) -> [Product]{
        do{
            let request = Product.fetchRequest() as NSFetchRequest<Product>
            let pred = NSPredicate(format: "id == %@",NSNumber(integerLiteral: Int(id)))
            request.predicate = pred
            
            let products = try context.fetch(request)
            return products
        }catch{
            return [Product]()
        }
    }
    
    func removeProduct(id: Int64){
        do{
            let products = fetch(id: id)
            let product = products[0]
            context.delete(product)
            
            try self.context.save()
        }catch let error{
            print(error)
        }
    }
    
    func addProduct(id: Int64,title: String,thumbnail: Data){
        
        let product = Product(context: context)
        product.id = id
        product.title = title
        product.thumbnail = thumbnail

        do{
            try context.save()
        }catch let error{
            print(error)
        }
    }
}
