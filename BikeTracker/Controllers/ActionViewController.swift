//
//  ActionViewController.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 27/08/22.
//

import UIKit

class ActionViewController: UIViewController {
  weak var delegate: TrackingDelegate?
  @IBOutlet weak var startTrackingButton: UIButton!
  @IBOutlet weak var stopTrackingButton: UIButton!
  @IBOutlet weak var timerLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupRoundCorners()
    setupInitialState()
    // Do any additional setup after loading the view.
  }

  func updateLabel(interval: String) {
    timerLabel.text = interval
  }

  private func setupInitialState() {
    stopTrackingButton.isEnabled = false
  }

  private func setupRoundCorners() {
    self.view.layer.cornerRadius = 10
  }

  @IBAction func startTrackingButtonWasTouchedUpInside() {
    startTrackingButton.isEnabled = false
    stopTrackingButton.isEnabled = true
    delegate?.startTracking()
  }

  @IBAction func stopTrackingButtonWasTouchedUpInside() {
    startTrackingButton.isEnabled = true
    stopTrackingButton.isEnabled = false
    delegate?.stopTraking()
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
