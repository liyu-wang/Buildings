//
//  MainCoordinator.swift
//  Buildings
//
//  Created by Liyu Wang on 18/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = BuildingsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in self.children.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }
}

extension MainCoordinator {
    func showFilters() {
        let child = FiltersCoordinator(navigationController: self.navigationController)
        self.children.append(child)
        child.start()
    }
    
    func showBuildingDetails(for building: Building) {
        let vc = BuildingDetailsViewController.instantiate()
        vc.viewModel = BuildingDetailsViewModel(with: building)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let filtersViewController = fromViewController as? FiltersViewController {
            childDidFinish(filtersViewController.coordinator)
        }
    }
}
