//
//  HomePageCoordinator.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation
import UIKit

protocol HomePageCoordinatorTransitions: AnyObject {
    func seeDevicesDetails(with: Device)
}

final class HomePageCoordinator {
    private weak var transitions: HomePageCoordinatorTransitions?
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController,transitions: HomePageCoordinatorTransitions?){
        self.navigationController = navigationController
        self.transitions = transitions
    }
    
    func start(getDataFromApi: Bool, updateData: Bool) {
        let homePageTableViewController = HomePageTableViewController()
        let homePageViewModel = HomePageViewModel(getDataFromApi: getDataFromApi, updateData: updateData)
        homePageViewModel.coordinator = self
        homePageTableViewController.homePageViewModel = homePageViewModel
        navigationController.setViewControllers([homePageTableViewController], animated: false)
    }
    
    func seeDetails(with device: Device) {
        transitions?.seeDevicesDetails(with: device)
    }
    
}
