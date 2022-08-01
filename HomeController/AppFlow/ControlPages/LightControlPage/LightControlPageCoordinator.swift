//
//  ControlPageCoordinator.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation
import UIKit

protocol LightControlPageCoordinatorTransitions: AnyObject {
    func updateInfoLight()
}

final class LightControlPageCoordinator {
    private weak var transitions: LightControlPageCoordinatorTransitions?
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController,transitions: LightControlPageCoordinatorTransitions?){
        self.navigationController = navigationController
        self.transitions = transitions
    }
    
    func start(with deviceId: Int) {
        let databaseManager = DatabaseManager()
        let lightControlPageViewModel = LightControlPageViewModel(with: databaseManager.getLightDevice(with: deviceId))
        lightControlPageViewModel.coordinator = self
        let lightControlPageViewController = LightControlPageViewController(with: lightControlPageViewModel)
        navigationController.pushViewController(lightControlPageViewController, animated: true)
    }
    
    
    func updateInfo() {
        transitions?.updateInfoLight()
    }
    
}
