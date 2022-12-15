//
//  File.swift
//  
//
//  Created by Данила on 14.12.2022.
//

import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    
    func fetchCountrys() -> [Country]
    func resetAllRecords()
    func deleteCity(_ city: City)
    func saveContext()
    func save(_ citySearch: CitySearch) -> City?
}


final class CoreDataManager {
   
    private var persistentContainer: NSPersistentContainer = {
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



// MARK: - CoreDataManagerProtocol
extension CoreDataManager: CoreDataManagerProtocol {
    
    public func fetchCountrys() -> [Country] {
        
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        var countrys: [Country] = []
        
        do {
            countrys = try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return countrys
    }
    
    public func resetAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    public func deleteCity(_ city: City) {
        
        if city.country.citysArray.count == 1 {
            persistentContainer.viewContext.delete(city.country)
        } else {
            persistentContainer.viewContext.delete(city)
        }
        
        saveContext()
    }
    
    public func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Save method
    public func save(_ citySearch: CitySearch) -> City? {
        
        func createCity(_ citySearch: CitySearch,_ country: Country) -> City? {
            guard let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: persistentContainer.viewContext) else { return nil}
            
            let city = City(entity: cityEntity , insertInto: persistentContainer.viewContext)
            city.name = citySearch.name
            city.country = country
            city.isCapital = citySearch.isCapital
            city.latitude = citySearch.latitude
            city.longitude = citySearch.longitude
            if citySearch.population != nil {
                city.population = Double(citySearch.population!)
            } else {
                city.population = 0.0
            }
            if let timeAndTemp = createTimeAndTemp(for: city) {
                city.timeAndTemp = timeAndTemp
            }
            
            return city
        }
        
        func createTimeAndTemp(for city: City) -> TimeAndTemp? {
            guard let timeAndTempEntity = NSEntityDescription.entity(forEntityName: "TimeAndTemp", in: persistentContainer.viewContext) else { return nil }
            
            let timeAndTemp = TimeAndTemp(entity: timeAndTempEntity, insertInto: persistentContainer.viewContext)
            timeAndTemp.city = city
            timeAndTemp.temp = 0.0
            timeAndTemp.utcDiff = 0.0
            timeAndTemp.isNil = true
            
            return timeAndTemp
        }
        
        let countrys = fetchCountrys()
        
        /// Create only city
        if let country = countrys.filter({ $0.name == citySearch.country }).first {
            if country.citysArray.filter({ $0.name == citySearch.name }).first == nil {
                
                if let city = createCity(citySearch, country) {
                    saveContext()
                    return city
                }
            } else {
                print("try save old city")
            }
        } else {
            /// Create country and city
            guard let entity = NSEntityDescription.entity(forEntityName: "Country", in: persistentContainer.viewContext) else { return nil }
            
            let country = Country(entity: entity , insertInto: persistentContainer.viewContext)
            country.name = citySearch.country
            
            if citySearch.isoA2 != nil {
                country.isoA2 = citySearch.isoA2!
            }
            
            if let city = createCity(citySearch, country) {
                saveContext()
                return city
            }
        }
        return nil
    }
    
}
