//
//  TrackingProtocol.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 28/08/22.
//

import Foundation
import CoreLocation

protocol TrackingDelegate: AnyObject {
  func startTracking()
  func stopTraking()
}

protocol LocationManagerDelegate: AnyObject {
  func didReceivedLocation(location: CLLocation)
}
