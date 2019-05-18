//
//  MainCoordinator.swift
//  Buildings
//
//  Created by Liyu Wang on 18/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BuildingsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}

extension MainCoordinator {
    func showFilters() {
        let vc = FiltersViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showBuildingDetails(for building: Building) {
        let vc = BuildingDetailsViewController.instantiate()
        vc.viewModel = BuildingDetailsViewModel(with: building)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
