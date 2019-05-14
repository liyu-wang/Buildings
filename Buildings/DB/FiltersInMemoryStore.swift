//
//  FiltersInMemoryStore.swift
//  Buildings
//
//  Created by Liyu Wang on 14/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// mock in memory store for the filter, rather than passing the filters around
// we use this to mimic the behaviour of the rx compatible db (Realm or CoreData)
struct FiltersInMemoryStore {
    
    static let shared = FiltersInMemoryStore()
    
    let countries: BehaviorRelay<[String]>
    let cities: BehaviorRelay<[String]>
    
    let selectedCountries: BehaviorRelay<Set<String>>
    let selectedCities: BehaviorRelay<Set<String>>
    
    private init() {
        self.countries = BehaviorRelay<[String]>(value: [])
        self.cities = BehaviorRelay<[String]>(value: [])
        self.selectedCountries = BehaviorRelay<Set<String>>(value: [])
        self.selectedCities = BehaviorRelay<Set<String>>(value: [])
    }
    
}

extension FiltersInMemoryStore {
    
    func loadSelectedCountries() -> Set<String> {
        return self.selectedCountries.value
    }
    
    func loadSelectedCities() -> Set<String> {
        return self.selectedCities.value
    }
    
    func save(countries: Set<String>, cities: Set<String>) {
        self.countries.accept(countries.sorted())
        self.cities.accept(cities.sorted())
    }
    
    func save(selectedSountries: Set<String>, selectedeCities: Set<String>) {
        if selectedSountries != self.selectedCountries.value {
            self.selectedCountries.accept(selectedSountries)
        }
        if selectedeCities != self.selectedCities.value {
            self.selectedCities.accept(selectedeCities)
        }
    }

}
