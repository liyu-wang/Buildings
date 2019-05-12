//
//  WebServiceTests.swift
//  BuildingsTests
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Buildings

class WebServiceTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    private var buildingWerbService: BuildingsWebService!
    
    override func setUp() {
        self.buildingWerbService = BuildingsWebServiceImpl()
    }

    override func tearDown() {
        self.buildingWerbService = nil
    }

    func testFetchBuildingsSuccess() {
        let promise = expectation(description: "restful api called with response.")
        
        var buildingList: [Building]?
        var error: Error?
        
        self.buildingWerbService
            .fetchBuildings()
            .subscribe(
                onNext: { buildings in
                    print("\(buildings)")
                    buildingList = buildings
                },
                onError: { err in
                    print("\(err)")
                    error = err
                },
                onDisposed: {
                    promise.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(buildingList)
        XCTAssertNil(error)
    }
    
    func testFetchBuildingsFailed() {
        
    }

}
