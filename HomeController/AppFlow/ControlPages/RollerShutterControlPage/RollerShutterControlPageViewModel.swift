//
//  RollerSgutterControlPageViewModel.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import Foundation

final class RollerShutterControlPageViewModel {
    
    var selectedDevice: RollerShutter
    var coordinator: RollerShutterControlPageCoordinator?
    var reloadImageView: (() -> ())?
    
    init(with device: RollerShutter) {
        self.selectedDevice = device
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateDevice() {
        let databaseManager = DatabaseManager()
        let device = Device(id: selectedDevice.id, deviceName: selectedDevice.deviceName, intensity: nil, position: selectedDevice.position, mode: selectedDevice.mode, temperature: nil, productType: "RollerShutter")
        databaseManager.updateDevice(deviceToUpdate: device)
    }
    
}
