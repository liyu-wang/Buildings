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
        
        vc.showFiltersAction = {
            let vc = FiltersViewController.instantiate()
            self.navigationController.pushViewController(vc, animated: true)
        }
        
        vc.showBuildingDetailsAction = { building in
            let vc = BuildingDetailsViewController.instantiate()
            vc.viewModel = BuildingDetailsViewModel(with: building)
            self.navigationController.pushViewController(vc, animated: true)
        }
        
        navigationController.pushViewController(vc, animated: false)
    }
}

/*
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
*/
