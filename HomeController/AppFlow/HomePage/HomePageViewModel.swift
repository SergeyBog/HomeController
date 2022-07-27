//
//  HomePageViewModel.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation

final class HomePageViewModel {
    
    var coordinator: HomePageCoordinator?
    var devices = [Device]()
    var reloadTableView: (() -> ())?
    var needToGetDataFromApi = Bool()
    var needToUpdateData = Bool()
    
    init(getDataFromApi: Bool, updateData: Bool) {
        self.needToGetDataFromApi = getDataFromApi
        self.needToUpdateData = updateData
    }
    
    func getDevices() {
        if needToGetDataFromApi == true {
            let manager = NetworkManager()
            let databaseManager = DatabaseManager()
            
            manager.getDevices() { [weak self] result, error in
                if let error = error {
                    print(error)
                } else if let result = result {
                    self?.devices = result
                    databaseManager.writeToDatabase(array: result)
                    self?.reloadTableView?()
                }
            }
        } else {
            ///get devices from db
            let databaseManager = DatabaseManager()
            let result = databaseManager.GetAllDevices()
            devices = result.sorted {
                $0.id < $1.id
            }
            
        }
    }
    
    func seeDetails(with device: Device) {
        coordinator?.seeDetails(with: device)
    }
    
}
