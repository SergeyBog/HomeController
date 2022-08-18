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
    let databaseManager = DatabaseManager()
    
    var sliderValueChange: (() -> ())?
    
    init(with deviceId: Int) {
        self.selectedDevice = databaseManager.getRollershutterDevice(with: deviceId)
    }
    
    func getDeviceName() -> String {
        return selectedDevice.deviceName.localized()
    }
    
    func getDevicePositionInFloat() -> Float {
        return Float(selectedDevice.position)/100
    }
    
    func getDevicePositionInString() -> String {
        return "position.Word".localized() + ": " + String(selectedDevice.position) 
    }
    
    func updateInfo() {
        coordinator?.updateInfo()
    }
    
    func updateData(with value: Float) {
        
        if value == 0 {
            selectedDevice.mode = "open.Word".localized()
            selectedDevice.position = Int(value)
            updateDevice()
            
        } else if value > 0 && value < 100  {
            selectedDevice.mode =  "openAt.Word".localized()
            selectedDevice.position = Int(value)
            updateDevice()
            
        } else {
            selectedDevice.mode =  "closed.Word".localized()
            selectedDevice.position = Int(value)
            updateDevice()
        }
    }
    
    func updateDevice() {
        databaseManager.updateRollershutterDevice(deviceToUpdate: selectedDevice)
    }
    
    func positionValueChanged(sliderValue: Float) -> String {
        
        let value = (sliderValue * 100).rounded(.up)
        updateData(with: value)
        return "position.Word".localized() + ": " + String(Int(value))
    }
    
}
