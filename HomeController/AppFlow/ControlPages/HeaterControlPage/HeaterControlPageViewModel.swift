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
    let databaseManager = DatabaseManager()

    init(with deviceId: Int) {
        self.selectedDevice = databaseManager.getHeaterDevice(with: deviceId)
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
    
    func getDeviceTemperatureInFloat() -> Float {
        return Float(selectedDevice.temperature)/100
    }
    
    func getDeviceTemperatureInString() -> String {
        return "temperature.Word".localized() + ": " +  String(selectedDevice.temperature) + "°"
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateMode(with mode: String) {
        selectedDevice.mode = mode
        updateDevice()
    }
    
    private func updateTemperature(with value: Float) {
        selectedDevice.temperature = value
        updateDevice()
    }
    
    func updateDevice() {
        databaseManager.updateHeaterDevice(deviceToUpdate: selectedDevice)
    }
    
    func temperatureValueChanged(sliderValue: Float) -> String {
        updateTemperature(with: round(sliderValue * 100 * 2)/2)
        return "temperature.Word".localized() + ": " + String(round(sliderValue * 100 * 2)/2) + "°"
    }
}
