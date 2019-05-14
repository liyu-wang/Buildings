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

class BuildingsViewModel {
    
    // Outgoing
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMsg = BehaviorRelay<String?>(value: nil)
    let buildings = BehaviorRelay<[Building]>(value: [])
    
    private let bag = DisposeBag()
    private let buildingWebService: BuildingsWebService
    private var allBuildings: [Building] = []
    
    init(buildingWebService: BuildingsWebService = BuildingsWebServiceImpl()) {
        self.buildingWebService = buildingWebService
        
        Observable.combineLatest(FiltersInMemoryStore.shared.selectedCountries, FiltersInMemoryStore.shared.selectedCities)
            .subscribe(
                onNext: { countryFilters, cityFilters in
                    self.applyFilters(counties: countryFilters, cities: cityFilters)
                }
            )
            .disposed(by: bag)
    }
    
}

extension BuildingsViewModel {
    
    private func saveFilters(from buildings: [Building]) {
        var citySet = Set<String>()
        var countrySet = Set<String>()
        for building in buildings {
            citySet.insert(building.address.country)
            countrySet.insert(building.address.city)
        }
        
        FiltersInMemoryStore.shared.save(countries: citySet, cities: countrySet)
    }
    
    private func applyFilters(counties: Set<String>, cities: Set<String>) {
        var array : [Building] = []
        if counties.count > 0 && cities.count > 0 {
            // both country and city filters are active
            array = self.allBuildings.filter { counties.contains($0.address.country) && cities.contains($0.address.city) }
        } else if counties.count > 0 && cities.count == 0 {
            // only country filter is active
            array = self.allBuildings.filter { counties.contains($0.address.country) }
        } else if counties.count == 0 && cities.count > 0 {
            // only city filter is active
            array = self.allBuildings.filter { cities.contains($0.address.city) }
        } else if counties.count == 0 && cities.count == 0 {
            // no filters applied should show all buildings
            array = self.allBuildings
        }
        self.buildings.accept(array)
    }
    
}

extension BuildingsViewModel {
    
    func fetchBuildings() {
        self.isLoading.accept(true)
        
        self.buildingWebService.fetchBuildings()
            .subscribe(
                onNext: { [weak self] buildingList in
                    guard let this = self else { return }
                    
                    this.allBuildings = buildingList
                    this.buildings.accept(buildingList)
                    this.saveFilters(from: buildingList)
                },
                onError: { [weak self] err in
                    self?.errorMsg.accept(err.localizedDescription)
                },
                onDisposed: { [weak self] in
                    self?.isLoading.accept(false)
                }
            )
            .disposed(by: bag)
    }
    
    func building(at index: Int) -> Building {
        return self.buildings.value[index]
    }
    
}
