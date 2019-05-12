//
//  Building.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation

struct Building : Codable {
    var id: Int
    var name: String
    var clientId: Int
    var clientName: String
    var address: Address
    var availableProducts: [String]
    var imageUrl: String
}

struct Address: Codable {
    var id: String
    var line1: String?
    var line2: String?
    var city: String
    var state: String?
    var zipCode: String
    var country: String
    var longitude: Double
    var latitude: Double
}
