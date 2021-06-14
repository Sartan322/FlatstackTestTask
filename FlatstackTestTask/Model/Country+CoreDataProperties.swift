//
//  Country+CoreDataProperties.swift
//  
//
//  Created by Павел Прокопьев on 14.06.2021.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var capital: String?
    @NSManaged public var continent: String?
    @NSManaged public var descriptionBig: String?
    @NSManaged public var descriptionSmall: String?
    @NSManaged public var flag: String?
    @NSManaged public var image: String?
    @NSManaged public var images: String?
    @NSManaged public var name: String?
    @NSManaged public var population: String?
    @NSManaged public var next: String?

}
