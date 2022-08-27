//
//  User+CoreDataProperties.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var onboarded: Bool

}

extension User: Identifiable {

}
