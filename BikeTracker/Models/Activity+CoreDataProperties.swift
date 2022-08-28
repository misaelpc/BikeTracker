//
//  Activity+CoreDataProperties.swift
//  
//
//  Created by Misael Pérez Chamorro on 28/08/22.
//
//

import Foundation
import CoreData

extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var distance: String?
    @NSManaged public var time: String?
    @NSManaged public var startLocation: String?
    @NSManaged public var finishLocation: String?
    @NSManaged public var locations: TrackedLocations?
    @NSManaged public var createdAt: Date?
}
