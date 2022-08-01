//
//  HeaterControlCoordinator.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import Foundation
import UIKit

protocol HeaterControlPageCoordinatorTransitions: AnyObject {
    func updateInfoHeater()
}

final class HeaterControlPageCoordinator {
    private weak var transitions: HeaterControlPageCoordinatorTransitions?
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController,transitions: HeaterControlPageCoordinatorTransitions?){
        self.navigationController = navigationController
        self.transitions = transitions
    }
    
    func start(with deviceId: Int) {
        let databaseManager = DatabaseManager()
        let heaterControlPageViewModel = HeaterControlPageViewModel(with: databaseManager.getHeaterDevice(with: deviceId))
        heaterControlPageViewModel.coordinator = self
        let heaterControlPageViewController = HeaterControlPageViewController(with: heaterControlPageViewModel)
        navigationController.pushViewController(heaterControlPageViewController, animated: true)
    }
    
    func updateInfo() {
        transitions?.updateInfoHeater()
    }
    
}
