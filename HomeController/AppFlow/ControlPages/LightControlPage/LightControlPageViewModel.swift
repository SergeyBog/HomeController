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
    
    init(with device: Light) {
        self.selectedDevice = device
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateMode(with mode: String) {
        selectedDevice.mode = mode
        updateDevice()
    }
    
    func updateIntensity(with value: Int) {
        selectedDevice.intensity = value
        updateDevice()
    }
    
    func updateDevice() {
        let databaseManager = DatabaseManager()
        databaseManager.updateLightDevice(deviceToUpdate: selectedDevice)
    }
}


