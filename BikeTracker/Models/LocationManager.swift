//
//  LocationManager.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 28/08/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
  let locationManager = CLLocationManager()
  lazy var geocoder = CLGeocoder()
  weak var delegate: LocationManagerDelegate?

  func startTracking() {
    locationManager.requestAlwaysAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 10
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.startUpdatingLocation()
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.delegate = self
  }

  func stopTracking() {
    locationManager.stopUpdatingLocation()
  }

  func getAddress(location: CLLocation, onResult: @escaping (_ address: String) -> Void) {
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      let result = self.processResponse(withPlacemarks: placemarks, error: error)
      onResult(result)
    }
  }

  private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {

      if let error = error {
          print("Unable to Reverse Geocode Location (\(error))")
          return "Unable to Find Address for Location"

      } else {
          if let placemarks = placemarks, let placemark = placemarks.first {
            return placemark.compactAddress!
          } else {
              return "No Matching Addresses Found"
          }
      }
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    delegate?.didReceivedLocation(location: location)
  }
}

extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }
            return result
        }

        return nil
    }

}
