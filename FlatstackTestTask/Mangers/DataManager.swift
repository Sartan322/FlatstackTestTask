//
//  DataManager.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 14.06.2021.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FlatstackTestTask")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    func saveContext () {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                context.rollback()
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    
    func addCountry(country: Countries) {
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "name = %@", country.name)
        request.predicate = predicate
        //var managedObject = try? context.fetch(request)
        if let result = try? context.fetch(request) {
            if result.count > 0 {
                
                //var countryEntity = result[0]
                //print("Повтор : " + countryEntity.name!)
                
                result[0].name = country.name
                result[0].continent = country.continent
                result[0].capital = country.capital
                result[0].population = country.population
                result[0].descriptionSmall = country.descriptionSmall
                result[0].descriptionBig = country.description
                result[0].image = country.image
                result[0].images = country.images
                result[0].flag = country.flag
                result[0].next = country.next
            } else {
                //request.predicate = NSPredicate.init()
                //print(country.name)
                var countryEntity = Country(context: context)
                countryEntity.name = country.name
                countryEntity.continent = country.continent
                countryEntity.capital = country.capital
                countryEntity.population = country.population
                countryEntity.descriptionSmall = country.descriptionSmall
                countryEntity.descriptionBig = country.description
                countryEntity.image = country.image
                countryEntity.images = country.images
                countryEntity.flag = country.flag
                countryEntity.next = country.next
                //print(countryEntity)
            }
            saveContext()
        }
    }
    
    /// getNext - Получает последние добавленный элементы
    /// arg: count - Кол-во элементов(ячеек) уже добавленных
    
    func getNext(count: Int) -> [Country] {
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        request.fetchOffset = count
        do {
            let country = try context.fetch(request)
            return country
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteAll() {
        try? self.context.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "Country")))
        saveContext()
    }
}
