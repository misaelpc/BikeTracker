//
//  Session.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//

import Foundation

struct Session {
  static func userIsOnboarded() -> Bool {
    let users = User.findAll()
    return users.count > 0
  }

  static func createUser() {
    let user = User.create() as? User
    user?.onboarded = true
    user?.save()
  }
}
