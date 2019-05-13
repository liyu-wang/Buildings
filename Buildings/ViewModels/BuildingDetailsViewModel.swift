//
//  BuildingDetailsViewModel.swift
//  Buildings
//
//  Created by Liyu Wang on 13/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BuildingDetailsViewModel {
    // Outgoing
    let building: BehaviorRelay<Building>
    
    private let bag = DisposeBag()
    
    init(with building: Building) {
        self.building = BehaviorRelay(value: building)
    }
}
