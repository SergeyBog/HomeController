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
    
    func start(with device: RollerShutter) {
        let rollerShutterControlPageViewController = RollerShutterControlPageViewController()
        let rollerShutterControlPageViewModel = RollerShutterControlPageViewModel(with: device)
        rollerShutterControlPageViewModel.coordinator = self
        rollerShutterControlPageViewController.rollerShutterControlPageViewModel = rollerShutterControlPageViewModel
        navigationController.pushViewController(rollerShutterControlPageViewController, animated: true)
    }
    
    func updateInfo() {
        transitions?.updateInfoRollerShutter()
    }
}
