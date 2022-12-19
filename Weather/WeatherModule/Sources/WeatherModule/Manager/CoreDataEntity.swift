//
//  File.swift
//  
//
//  Created by Данила on 21.11.2022.
//

import CoreData

public final class Country: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var isoA2: String
    @NSManaged var flagData: Data?
    @NSManaged public var citys: NSSet?
    
    public var citysArray: [City] {
        let set = citys as? Set<City> ?? []
        
        return set.sorted {
            $0.name < $1.name
        }.sorted {
            $0.isCapital && !$1.isCapital
        }
    }
}

extension Country: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }
    
    @objc(addCitysObject:)
    @NSManaged public func addToCitys(_ value: City)
    
    @objc(removeCitysObject:)
    @NSManaged public func removeFromCitys(_ value: City)
    
    @objc(addCitys:)
    @NSManaged public func addToCitys(_ values: NSSet)
    
    @objc(removeCitys:)
    @NSManaged public func removeFromCitys(_ values: NSSet)
}

public final class City: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var isCapital: Bool
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var population: Double
    
    @NSManaged var country: Country
    @NSManaged var timeAndTemp: TimeAndTemp
}

extension City: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
}

public final class TimeAndTemp: NSManagedObject {
    @NSManaged var temp: Double
    @NSManaged var utcDiff: Double
    @NSManaged var isNil: Bool
    
    @NSManaged var city: City
}

extension TimeAndTemp: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeAndTemp> {
        return NSFetchRequest<TimeAndTemp>(entityName: "TimeAndTemp")
    }
}
