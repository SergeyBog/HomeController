//
//  HeaterControlPageViewModel.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import Foundation

final class HeaterControlPageViewModel {
    
    var selectedDevice: Heater
    var coordinator: HeaterControlPageCoordinator?
    var reloadImageView: (() -> ())?
    
    init(with device: Heater) {
        self.selectedDevice = device
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateDevice() {
        let databaseManager = DatabaseManager()
        let device = Device(id: selectedDevice.id, deviceName: selectedDevice.deviceName, intensity: nil, position: nil, mode: selectedDevice.mode, temperature: selectedDevice.temperature, productType: "Heater")
        databaseManager.updateDevice(deviceToUpdate: device)
    }
}
