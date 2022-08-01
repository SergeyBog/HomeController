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

    init(with device: Heater) {
        self.selectedDevice = device
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateMode(with mode: String) {
        selectedDevice.mode = mode
        updateDevice()
    }
    
    func updateTemperature(with value: Float) {
        selectedDevice.temperature = value
        updateDevice()
    }
    
    func updateDevice() {
        let databaseManager = DatabaseManager()
        databaseManager.updateHeaterDevice(deviceToUpdate: selectedDevice)
    }
}
