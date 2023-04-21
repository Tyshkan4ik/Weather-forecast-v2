//
//  CoreDataManager.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 21.04.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    private let container = NSPersistentContainer(name: "CoreData")
    private let entityName = "DBCities"
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {}
    
    /// Регистрация контейнера
    func registerContainer() {
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    ///Метод сохранения в БД
    func save(city: CityModel?) {
        do {
            let dbCity = DBCities(context: context)
            dbCity.id = Int64(city?.id ?? 0)
            dbCity.lon = city?.lon ?? 0
            dbCity.lat = city?.lat ?? 0
            dbCity.trueFalse = ((city?.favoritesOnOff) != nil)
            try context.save()
        }
        catch {
            print("Save error")
        }
    }
    
    ///Метод выгрузки из БД
    func getCities(completion: @escaping ([DBCities]) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let request = NSFetchRequest<DBCities>(entityName: self.entityName)
                let cities = try self.context.fetch(request)
                completion(cities)
            }
            catch {
                completion([])
                print("Request error ")
            }
        }
    }
    
    ///Метод удаление из БД
    func delete(cityId: CityModel?) {
        do {
            let request = NSFetchRequest<DBCities>(entityName: self.entityName)
            let cities = try self.context.fetch(request)
            if let city = cities.first(where: { $0.id == cityId?.id ?? 0}) {
                context.delete(city)
                try context.save()
            }
        }
        catch {
            print("Delete error")
        }
    }
}
