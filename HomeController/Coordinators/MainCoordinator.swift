//
//  MainCoordinator.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation
import UIKit
import CoreData

final class MainCoordinator {
   
    private let window: UIWindow
    private let rootNav: UINavigationController = UINavigationController()
    private var homePageCoordinator: HomePageCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func startHomePage() {
        let databaseManager = DatabaseManager()
        if databaseManager.GetAllDevices().count == 0 {
            homePageCoordinator = HomePageCoordinator(navigationController: rootNav, transitions: self)
            homePageCoordinator?.start(getDataFromApi: true, updateData: false
            )
            window.rootViewController = rootNav
            window.makeKeyAndVisible()
        }
        else {
            homePageCoordinator = HomePageCoordinator(navigationController: rootNav, transitions: self)
            homePageCoordinator?.start(getDataFromApi: false, updateData: false)
            window.rootViewController = rootNav
            window.makeKeyAndVisible()
        }
    }
    
    func startUpdatedHomePage() {
        homePageCoordinator = nil
        homePageCoordinator = HomePageCoordinator(navigationController: rootNav, transitions: self)
        homePageCoordinator?.start(getDataFromApi: false, updateData: true)
        window.rootViewController = rootNav
        window.makeKeyAndVisible()
    }
    
    func startLightControlPage(with device: Device) {
        
        let lightControlPageCoordinator = LightControlPageCoordinator(navigationController: rootNav, transitions: self)
        
       let lightDevice = Light(id: device.id, deviceName: device.deviceName, intensity: device.intensity ?? 0, mode: device.mode ?? "OFF")
        

        lightControlPageCoordinator.start(with: lightDevice)
    }
    
    func startHeaterControlPage(with device: Device) {
        
        let heaterControlPageCoordinator = HeaterControlPageCoordinator(navigationController: rootNav, transitions: self)
        
        let heaterDevice = Heater(id: device.id, deviceName: device.deviceName, mode: device.mode ?? "Off", temperature: Float(device.temperature ?? 0))
        
        heaterControlPageCoordinator.start(with: heaterDevice)
    }
    
    func startRollerShutterControlPage(with device: Device) {
        
        let rollerShutterControlPageCoordinator = RollerShutterControlPageCoordinator(navigationController: rootNav, transitions: self)
        
        var deviceMode = String()
        
        if device.position == 0 {
            deviceMode = "Off"
        } else {
            deviceMode = "On"
        }
        
        let rollerShutterDevice = RollerShutter(id: device.id, deviceName: device.deviceName, position: device.position ?? 0, mode: deviceMode)
        
        rollerShutterControlPageCoordinator.start(with: rollerShutterDevice)
    }
    
   
}

extension MainCoordinator: HomePageCoordinatorTransitions, LightControlPageCoordinatorTransitions, HeaterControlPageCoordinatorTransitions, RollerShutterControlPageCoordinatorTransitions {
    
    func updateInfoLight() {
        startUpdatedHomePage()
    }
    
    func updateInfoHeater() {
        startUpdatedHomePage()
    }
    
    func updateInfoRollerShutter() {
       startUpdatedHomePage()
    }

    func seeDevicesDetails(with device: Device) {
        
        if device.productType == "Light" {
            startLightControlPage(with: device)
        }
        else if device.productType == "Heater" {
            startHeaterControlPage(with: device)
        }
        else {
            startRollerShutterControlPage(with: device)
        }
        
    }
}
