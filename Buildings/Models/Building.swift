//
//  Building.swift
//  Buildings
//
//  Created by Liyu Wang on 10/5/19.
//  Copyright © 2019 Liyu Wang. All rights reserved.
//

import Foundation

enum ProductAction: String, Codable {
    case assetMap = "AssetViewOnMap"
    case assetExplorer = "AssetExplorer"
    case assetRegister = "AssetRegister"
    
    var title: String {
        switch self {
        case .assetMap:
            return "View on map"
        case .assetExplorer:
            return "Go to Explorer"
        case .assetRegister:
            return "Register"
        }
    }
}

class Building : Codable {
    let id: Int
    let name: String
    let clientId: Int
    let clientName: String
    let address: Address
    var availableProducts: [ProductAction]
    let imageUrl: String
    var registered = false
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.clientId = try container.decode(Int.self, forKey: .clientId)
        self.clientName = try container.decode(String.self, forKey: .clientName)
        self.address = try container.decode(Address.self, forKey: .address)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
        let actionList = try container.decode([String].self, forKey: .availableProducts)
        self.availableProducts = [ProductAction.assetMap]
        for action in actionList {
            if let productAction = ProductAction(rawValue: action) {
                self.availableProducts.append(productAction)
            }
        }
    }
    
}

class Address: Codable {
    let id: String
    let line1: String?
    let line2: String?
    let city: String
    let state: String?
    let zipCode: String
    let country: String
    let longitude: Double
    let latitude: Double
}
