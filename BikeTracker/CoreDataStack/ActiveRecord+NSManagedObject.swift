//
//  ActiveRecord+NSManagedObject.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 26/08/22.
//
import Foundation
import CoreData

extension NSManagedObject {
  static func create() -> NSManagedObject {
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    return NSEntityDescription.insertNewObject(forEntityName: entityName(), into: context)
  }

  static func entityName() -> String {
    let entityName = NSStringFromClass(self.self)
    return entityName.replacingOccurrences(of: "BikeTracker.", with: "")
  }

  func save() {
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  static func deleteAll() -> [NSManagedObject] {
    let request = NSFetchRequest<NSFetchRequestResult>()
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    do {
      try context.execute(deleteRequest)
      return []
    } catch {
      NSLog("Unable to fetch local information")
      return []
    }
  }

  static func findAll() -> [NSManagedObject] {
      let request = NSFetchRequest<NSFetchRequestResult>()
      let localDataManager  = LocalDataManager.sharedInstance
      let context = localDataManager.persistentContainer.viewContext
      request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
      do {
        guard let results = try? context.fetch(request) as? [NSManagedObject] else {
          NSLog("Unable to fetch local information")
        return[]
        }
        return results
      }
  }

  static func findAll(orderBy: String) -> [NSManagedObject] {
    let request = NSFetchRequest<NSFetchRequestResult>()
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    let sortDescriptor = NSSortDescriptor(key: orderBy, ascending: true)
    request.sortDescriptors = [sortDescriptor]
      do {
        guard let results = try? context.fetch(request) as? [NSManagedObject] else {
          NSLog("Unable to fetch local information")
        return[]
        }
        return results
      }
  }

  static func resultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
    let localDataManager  = LocalDataManager.sharedInstance
    let context = localDataManager.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>()
    request.entity = NSEntityDescription.entity(forEntityName: entityName(), in: context)
    request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

    let controller = NSFetchedResultsController(fetchRequest: request,
                                                managedObjectContext: context,
                                                sectionNameKeyPath: nil, cacheName: nil)
    do {
      try controller.performFetch()
      return controller
    } catch {
      fatalError("Failed to fetch entities: \(error)")
    }
  }
}
