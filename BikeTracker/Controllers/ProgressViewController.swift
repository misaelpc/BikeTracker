//
//  ProgressViewController.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 27/08/22.
//

import UIKit
import CoreData

class ProgressViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var resulsController: NSFetchedResultsController<NSFetchRequestResult>?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    updateData()
      // Do any additional setup after loading the view.
  }

  func setupTableView() {
    self.tableView.register(UINib(nibName: "ActivityTableViewCell",
                                bundle: nil), forCellReuseIdentifier: "ActivityTableViewCell")
  }

  func updateData() {
    resulsController = Activity.resultsController()
    resulsController?.delegate = self
  }
}

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = self.resulsController?.sections else {
        fatalError("No sections in fetchedResultsController")
    }
    let sectionInfo = sections[section]
    return sectionInfo.numberOfObjects
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let activity = self.resulsController?.object(at: indexPath) as? Activity else {
        fatalError("Attempt to configure cell without a managed object")
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell",
    for: indexPath) as? ActivityTableViewCell
    cell?.bind(activity: activity)
    return cell!
  }
}

extension ProgressViewController: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.reloadData()
  }
}
