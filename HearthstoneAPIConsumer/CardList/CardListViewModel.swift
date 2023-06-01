//
//  CardListViewModel.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import Foundation

protocol CardListViewModelDelegate: AnyObject {
    func cardsFetched()
    func cardsFetchFailed(withError error: Error)
}

class CardListViewModel {
    weak var delegate: CardListViewModelDelegate?
    private let apiService: CardServiceProtocol
    var cards: [Card] = []

    init(apiService: CardServiceProtocol = CardService(configuration: CardServiceConfigurator.shared.configure())) {
        self.apiService = apiService
    }

    func fetchCards() {
        apiService.fetchAllCards { [weak self] result in
            switch result {
            case .success(let cards):
                self?.cards = cards
                self?.delegate?.cardsFetched()
            case .failure(let error):
                self?.delegate?.cardsFetchFailed(withError: error)
            }
        }
    }
}
