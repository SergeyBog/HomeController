//
//  DeviceManager.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 30.07.2022.
//

import Foundation

class DeviceManager {
    
    var devices = [Device]()
    typealias DeviceResponse = ([Device]?, Error?) -> Void
    
    func getDevices(completion: @escaping DeviceResponse) {
        let databaseManager = DatabaseManager()
        
        let networkManager = NetworkManager()
        
        if databaseManager.getDevicesFromDatabase().count == 0 {
            networkManager.getDevicesFromServer() { [weak self] result, error in
                if let error = error {
                    completion(nil, error)
                } else if let result = result {
                    self?.devices = result
                    databaseManager.writeToDatabase(array: result)
                    completion(result, nil)
                }
            }
        }
        else {
            devices = databaseManager.getDevicesFromDatabase()
            completion(databaseManager.getDevicesFromDatabase(), nil)
        }
    }
    
    
}
