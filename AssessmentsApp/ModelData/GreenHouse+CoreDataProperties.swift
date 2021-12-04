//
//  GreenHouse+CoreDataProperties.swift
//  AssessmentsApp
//
//  Created by jon richardson-williams on 03/12/2021.
//
//

import Foundation
import CoreData


extension GreenHouse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GreenHouse> {
        return NSFetchRequest<GreenHouse>(entityName: "GreenHouse")
    }

    @NSManaged public var name: String?
    @NSManaged public var rows: [Int64]?

}

extension GreenHouse : Identifiable {

}
