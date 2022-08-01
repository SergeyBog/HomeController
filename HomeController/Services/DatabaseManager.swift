//
//  DatabaseManager.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 25.07.2022.
//

import Foundation
import CoreData

class DatabaseManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HomeController")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getDevicesFromDatabase() -> [Device] {
        var devices = [Device]()
        
        let lightFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LightDbModel")
        
        let heaterFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeaterDbModel")
        
        let rollershutterFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RollershutterDbModel")
        
        if let lightDevicesData = try? persistentContainer.viewContext.fetch(lightFetchRequest) as? [LightDbModel] {
            for i in 0..<lightDevicesData.count {
                let device = Device(id: Int(lightDevicesData[i].id), deviceName: lightDevicesData[i].deviceName ?? "", intensity: Int(lightDevicesData[i].intensity), position: nil, mode: lightDevicesData[i].mode ?? "", temperature: nil, productType: "Light")
                devices.append(device)
            }
            
        }
        
        if let heaterDevicesData = try? persistentContainer.viewContext.fetch(heaterFetchRequest) as? [HeaterDbModel] {
            for i in 0..<heaterDevicesData.count {
                let device = Device(id: Int(heaterDevicesData[i].id), deviceName: heaterDevicesData[i].deviceName ?? "", intensity: nil, position: nil, mode: heaterDevicesData[i].mode ?? "", temperature: heaterDevicesData[i].temperature, productType: "Heater")
                devices.append(device)
            }
            
        }
        
        if let rollershutterDevicesData = try? persistentContainer.viewContext.fetch(rollershutterFetchRequest) as? [RollershutterDbModel] {
            for i in 0..<rollershutterDevicesData.count {
                let device = Device(id: Int(rollershutterDevicesData[i].id), deviceName: rollershutterDevicesData[i].deviceName ?? "", intensity: nil, position: Int(rollershutterDevicesData[i].position), mode: rollershutterDevicesData[i].mode ?? "", temperature: nil, productType: "RollerShutter")
                devices.append(device)
            }
            
        }
        
        return devices.sorted {$0.id < $1.id}
    }
    
    
    func getLightDevice(with deviceId: Int) -> Light {
        var lightDevice = Light(id: 0, deviceName: "", intensity: 0, mode: "")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LightDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceId)
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [LightDbModel] {
            if let object = data.first {
                lightDevice.id = Int(object.id)
                lightDevice.deviceName = object.deviceName ?? ""
                lightDevice.intensity = Int(object.intensity)
                lightDevice.mode = object.mode ?? ""
            }
        }
        return lightDevice
    }
    
    func getHeaterDevice(with deviceId: Int) -> Heater {
        var heaterDevice = Heater(id: 0, deviceName: "", temperature: 0, mode: "")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeaterDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceId)
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [HeaterDbModel] {
            if let object = data.first {
                heaterDevice.id = Int(object.id)
                heaterDevice.deviceName = object.deviceName ?? ""
                heaterDevice.temperature = object.temperature
                heaterDevice.mode = object.mode ?? ""
            }
        }
        return heaterDevice
    }
    
    func getRollershutterDevice(with deviceId: Int) -> RollerShutter {
        var rollershutterDevice = RollerShutter(id: 0, deviceName: "", position: 0, mode: "")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RollershutterDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceId)
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [RollershutterDbModel] {
            if let object = data.first {
                rollershutterDevice.id = Int(object.id)
                rollershutterDevice.deviceName = object.deviceName ?? ""
                rollershutterDevice.position = Int(object.position)
                rollershutterDevice.mode = object.mode ?? ""
            }
        }
        return rollershutterDevice
    }
    
    
    func updateLightDevice(deviceToUpdate: Light) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LightDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceToUpdate.id)
        
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [LightDbModel] {
            guard let object = data.first else {return}
            object.id = Int16(deviceToUpdate.id)
            object.deviceName = deviceToUpdate.deviceName
            object.intensity = Int16(deviceToUpdate.intensity)
            object.mode = deviceToUpdate.mode
            try? persistentContainer.viewContext.save()
        }
    }
    
    func updateHeaterDevice(deviceToUpdate: Heater) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeaterDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceToUpdate.id)
        
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [HeaterDbModel] {
            guard let object = data.first else {return}
            object.id = Int16(deviceToUpdate.id)
            object.deviceName = deviceToUpdate.deviceName
            object.temperature = deviceToUpdate.temperature
            object.mode = deviceToUpdate.mode
            try? persistentContainer.viewContext.save()
        }
    }
    
    func updateRollershutterDevice(deviceToUpdate: RollerShutter) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RollershutterDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceToUpdate.id)
        
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [RollershutterDbModel] {
            guard let object = data.first else {return}
            object.id = Int16(deviceToUpdate.id)
            object.deviceName = deviceToUpdate.deviceName
            object.position = Int16(deviceToUpdate.position)
            object.mode = deviceToUpdate.mode
            try? persistentContainer.viewContext.save()
        }
    }
    
    func writeToDatabase(array: [Device]) {
        for i in 0..<array.count {
            if array[i].productType == "Light" {
                let light = LightDbModel(context: persistentContainer.viewContext)
                light.id = Int16(array[i].id)
                light.deviceName = array[i].deviceName
                light.intensity = Int16(array[i].intensity ?? 0)
                light.mode = array[i].mode ?? ""
                
            } else if array[i].productType == "Heater" {
                let heater = HeaterDbModel(context: persistentContainer.viewContext)
                heater.id = Int16(array[i].id)
                heater.deviceName = array[i].deviceName
                heater.temperature = array[i].temperature ?? 0
                heater.mode = array[i].mode ?? ""
                
            } else {
                let rollershutter = RollershutterDbModel(context: persistentContainer.viewContext)
                
                var deviceMode = String()
                
                if rollershutter.position == 0 {
                    deviceMode = "Off"
                } else {
                    deviceMode = "On"
                }
                
                rollershutter.id = Int16(array[i].id)
                rollershutter.deviceName = array[i].deviceName
                rollershutter.position = Int16(array[i].position ?? 0)
                rollershutter.mode = deviceMode
            }
        }
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
