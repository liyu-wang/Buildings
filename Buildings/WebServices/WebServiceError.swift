//
//  WebServiceError.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case invalidUrl(String)
    case serviceFailed(String)
}
