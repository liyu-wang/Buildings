//
//  BuildingsViewModel.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BuildingsViewModel {
    
    // Outgoing
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMsg = BehaviorRelay<String?>(value: nil)
    let buildings = BehaviorRelay<[Building]>(value: [])
    
    private let bag = DisposeBag()
    private let buildingWebService: BuildingsWebService
    
    init(buildingWebService: BuildingsWebService = BuildingsWebServiceImpl()) {
        self.buildingWebService = buildingWebService
    }
    
}

extension BuildingsViewModel {
    
    func fetchBuildings() {
        self.isLoading.accept(true)
        
        self.buildingWebService.fetchBuildings()
            .subscribe(
                onNext: { buildingList in
                    self.buildings.accept(buildingList)
                },
                onError: { err in
                    self.errorMsg.accept(err.localizedDescription)
                },
                onDisposed: {
                    self.isLoading.accept(false)
                }
            )
            .disposed(by: bag)
    }
    
    func building(at index: Int) -> Building {
        return self.buildings.value[index]
    }
    
}
