//
//  LocalDataManager.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//

import Foundation
import CoreData

class LocalDataManager {
  static let sharedInstance = LocalDataManager()

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BikeTracker")

    let appName: String = "BikeTracker"
    var persistentStoreDescriptions: NSPersistentStoreDescription

    let storeUrl = self.getDocumentsDirectory().appendingPathComponent("BikeTracker.sqlite")

    if !FileManager.default.fileExists(atPath: (storeUrl.path)) {
      let seededDataUrl = Bundle.main.url(forResource: appName, withExtension: "sqlite")
      do {
        try FileManager.default.copyItem(at: seededDataUrl!, to: storeUrl)
      } catch {
        fatalError("Unresolved error \(error), \(error.localizedDescription)")
      }
    }

    let description = NSPersistentStoreDescription()
    description.shouldInferMappingModelAutomatically = true
    description.shouldMigrateStoreAutomatically = true
    description.url = storeUrl

    container.persistentStoreDescriptions = [description]

    container.loadPersistentStores(completionHandler: { (_, error) in
        if let error = error as NSError? {

            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
  }()

  private init() {}

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
}
