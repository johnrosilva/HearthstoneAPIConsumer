//
//  CardsService.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

protocol CardServiceProtocol {
    func fetchAllCards(completion: @escaping (Result<[Card], APIError>) -> Void)
    func getCard(withID id: String, completion: @escaping (Result<CardDetails, APIError>) -> Void)
}

class CardService: CardServiceProtocol {
    private let configuration: CardServiceConfiguration
    
    init(configuration: CardServiceConfiguration = CardServiceConfigurator.shared.configure()) {
        self.configuration = configuration
    }
    
    func fetchAllCards(completion: @escaping (Result<[Card], APIError>) -> Void) {
        guard let url = URL(string: "\(configuration.baseURL)/cards") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = configuration.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CardResponse.self, from: data)
                let cards = response.allCards
                completion(.success(cards))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }.resume()
    }
    
    func getCard(withID id: String, completion: @escaping (Result<CardDetails, APIError>) -> Void) {
        guard let url = URL(string: "\(configuration.baseURL)/cards/\(id)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = configuration.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode([CardDetails].self, from: data)
                if let cardDetails = response.first {
                    completion(.success(cardDetails))
                } else {
                    completion(.failure(.decodingFailed(APIError.invalidResponse)))
                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }.resume()
    }
}
