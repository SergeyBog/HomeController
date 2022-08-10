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
    
    func getDeviceName() -> String {
        return selectedDevice.deviceName.localized()
    }
    
    func getDeviceMode() -> Int {
        var result = Int()
        
        if selectedDevice.mode == "on.Word".localized() || selectedDevice.mode == "ON" {
            result = 0
        } else {
           result = 1
        }
    
        return result
    }
    
    func getDeviceIntensityInFloat() -> Float {
        return Float(selectedDevice.intensity)
    }
    
    func getDeviceIntensityInString() -> String {
        return String(selectedDevice.intensity)
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


