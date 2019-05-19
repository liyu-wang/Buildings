//
//  Coordinators.swift
//  Buildings
//
//  Created by Liyu Wang on 18/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
