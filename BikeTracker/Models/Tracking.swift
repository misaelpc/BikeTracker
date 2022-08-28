//
//  Tracking.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 28/08/22.
//

import Foundation
import CoreLocation
import GoogleMaps

class Tracking: NSObject {
  var currentActivity: Activity?
  let locationManager = LocationManager()
  let stopWatch = Stopwatch()
  var lastRegisterLocation: CLLocation?
  let mapView: GMSMapView

  init(withMap mapView: GMSMapView) {
    self.mapView = mapView
    self.currentActivity = Activity.create() as? Activity
    super.init()
    locationManager.delegate = self
  }

  var formatter: DateComponentsFormatter = {
          let formatter = DateComponentsFormatter()
          formatter.unitsStyle = .positional
          formatter.allowedUnits = [ .hour, .minute, .second ]
          formatter.zeroFormattingBehavior = [ .pad ]
          formatter.allowsFractionalUnits = true
          return formatter
      }()

  func start() {
    currentActivity?.createdAt = NSDate.now
    locationManager.startTracking()
    stopWatch.start()
  }

  func stop() {
    locationManager.getAddress(location: lastRegisterLocation!) { [self] address in
      self.currentActivity?.finishLocation = address
      let interval = self.stopWatch.elapsedTime()
      self.currentActivity?.time = self.formatter.string(from: interval)!
      self.currentActivity?.save()
      self.stopWatch.reset()
      self.locationManager.stopTracking()
    }
  }
}

extension Tracking: LocationManagerDelegate {
  func didReceivedLocation(location: CLLocation) {
    let trackedLocation = TrackedLocations.create() as? TrackedLocations
    trackedLocation?.longitude = Float(location.coordinate.longitude)
    trackedLocation?.latitude = Float(location.coordinate.latitude)
    trackedLocation?.activity = currentActivity
    trackedLocation?.save()
    if lastRegisterLocation != nil {
      let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude,
                                            zoom: 15.0)
      mapView.animate(to: camera)
      let path = GMSMutablePath()
      path.add(CLLocationCoordinate2D(latitude: lastRegisterLocation!.coordinate.latitude,
                                      longitude: lastRegisterLocation!.coordinate.longitude))
      path.add(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
      let polyline = GMSPolyline(path: path)
      polyline.strokeWidth = 3
      polyline.strokeColor = UIColor(named: "Orange")!
      polyline.map = mapView
      lastRegisterLocation = location
    } else {
      locationManager.getAddress(location: location) { address in
        self.currentActivity?.startLocation = address
        self.currentActivity?.save()
      }
    }
    lastRegisterLocation = location
  }
}
