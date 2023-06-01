//
//  CardServiceConfigurator.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 01/06/23.
//

import Foundation

struct CardServiceConfiguration {
    let baseURL: String
    let headers: [String: String]
}

class CardServiceConfigurator {
    static let shared = CardServiceConfigurator()
    
    private init() {}
    
    func configure() -> CardServiceConfiguration {
        let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com"
        let headers = [
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "a917dd62f1msh7eace64eef7af1bp1a748fjsne76c256ff8cc"
        ]
        
        return CardServiceConfiguration(baseURL: baseURL, headers: headers)
    }
}
