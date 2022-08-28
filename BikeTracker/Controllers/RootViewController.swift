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
