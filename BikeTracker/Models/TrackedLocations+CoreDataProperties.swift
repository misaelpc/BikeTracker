//
//  TrackedLocations+CoreDataProperties.swift
//  
//
//  Created by Misael Pérez Chamorro on 28/08/22.
//
//

import Foundation
import CoreData

extension TrackedLocations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackedLocations> {
        return NSFetchRequest<TrackedLocations>(entityName: "TrackedLocations")
    }

    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var order: Int16
    @NSManaged public var activity: Activity?

}
