//
//  DBCities.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 21.04.2023.
//

import CoreData

@objc(DBCities)

class DBCities: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var trueFalse: Bool
}
