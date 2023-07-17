//
//  Pmmrescription+CoreDataProperties.swift
//  colonCancer
//
//  Created by KH on 05/07/2023.
//
//

import Foundation
import CoreData


extension Pmmrescription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pmmrescription> {
        return NSFetchRequest<Pmmrescription>(entityName: "Pmmrescription")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var quantity: String?
    @NSManaged public var amount: String?
    @NSManaged public var time: Date?
    @NSManaged public var repeatedDays: NSObject?
    @NSManaged public var reminderIsEnabled: Bool
    @NSManaged public var datesOfDays: NSObject?
    @NSManaged public var type: NSObject?

}

extension Pmmrescription : Identifiable {

}
