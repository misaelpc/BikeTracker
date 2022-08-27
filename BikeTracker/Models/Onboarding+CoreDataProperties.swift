//
//  Onboarding+CoreDataProperties.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//
//

import Foundation
import CoreData

extension Onboarding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Onboarding> {
        return NSFetchRequest<Onboarding>(entityName: "Onboarding")
    }

    @NSManaged public var title: String?
    @NSManaged public var icon: String?
    @NSManaged public var order: NSNumber?
}

extension Onboarding: Identifiable {

}
