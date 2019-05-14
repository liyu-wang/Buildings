//
//  BuidlingsWebServiceImpl.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

private let baseUrl = "https://gist.githubusercontent.com/Lachlanbsmith/c5eb3b858ff810febd3dfbd5960d3fd8/raw/64a0ba3ee02d52536157d2dd01dddb1069175a8f"

struct BuildingsWebServiceImpl: BuildingsWebService {
    
    init() {
        Logging.URLRequests = { _ in false }
    }
    
    func fetchBuildings() -> Observable<[Building]> {
        let path = "/buildings"
        guard let url = URL(string: baseUrl + path) else {
            return Observable.error(WebServiceError.InvalidUrl("invalid url!"))
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        return URLSession.shared.rx.response(request: request)
            .debug("GET \(path)")
            .flatMap { response, data -> Observable<[Building]> in
                if 200 ..< 300 ~= response.statusCode {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let buildings = try jsonDecoder.decode([Building].self, from: data)
                        return Observable.just(buildings)
                    } catch {
                        // json parsing error
                        return Observable.error(error)
                    }
                } else {
                    let error = WebServiceError.serviceFailed("service failed with code: \(response.statusCode)")
                    return Observable.error(error)
                }
            }
    }
}
