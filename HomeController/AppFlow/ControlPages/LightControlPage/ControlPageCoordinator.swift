//
//  ControlPageCoordinator.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation
import UIKit

protocol LightControlPageCoordinatorTransitions: AnyObject {
    
}

final class ControlPageCoordinator {
    private weak var transitions: ControlPageCoordinatorTransitions?
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController,transitions: ControlPageCoordinatorTransitions?){
        self.navigationController = navigationController
        self.transitions = transitions
    }
    
    func start(with device: Device) {
        let controlPageViewController = ControlPageViewController()
        let controlPageViewModel = ControlPageViewModel(with: device)
        controlPageViewModel.coordinator = self
        controlPageViewController.controlPageViewModel = controlPageViewModel
        navigationController.pushViewController(controlPageViewController, animated: true)
    }
    
}
