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
    
    func start(with device: Heater) {
        let heaterControlPageViewController = HeaterControlPageViewController()
        let heaterControlPageViewModel = HeaterControlPageViewModel(with: device)
        heaterControlPageViewModel.coordinator = self
        heaterControlPageViewController.heaterControlPageViewModel = heaterControlPageViewModel
        navigationController.pushViewController(heaterControlPageViewController, animated: true)
    }
    
    func updateInfo() {
        transitions?.updateInfoHeater()
    }
    
}
