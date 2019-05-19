//
//  FiltersCoordinator.swift
//  Buildings
//
//  Created by Liyu Wang on 18/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

class FiltersCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FiltersViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
