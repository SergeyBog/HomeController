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
    
    func start(with device: Light) {
        let lightControlPageViewController = LightControlPageViewController()
        let lightControlPageViewModel = LightControlPageViewModel(with: device)
        lightControlPageViewModel.coordinator = self
        lightControlPageViewController.lightControlPageViewModel = lightControlPageViewModel
        navigationController.pushViewController(lightControlPageViewController, animated: true)
    }
    
    func updateInfo() {
        transitions?.updateInfoLight()
    }
    
}
