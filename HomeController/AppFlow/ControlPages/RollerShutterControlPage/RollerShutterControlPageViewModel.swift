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
    
    init(with device: RollerShutter) {
        self.selectedDevice = device
    }
    
    func getDeviceName() -> String {
        return selectedDevice.deviceName.localized()
    }
    
    func getDevicePositionInFloat() -> Float {
        return Float(selectedDevice.position)
    }
    
    func getDevicePositionInString() -> String {
        return String(selectedDevice.position)
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
        let databaseManager = DatabaseManager()
        databaseManager.updateRollershutterDevice(deviceToUpdate: selectedDevice)
    }
    
}
