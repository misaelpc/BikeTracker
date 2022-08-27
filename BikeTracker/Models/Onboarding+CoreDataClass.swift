//
//  Onboarding+CoreDataClass.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//
//

import Foundation
import CoreData

public class Onboarding: NSManagedObject {
  static func pages() -> [Onboarding] {
    guard let results = Onboarding.findAll(orderBy: "order") as? [Onboarding]  else {
      return []
    }
    return results
  }
}
