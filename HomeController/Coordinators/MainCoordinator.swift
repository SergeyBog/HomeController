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
        homePageCoordinator = nil
        homePageCoordinator = HomePageCoordinator(navigationController: rootNav, transitions: self)
        homePageCoordinator?.start()
        window.rootViewController = rootNav
        window.makeKeyAndVisible()
    }
    
    func startLightControlPage(deviceId: Int) {
        
        let lightControlPageCoordinator = LightControlPageCoordinator(navigationController: rootNav, transitions: self)

        lightControlPageCoordinator.start(with: deviceId)
    }
    
    func startHeaterControlPage(deviceId: Int) {
        
        let heaterControlPageCoordinator = HeaterControlPageCoordinator(navigationController: rootNav, transitions: self)
        
        heaterControlPageCoordinator.start(with: deviceId)
    }
    
    func startRollerShutterControlPage(deviceId: Int) {
        
        let rollerShutterControlPageCoordinator = RollerShutterControlPageCoordinator(navigationController: rootNav, transitions: self)
    
        rollerShutterControlPageCoordinator.start(with: deviceId)
    }

}

extension MainCoordinator: HomePageCoordinatorTransitions, LightControlPageCoordinatorTransitions, HeaterControlPageCoordinatorTransitions, RollerShutterControlPageCoordinatorTransitions {
    
    func updateInfoLight() {
        startHomePage()
    }
    
    func updateInfoHeater() {
        startHomePage()
    }
    
    func updateInfoRollerShutter() {
       startHomePage()
    }

    func seeDevicesDetails(with device: Device) {
        
        if device.productType == "Light" {
            startLightControlPage(deviceId: device.id)
        }
        else if device.productType == "Heater" {
            startHeaterControlPage(deviceId: device.id)
        }
        else {
            startRollerShutterControlPage(deviceId: device.id)
        }
        
    }
}
