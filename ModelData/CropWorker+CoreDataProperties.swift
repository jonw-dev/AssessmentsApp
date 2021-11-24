//
//  CropWorker+CoreDataProperties.swift
//  AssessmentsApp
//
//  Created by jon richardson-williams on 23/11/2021.
//
//

import Foundation
import CoreData


extension CropWorker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CropWorker> {
        return NSFetchRequest<CropWorker>(entityName: "CropWorker")
    }

    @NSManaged public var name: String?

}

extension CropWorker : Identifiable {

}
