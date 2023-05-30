//
//  CardResponse.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import Foundation

struct CardResponse: Decodable {
    let basic: [Card]
    let classic: [Card]
    let hallOfFame: [Card]
    let missions: [Card]
    let demo: [Card]
    let system: [Card]
    let promo: [Card]
    let naxxramas: [Card]
    let goblinsVsGnomes: [Card]
    let blackrockMountains: [Card]
    let theGrandTournament: [Card]
    let credits: [Card]
    let heroSkins: [Card]
    let tavernBrawl: [Card]
    let theLeagueOfExplorers: [Card]
    let whispersOfTheOldGods: [Card]
    let oneNightinKarazhan: [Card]
    let meanStreetsOfGadgetzan: [Card]
    let journeyToUnGoro: [Card]
    let knightsOfTheFrozenThrone: [Card]
    let koboldsCatacombs: [Card]
    let theWitchwood: [Card]
    let theBoomsdayProject: [Card]
    let rastakhanRumble: [Card]
    let riseOfShadows: [Card]
    let tavernsOfTime: [Card]
    let saviorsOfUldum: [Card]
    let descentOfDragons: [Card]
    let galakrondsAwakening: [Card]
    let ashesOfOutland: [Card]
    let wildEvent: [Card]
    let scholomanceAcademy: [Card]
    let battlegrounds: [Card]
    let demonHunterInitiate: [Card]
    let madnessAtTheDarkmoonFaire: [Card]
    let forgedInTheBarrens: [Card]
    let legacy: [Card]
    let core: [Card]
    let vanilla: [Card]
    let wailingCaverns: [Card]
    let unitedInStormwind: [Card]
    let mercenaries: [Card]
    let fracturedInAlteracValley: [Card]
    let voyageToTheSunkenCity: [Card]
    let unknown: [Card]
    let murderAtCastleNathria: [Card]
    let marchOfTheLichKing: [Card]
    let pathOfArthas: [Card]
    let festivalOfLegends: [Card]
    
    
    var allCards: [Card] {
        basic + classic + hallOfFame + missions + demo + system + promo + naxxramas + goblinsVsGnomes + blackrockMountains + theGrandTournament + credits + heroSkins + tavernBrawl + theLeagueOfExplorers + whispersOfTheOldGods + oneNightinKarazhan + meanStreetsOfGadgetzan + journeyToUnGoro + knightsOfTheFrozenThrone + koboldsCatacombs + theWitchwood + theBoomsdayProject + rastakhanRumble + riseOfShadows + tavernsOfTime + saviorsOfUldum + descentOfDragons + galakrondsAwakening + ashesOfOutland + wildEvent + scholomanceAcademy + battlegrounds + demonHunterInitiate + madnessAtTheDarkmoonFaire + forgedInTheBarrens + legacy + core + vanilla + wailingCaverns + unitedInStormwind + mercenaries + fracturedInAlteracValley + voyageToTheSunkenCity + unknown + murderAtCastleNathria + marchOfTheLichKing + pathOfArthas + festivalOfLegends
    }

    
    enum CodingKeys: String, CodingKey {
        case basic = "Basic"
        case classic = "Classic"
        case hallOfFame = "Hall of Fame"
        case missions = "Missions"
        case demo = "Demo"
        case system = "System"
        case promo = "Promo"
        case naxxramas = "Naxxramas"
        case goblinsVsGnomes = "Goblins vs Gnomes"
        case blackrockMountains = "Blackrock Mountain"
        case theGrandTournament = "The Grand Tournament"
        case credits = "Credits"
        case heroSkins = "Hero Skins"
        case tavernBrawl = "Tavern Brawl"
        case theLeagueOfExplorers = "The League of Explorers"
        case whispersOfTheOldGods = "Whispers of the Old Gods"
        case oneNightinKarazhan = "One Night in Karazhan"
        case meanStreetsOfGadgetzan = "Mean Streets of Gadgetzan"
        case journeyToUnGoro = "Journey to Un'Goro"
        case knightsOfTheFrozenThrone = "Knights of the Frozen Throne"
        case koboldsCatacombs = "Kobolds & Catacombs"
        case theWitchwood = "The Witchwood"
        case theBoomsdayProject = "The Boomsday Project"
        case rastakhanRumble = "Rastakhan's Rumble"
        case riseOfShadows = "Rise of Shadows"
        case tavernsOfTime = "Taverns of Time"
        case saviorsOfUldum = "Saviors of Uldum"
        case descentOfDragons = "Descent of Dragons"
        case galakrondsAwakening = "Galakrond's Awakening"
        case ashesOfOutland = "Ashes of Outland"
        case wildEvent = "Wild Event"
        case scholomanceAcademy = "Scholomance Academy"
        case battlegrounds = "Battlegrounds"
        case demonHunterInitiate = "Demon Hunter Initiate"
        case madnessAtTheDarkmoonFaire = "Madness At The Darkmoon Faire"
        case forgedInTheBarrens = "Forged in the Barrens"
        case legacy = "Legacy"
        case core = "Core"
        case vanilla = "Vanilla"
        case wailingCaverns = "Wailing Caverns"
        case unitedInStormwind = "United in Stormwind"
        case mercenaries = "Mercenaries"
        case fracturedInAlteracValley = "Fractured in Alterac Valley"
        case voyageToTheSunkenCity = "Voyage to the Sunken City"
        case unknown = "Unknown"
        case murderAtCastleNathria = "Murder at Castle Nathria"
        case marchOfTheLichKing = "March of the Lich King"
        case pathOfArthas = "Path of Arthas"
        case festivalOfLegends = "Festival of Legends"
    }
}

