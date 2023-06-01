//
//  CardListViewModelMock.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import Foundation
@testable import HearthstoneAPIConsumer

class CardListViewModelMock: CardListViewModel {
    override func fetchCards() {
        if let data = loadMockDataFromJSONFile() {
            let cards = parseCardsFromData(data)
            self.cards = cards
            self.delegate?.cardsFetched()
        } else {
            let error = NSError(domain: "CardListViewModelMock", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load mock data."])
            self.delegate?.cardsFetchFailed(withError: error)
        }
    }
    
    private func loadMockDataFromJSONFile() -> Data? {
        if let path = Bundle.main.path(forResource: "cards_mock", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("Failed to load mock data from JSON file: \(error)")
            }
        }
        return nil
    }
    
    private func parseCardsFromData(_ data: Data) -> [Card] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let cardResponse = try decoder.decode(CardResponse.self, from: data)
            return cardResponse.allCards
        } catch {
            print("Failed to parse mock cards data: \(error)")
        }
        return []
    }
}
