//
//  File.swift
//  
//
//  Created by Данила on 21.11.2022.
//

import Foundation
import CoreData

protocol CoreDataProtocol: AnyObject {
    var persistentContainer: NSPersistentContainer { get set }
}

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



// MARK: - CoreDataProtocol
final class CoreDataManager: CoreDataProtocol {
   
    public var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "ExampleModel", managedObjectModel: managedObjectModel())
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    private static func managedObjectModel() -> NSManagedObjectModel {
        
        let model = NSManagedObjectModel()
        
        
        
        // MARK: - CountryEntity
        
        let countryEnt = NSEntityDescription()
        countryEnt.name = "Country"
        countryEnt.managedObjectClassName = NSStringFromClass(Country.self)
        
        // Attributes
        
        let countryNameAttr = NSAttributeDescription()
        countryNameAttr.name = "name"
        countryNameAttr.attributeType = .stringAttributeType
        
        let countryIsoA2Attr = NSAttributeDescription()
        countryIsoA2Attr.name = "isoA2"
        countryIsoA2Attr.attributeType = .stringAttributeType
        
        let countryFlagDataAttr = NSAttributeDescription()
        countryFlagDataAttr.name = "flagData"
        countryFlagDataAttr.attributeType = .binaryDataAttributeType
        countryFlagDataAttr.isOptional = true
        
        
        
        // MARK: - CityEntity
        
        let cityEnt = NSEntityDescription()
        cityEnt.name = "City"
        cityEnt.managedObjectClassName = NSStringFromClass(City.self)
        
        // Attributes
        
        let nameAttr = NSAttributeDescription()
        nameAttr.name = "name"
        nameAttr.attributeType = .stringAttributeType
        
        let isCapitalAttr = NSAttributeDescription()
        isCapitalAttr.name = "isCapital"
        isCapitalAttr.attributeType = .booleanAttributeType
        
        let latitudeAttr = NSAttributeDescription()
        latitudeAttr.name = "latitude"
        latitudeAttr.attributeType = .doubleAttributeType
        
        let longitudeAttr = NSAttributeDescription()
        longitudeAttr.name = "longitude"
        longitudeAttr.attributeType = .doubleAttributeType
        
        let populationAttr = NSAttributeDescription()
        populationAttr.name = "population"
        populationAttr.attributeType = .doubleAttributeType
        
        
        
        // MARK: - TimeAndTempEntity
        
        let timeAndTempEnt = NSEntityDescription()
        timeAndTempEnt.name = "TimeAndTemp"
        timeAndTempEnt.managedObjectClassName = NSStringFromClass(TimeAndTemp.self)
        
        // Attributes
        
        let tempAttr = NSAttributeDescription()
        tempAttr.name = "temp"
        tempAttr.attributeType = .doubleAttributeType
        
        let utcDiffAttr = NSAttributeDescription()
        utcDiffAttr.name = "utcDiff"
        utcDiffAttr.attributeType = .doubleAttributeType
        
        let isNilAttr = NSAttributeDescription()
        isNilAttr.name = "isNil"
        isNilAttr.attributeType = .booleanAttributeType
        
        
        // MARK: - Relationships
        
        let countryToCity = NSRelationshipDescription()
        countryToCity.name = "citys"
        countryToCity.destinationEntity = cityEnt
        countryToCity.deleteRule = .cascadeDeleteRule
        
        let cityToCountry = NSRelationshipDescription()
        cityToCountry.name = "country"
        cityToCountry.destinationEntity = countryEnt
        cityToCountry.maxCount = 1
        cityToCountry.deleteRule = .nullifyDeleteRule
        
        let cityToTime = NSRelationshipDescription()
        cityToTime.name = "timeAndTemp"
        cityToTime.destinationEntity = timeAndTempEnt
        cityToTime.maxCount = 1
        cityToTime.deleteRule = .cascadeDeleteRule
        
        let timeToCity = NSRelationshipDescription()
        timeToCity.name = "city"
        timeToCity.destinationEntity = cityEnt
        timeToCity.maxCount = 1
        timeToCity.deleteRule = .nullifyDeleteRule
        
        // Inverse relationships
        countryToCity.inverseRelationship = cityToCountry
        cityToCountry.inverseRelationship = countryToCity
        
        cityToTime.inverseRelationship = timeToCity
        timeToCity.inverseRelationship = cityToTime
        
        
        
        // Set properties
        countryEnt.properties = [countryNameAttr, countryIsoA2Attr, countryFlagDataAttr, countryToCity]
        cityEnt.properties = [nameAttr,
                              isCapitalAttr,
                              latitudeAttr,
                              longitudeAttr,
                              populationAttr,
                              cityToCountry,
                              cityToTime]
        timeAndTempEnt.properties = [tempAttr, utcDiffAttr, isNilAttr, timeToCity]
        
        
        model.entities = [countryEnt, cityEnt, timeAndTempEnt]
        
        return model
    }
}
