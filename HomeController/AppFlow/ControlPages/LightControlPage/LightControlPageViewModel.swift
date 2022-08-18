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
    let databaseManager = DatabaseManager()
    
    init(with deviceId: Int) {
        self.selectedDevice = databaseManager.getLightDevice(with: deviceId)
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
        return Float(selectedDevice.intensity)/100
    }
    
    func getDeviceIntensityInString() -> String {
        return "intensity.Word".localized() + ": " + String(selectedDevice.intensity)
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateMode(with mode: String) {
        selectedDevice.mode = mode
        updateDevice()
    }
    
    private func updateIntensity(with value: Int) {
        selectedDevice.intensity = value
        updateDevice()
    }
    
    func updateDevice() {
        databaseManager.updateLightDevice(deviceToUpdate: selectedDevice)
    }
    
    func intentsityValueChanged(sliderValue: Float) -> String {
        let value = Int((sliderValue * 100).rounded(.up))
        updateIntensity(with: value)
        return "intensity.Word".localized() + ": " + String(value)
    }
}


