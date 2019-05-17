//
//  BuildingsTests.swift
//  BuildingsTests
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import Buildings

class BuildingsTests: XCTestCase {

    private let buildingsViewModel = BuildingsViewModel(buildingWebService: MockBuidlingsWebServiceImpl())
    private var bag = DisposeBag()
    
    override func setUp() {
        // load buildings via MockBuidlingsWebServiceImpl from local json file in the app bundle
        buildingsViewModel.fetchBuildings()
    }

    override func tearDown() {
        // dispose all disposables
        self.bag = DisposeBag()
        
        // clear countries and cities in in-memory db
        FiltersInMemoryStore.shared.save(countries: [], cities: [])
        // clear selected countries and cities in in-memory db
        FiltersInMemoryStore.shared.save(selectedSountries: [], selectedeCities: [])
    }

    func testMockServiceLoadingSuccess() {
        buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // 4 buildings in total
                    XCTAssert(buildings.count == 4)
                },
                onError: { error in
                    XCTFail()
                }
            )
            .disposed(by: bag)
    }
    
    func testCountryFilterOnly() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: ["Germany"], selectedeCities: [])
        
        buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // only 1 building in Germany
                    XCTAssert(buildings.count == 1)
                },
                onError: { error in
                    XCTFail()
                }
            )
            .disposed(by: bag)
    }
    
    func testCityFilterOnly() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: [], selectedeCities: ["Sydney"])
        
        buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // 2 buildings in sydney
                    XCTAssert(buildings.count == 2)
                },
                onError: { error in
                    XCTFail()
                }
            )
            .disposed(by: bag)
    }
    
    func testCountryAndCityFilters() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: ["Germany"], selectedeCities: ["Sydney"])
        
        buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // no buildings in sydney Germany
                    XCTAssert(buildings.count == 0)
                },
                onError: { error in
                    XCTFail()
                }
            )
            .disposed(by: bag)
    }
    
}

extension BuildingsTests {
    
    func testCountryAndCityFiltersWithBlocking() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: ["Germany"], selectedeCities: ["Sydney"])
        
        do {
            let result = try buildingsViewModel.buildings.toBlocking().first()
            XCTAssertEqual(result?.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testClearFilters() {
        let observableToTest = buildingsViewModel.buildings
        
        // apply filters which causes 0 building showing
        FiltersInMemoryStore.shared.save(selectedSountries: ["Germany"], selectedeCities: ["Sydney"])
        
        do {
            let result = try observableToTest.toBlocking().first()
            XCTAssertEqual(result?.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        // clear all filters which should show all buildings
        FiltersInMemoryStore.shared.save(selectedSountries: [], selectedeCities: [])
        
        do {
            let result = try observableToTest.toBlocking().first()
            XCTAssertEqual(result?.count, 4)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
