//
//  FiltersViewModel.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FiltersViewModel {
    
    let countries = BehaviorRelay<[String]>(value: [])
    let cities = BehaviorRelay<[String]>(value: [])
    
    var selectedCountries: Set<String>
    var selectedCities: Set<String>
    
    private let bag = DisposeBag()
    
    init() {
        FiltersInMemoryStore.shared.countries
            .bind(to: countries)
            .disposed(by: bag)
        FiltersInMemoryStore.shared.cities
            .bind(to: cities)
            .disposed(by: bag)
        
        selectedCountries = FiltersInMemoryStore.shared.loadSelectedCountries()
        selectedCities = FiltersInMemoryStore.shared.loadSelectedCities()
    }
    
    deinit {
        self.applyFilters()
    }
}

extension FiltersViewModel {
    func numberOfCountries() -> Int {
        return self.countries.value.count
    }
    
    func numberOfCities() -> Int {
        return self.cities.value.count
    }
    
    func countryOrCityStr(at ip: IndexPath) -> String {
        if ip.section == 0 {
            return self.countries.value[ip.row]
        } else {
            return self.cities.value[ip.row]
        }
    }
}

extension FiltersViewModel {
    
    func isTagSelected(at ip: IndexPath) -> Bool {
        if ip.section == 0 {
            let c = self.countries.value[ip.row]
            return selectedCountries.contains(c)
        } else {
            let c = self.cities.value[ip.row]
            return selectedCities.contains(c)
        }
    }
    
    func update(country: String) {
        if selectedCountries.contains(country) {
            self.selectedCountries.remove(country)
        } else {
            self.selectedCountries.insert(country)
        }
    }
    
    func update(city: String) {
        if selectedCities.contains(city) {
            self.selectedCities.remove(city)
        } else {
            self.selectedCities.insert(city)
        }
    }
    
    func clearSelectedCountries() {
        self.selectedCountries.removeAll()
    }
    
    func clearSelectedCities() {
        self.selectedCities.removeAll()
    }
    
    func applyFilters() {
        FiltersInMemoryStore.shared.save(selectedSountries: selectedCountries, selectedeCities: selectedCities)
    }
    
}
