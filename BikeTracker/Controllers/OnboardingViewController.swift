//
//  OnboardingViewController.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//

import UIKit

class OnboardingViewController: UIViewController {
  private var pageController: UIPageViewController?
  private var initialIndex = 0
  weak var delegate: OnboardingDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupPageController()
  }

  private func setupPageController() {
    self.pageController = UIPageViewController(transitionStyle: .scroll,
                                               navigationOrientation: .horizontal,
                                               options: nil)
    self.pageController?.dataSource = self
    self.pageController?.delegate = self
    self.pageController?.view.backgroundColor = .clear
    self.pageController?.view.frame = CGRect(x: 0, y: 0, width:
                                              self.view.frame.width,
                                             height: self.view.frame.height)
    let onboarding = Onboarding.pages()[initialIndex]
    let initialVC = PageViewController.init(index: initialIndex, onboarding: onboarding)
    initialVC.delegate = self
    self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
    self.addChild(self.pageController!)
    self.view.addSubview(self.pageController!.view)
    self.pageController?.didMove(toParent: self)
  }
}

extension OnboardingViewController: OnboardingDelegate {
  func continueToHome() {
    delegate?.continueToHome()
  }

  func skipToHome() {
    delegate?.continueToHome()
  }
}

extension OnboardingViewController: UIPageViewControllerDataSource,
                                    UIPageViewControllerDelegate {

  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let currentVC = viewController as? PageViewController else {
                return nil
            }

    var index = currentVC.index

    if index == 0 {
        return nil
    }

    index -= 1

    let onboarding = Onboarding.pages()[index]
    let pageViewController = PageViewController.init(index: index, onboarding: onboarding)
    pageViewController.delegate = self
    return pageViewController
  }

  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentVC = viewController as? PageViewController else {
                return nil
            }

    var index = currentVC.index

    if index >= Onboarding.pages().count - 1 {
        return nil
    }

    index += 1

    let onboarding = Onboarding.pages()[index]
    let pageViewController = PageViewController.init(index: index, onboarding: onboarding)
    pageViewController.delegate = self
    return pageViewController
  }

  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return Onboarding.pages().count
  }

  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return self.initialIndex
  }
}
