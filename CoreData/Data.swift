//
//  Data+CoreDataClass.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//
//
import Foundation
import CoreData


class Data: NSManagedObject, Identifiable {
    
    @NSManaged public var order: Int16
    @NSManaged public var will: String?
    @NSManaged public var type: String?
    @NSManaged public var price: Float
    @NSManaged public var transaction: String?
    @NSManaged public var day: Int16
    @NSManaged public var month: Int16
    @NSManaged public var year: Int16
    
}

extension Data {
    
    static func getData() -> NSFetchRequest<Data> {
        
        let request: NSFetchRequest<Data> = Data.fetchRequest() as! NSFetchRequest<Data>
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Data.order, ascending: true)]
        
        return request
    }
    
    
}
