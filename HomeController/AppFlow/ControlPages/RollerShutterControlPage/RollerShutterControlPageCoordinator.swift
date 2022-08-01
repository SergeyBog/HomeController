//
//  RollerShutterControlPageCoordinator.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import Foundation
import UIKit

protocol RollerShutterControlPageCoordinatorTransitions: AnyObject {
    func updateInfoRollerShutter()
}

final class RollerShutterControlPageCoordinator {
    private weak var transitions: RollerShutterControlPageCoordinatorTransitions?
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController,transitions: RollerShutterControlPageCoordinatorTransitions?){
        self.navigationController = navigationController
        self.transitions = transitions
    }
    
    func start(with deviceId: Int) {

        let databaseManager = DatabaseManager()
        let rollerShutterControlPageViewModel = RollerShutterControlPageViewModel(with: databaseManager.getRollershutterDevice(with: deviceId))
        
        rollerShutterControlPageViewModel.coordinator = self
        
        let rollerShutterControlPageViewController = RollerShutterControlPageViewController(with: rollerShutterControlPageViewModel)
        navigationController.pushViewController(rollerShutterControlPageViewController, animated: true)
    }
    
    func updateInfo() {
        transitions?.updateInfoRollerShutter()
    }
}
