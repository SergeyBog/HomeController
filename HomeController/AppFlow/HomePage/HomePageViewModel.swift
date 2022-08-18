//
//  HomePageViewModel.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation

final class HomePageViewModel {
    
    var coordinator: HomePageCoordinator?
    private var devices = [Device]()
    var reloadTableView: (() -> ())?
  
    func getDevices() {
        let manager = DeviceManager()
        manager.getDevices() {[weak self] result, error in
            if let error = error {
                print(error)
            } else if let result = result {
                self?.devices = result
                self?.reloadTableView?()
            }
        }
    }
    
    func getDevicesCount() -> Int {
        return devices.count
    }
    
    func getDevice(for index: Int) -> Device {
        return devices[index]
    }
    
    func seeDetails(with device: Device) {
        coordinator?.seeDetails(with: device)
    }
    
}
