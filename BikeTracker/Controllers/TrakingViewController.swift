//
//  TrakingViewController.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 27/08/22.
//

import UIKit
import GoogleMaps

class TrakingViewController: UIViewController {
  let center = UNUserNotificationCenter.current()
  var tracking: Tracking?
  var mapView: GMSMapView?

  lazy var actionViewController: ActionViewController = {
    let actionVC = ActionViewController()
    actionVC.delegate = self
    actionVC.view.frame = CGRect(x: 0, y: 0, width:
                                                  self.view.frame.width * 0.80 ,
                                                 height: self.view.frame.height * 0.50)
    actionVC.view.center = self.view.center
    return actionVC
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMap()
    setupPlusButton()
  }

  private func setupMap() {
    center.requestAuthorization(options: [.alert, .sound]) { _, _ in
    }
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)

    self.view.addSubview(mapView!)
  }

  private func setupPlusButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                        target: self, action: #selector(createActivity))
  }

  @objc func createActivity() {
    guard let currentMap = mapView else {return}
    tracking = Tracking(withMap: currentMap)
    setupStartTackingView()
  }

  private func setupStartTackingView() {
    self.addContentViewController(childController: actionViewController)
  }

  private func addContentViewController(childController: UIViewController) {
    self.addChild(childController)
    self.view.addSubview(childController.view)
    childController.didMove(toParent: self)
  }
}

extension TrakingViewController: TrackingDelegate {
  func startTracking() {
    tracking?.start()
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      let interval = self.tracking?.stopWatch.elapsedTime()
      self.actionViewController.updateLabel(interval: (self.tracking?.formatter.string(from: interval!)!)!)
    }
  }

  func stopTraking() {
    actionViewController.view.removeFromSuperview()
    actionViewController.removeFromParent()
    tracking?.stop()
  }
}
