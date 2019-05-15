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
@testable import Buildings

class BuildingsTests: XCTestCase {

    private let buildingsViewModel = BuildingsViewModel(buildingWebService: MockBuidlingsWebServiceImpl())
    private let bag = DisposeBag()
    
    private var disposable: Disposable?
    
    override func setUp() {
        // load buildings via MockBuidlingsWebServiceImpl from local json file in the app bundle
        buildingsViewModel.fetchBuildings()
    }

    override func tearDown() {
        self.disposable?.dispose()
        
        // clear countries and cities in in-memory db
        FiltersInMemoryStore.shared.save(countries: [], cities: [])
        // clear selected countries and cities in in-memory db
        FiltersInMemoryStore.shared.save(selectedSountries: [], selectedeCities: [])
    }

    func testMockServiceLoadingSuccess() {
        
        self.disposable = buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // 4 buildings in total
                    XCTAssert(buildings.count == 4)
                },
                onError: { error in
                    XCTFail()
                }
            )
    }
    
    func testCountryFilterOnly() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: ["Germany"], selectedeCities: [])
        
        self.disposable = buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // only 1 building in Germany
                    XCTAssert(buildings.count == 1)
                },
                onError: { error in
                    XCTFail()
                }
            )
    }
    
    func testCityFilterOnly() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: [], selectedeCities: ["Sydney"])
        
        self.disposable = buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // 2 buildings in sydney
                    XCTAssert(buildings.count == 2)
            },
                onError: { error in
                    XCTFail()
            }
        )
    }
    
    func testCountryAndCityFilter() {
        // apply country filter
        FiltersInMemoryStore.shared.save(selectedSountries: ["Germany"], selectedeCities: ["Sydney"])
        
        self.disposable = buildingsViewModel.buildings
            .subscribe(
                onNext: { buildings in
                    // no buildings in sydney Germany
                    XCTAssert(buildings.count == 0)
            },
                onError: { error in
                    XCTFail()
            }
        )
    }

}
