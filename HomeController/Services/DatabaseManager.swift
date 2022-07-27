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
    
    func GetAllDevices() -> [Device] {
        var devices = [Device]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceDbModel")
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [DeviceDbModel] {
            for i in 0..<data.count {
                let device = Device(id: Int(data[i].id), deviceName: data[i].deviceName ?? "", intensity: Int(data[i].intensity), position: Int(data[i].position), mode: data[i].mode, temperature: Float(data[i].temperature), productType: data[i].productType ?? "")
                devices.append(device)
            }
        }
        return devices
    }
    
    func updateDevice(deviceToUpdate: Device) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceDbModel")
        fetchRequest.predicate = NSPredicate(format: "id == %i", deviceToUpdate.id)
        
        if let data = try? persistentContainer.viewContext.fetch(fetchRequest) as? [DeviceDbModel] {
            guard let object = data.first else {return}
            object.id = Int16(deviceToUpdate.id)
            object.temperature = deviceToUpdate.temperature ?? 0
            object.intensity = Int16(deviceToUpdate.intensity ?? 0)
            object.mode = deviceToUpdate.mode
            object.productType = deviceToUpdate.productType
            object.deviceName = deviceToUpdate.deviceName
            object.position = Int16(deviceToUpdate.position ?? 0)
            try? persistentContainer.viewContext.save()
        }
    }
    
    func writeToDatabase(array: [Device]) {
        for i in 0...array.count-1 {
            let device = DeviceDbModel(context: persistentContainer.viewContext)
            device.productType = array[i].productType
            device.intensity = Int16(array[i].intensity ?? 0)
            device.id = Int16(array[i].id)
            device.deviceName = array[i].deviceName
            device.temperature = array[i].temperature ?? 0
            device.position = Int16(array[i].position ?? 0)
            device.mode = array[i].mode
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
