//
//  ControlPageViewModel.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation

final class LightControlPageViewModel {
    
    var selectedDevice: Light
    var coordinator: LightControlPageCoordinator?
    var reloadImageView: (() -> ())?
    
    init(with device: Light) {
        self.selectedDevice = device
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateDevice() {
        let databaseManager = DatabaseManager()
        let device = Device(id: selectedDevice.id, deviceName: selectedDevice.deviceName, intensity: selectedDevice.intensity, position: nil, mode: selectedDevice.mode, temperature: nil, productType: "Light")
        databaseManager.updateDevice(deviceToUpdate: device)
    }
}


