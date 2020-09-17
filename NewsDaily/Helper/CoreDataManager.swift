//
//  CoreDataManager.swift
//  NewsDaily
//
//  Created by Lawencon on 13/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    //1
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    
    //2
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsDaily")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //3
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /*Insert*/
    func insertPerson(name: String)->Daily? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Daily",
                                                in: managedContext)!
        
        
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "title")

        do {
            try managedContext.save()
            return person as? Daily
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func update(name:String, person : Daily) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            
            
            person.setValue(name, forKey: "title")
            
            
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    /*delete*/
    func delete(person : Daily){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            
            managedContext.delete(person)
            
        } catch {
            // Do something in response to error condition
            print(error)
        }
        
        do {
            try managedContext.save()
        } catch {
            // Do something in response to error condition
        }
    }
    
    func fetchAllPersons() -> [Daily]?{
        
        
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Daily")
        
        /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [Daily]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func delete(daily: Daily) -> [Daily]? {
        /*get reference to appdelegate file*/
        
        
        /*get reference of managed object context*/
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        /*init fetch request*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Daily")
        
        /*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
//        fetchRequest.predicate = NSPredicate(format: "ssn == %@" ,ssn)
        do {
            
            /*managedContext.fetch(fetchRequest) will return array of person objects [personObjects]*/
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedPeople = [Daily]()
            for i in item {
                
                /*call delete method(aManagedObjectInstance)*/
                /*here i is managed object instance*/
                managedContext.delete(i)
                
                /*finally save the contexts*/
                try managedContext.save()
                
                /*update your array also*/
                arrRemovedPeople.append(i as! Daily)
            }
            return arrRemovedPeople
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
}
