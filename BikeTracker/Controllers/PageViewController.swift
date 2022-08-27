//
//  PageViewController.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//

import UIKit

class PageViewController: UIViewController {

  var index = 0
  var onboarding: Onboarding?
  weak var delegate: OnboardingDelegate?
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var continueButton: UIButton!
  @IBOutlet weak var skipButton: UIButton!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  convenience init(index: Int, onboarding: Onboarding?) {
    self.init(nibName: nil, bundle: nil)
    self.index = index
    self.onboarding = onboarding
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupContent()
  }

  private func setupContent() {
    guard let currentOnboarding = onboarding,
          let icon = currentOnboarding.icon else {
      return
    }
    titleLabel.text = currentOnboarding.title
    imageView.image = UIImage(named: icon)
    setupButtons()
  }

  private func setupButtons() {
    if index == 2 {
      continueButton.isHidden = false
      skipButton.isHidden = true
    } else {
      skipButton.isHidden = false
      continueButton.isHidden = true
    }
  }

  @IBAction func continueButtonWasTouchedUpInside() {
    delegate?.continueToHome()
  }

  @IBAction func skipButtonWasTouchedUpInside() {
    delegate?.continueToHome()
  }
}
