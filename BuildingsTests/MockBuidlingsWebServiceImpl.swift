//
//  MockBuidlingsWebServiceImpl.swift
//  BuildingsTests
//
//  Created by Liyu Wang on 15/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
@testable import Buildings

class MockBuidlingsWebServiceImpl : BuildingsWebService {
    
    func fetchBuildings() -> Observable<[Building]> {
        guard let path = Bundle(for: type(of: self)).path(forResource: "buildings", ofType: "json") else {
            return Observable.error(WebServiceError.invalidUrl("bad url"))
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            let buildings = try jsonDecoder.decode([Building].self, from: data)
            return Observable.just(buildings)
        } catch {
            // handle error
            return Observable.error(error)
        }
    }
    
}
