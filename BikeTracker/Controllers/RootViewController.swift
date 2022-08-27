//
//  ViewController.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//

import UIKit

class RootViewController: UIViewController {

  lazy var onboardindViewController: OnboardingViewController? = {
    return createChildViewController(
      "Onboarding",
      "OnboardingViewController") as? OnboardingViewController
  }()

  lazy var homeViewController: UIViewController = {
    return createChildViewController(
      "Home",
      "HomeViewController")
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    displayAppContent()
//    let steps = Onboarding.findAll()
//    debugPrint(steps)
//    let onboarding1 = Onboarding.create() as? Onboarding
//    onboarding1?.title = "Extremely simple to use"
//    onboarding1?.icon = "icn-easy"
//    onboarding1?.order = NSNumber(value: 1)
//    let onboarding2 = Onboarding.create() as? Onboarding
//    onboarding2?.title = "Track your time and distance"
//    onboarding2?.icon = "icn-tracking"
//    onboarding2?.order = NSNumber(value: 2)
//    let onboarding3 = Onboarding.create() as? Onboarding
//    onboarding3?.title = "See your progress and challenge your self"
//    onboarding3?.icon = "icn-trophy"
//    onboarding3?.order = NSNumber(value: 3)
//    onboarding3?.save()
    // Do any additional setup after loading the view.
  }

  private func displayAppContent() {
    if Session.userIsOnboarded() {
      addContentViewController(childController: homeViewController)
    } else {
      guard let onboardindVC = onboardindViewController
      else {return}
      onboardindVC.delegate = self
      addContentViewController(childController: onboardindVC)
    }
  }

  private func addContentViewController(childController: UIViewController) {
    self.addChild(childController)
    self.view.addSubview(childController.view)
    childController.didMove(toParent: self)
  }

  private func createChildViewController(_ storyBoardName: String, _ controllerIdentifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
    let customViewController = storyboard.instantiateViewController(withIdentifier: controllerIdentifier)
    return customViewController
  }
}

extension RootViewController: OnboardingDelegate {
  func continueToHome() {
    guard let onboardindVC = onboardindViewController
    else {return}
    onboardindVC.view.removeFromSuperview()
    onboardindVC.removeFromParent()
    Session.createUser()
    addContentViewController(childController: homeViewController)
  }
}
