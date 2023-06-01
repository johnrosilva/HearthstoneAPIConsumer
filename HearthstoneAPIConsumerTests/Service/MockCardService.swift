//
//  MockCardService.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import XCTest
@testable import HearthstoneAPIConsumer

class MockCardService: CardServiceProtocol {
    var shouldReturnError = false
    
    func fetchAllCards(completion: @escaping (Result<[Card], APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.requestFailed(NSError(domain: "", code: 0, userInfo: nil))))
        } else {
            if let path = Bundle.main.path(forResource: "cards_mock", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let cardResponse = try JSONDecoder().decode(CardResponse.self, from: data)
                    completion(.success(cardResponse.allCards))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            } else {
                completion(.failure(.invalidResponse))
            }
        }
    }
    
    func getCard(withID id: String, completion: @escaping (Result<CardDetails, APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.requestFailed(NSError(domain: "", code: 0, userInfo: nil))))
        } else {
            if let path = Bundle.main.path(forResource: "card_detail_mock", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let response = try JSONDecoder().decode([CardDetails].self, from: data)
                    if let cardDetails = response.first {
                        completion(.success(cardDetails))
                    } else {
                        completion(.failure(.decodingFailed(APIError.invalidResponse)))
                    }
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            } else {
                completion(.failure(.invalidResponse))
            }
        }
    }
}
