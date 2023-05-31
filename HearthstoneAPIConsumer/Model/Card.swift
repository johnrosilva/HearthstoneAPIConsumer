//
//  Card.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import Foundation

struct Card: Codable {
    let cardId: String?
    let name: String?
    let cardSet: String?
    let type: String?
    let faction: String?
    let rarity: String?
    let cost: Int?
    let attack: Int?
    let health: Int?
    let flavor: String?
    let text: String?
    let img: String?

    enum CodingKeys: String, CodingKey {
        case cardId = "cardId"
        case name = "name"
        case cardSet = "cardSet"
        case type = "type"
        case faction = "faction"
        case rarity = "rarity"
        case cost = "cost"
        case attack = "attack"
        case health = "health"
        case flavor = "flavor"
        case text = "text"
        case img = "img"
    }
}

struct CardDetails: Codable {
    let cardImageURL: String?
    let name: String?
    let flavorText: String?
    let shortDescription: String?
    let cardSet: String?
    let type: String?
    let faction: String?
    let rarity: String?
    let attack: Int?
    let cost: Int?
    let health: Int?

    enum CodingKeys: String, CodingKey {
        case cardImageURL = "img"
        case name
        case flavorText = "flavor"
        case shortDescription = "text"
        case cardSet = "cardSet"
        case type
        case faction
        case rarity
        case attack
        case cost
        case health
    }
}


