//
//  Product+CoreDataProperties.swift
//  Carty
//
//  Created by Jimmy on 29/08/2023.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var thumbnail: Data?

}

extension Product : Identifiable {

}
