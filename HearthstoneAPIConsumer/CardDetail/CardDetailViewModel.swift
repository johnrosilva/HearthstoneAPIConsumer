//
//  CardDetailViewModel.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 30/05/23.
//

import Foundation

protocol CardDetailViewModelDelegate: AnyObject {
    func cardDetailsFetched()
    func cardDetailsFetchFailed(withError error: Error)
}

class CardDetailViewModel {
    weak var delegate: CardDetailViewModelDelegate?
    private let apiService: HearthstoneAPIService
    private let card: Card
    private(set) var cardDetails: CardDetails?
    
    var emptyInfo: String = "Unknown"
    
    init(card: Card, apiService: HearthstoneAPIService = HearthstoneAPIService()) {
        self.card = card
        self.apiService = apiService
    }
    
    func fetchCardDetails() {
        apiService.getCard(withName: card.cardId ?? "") { [weak self] result in
            switch result {
            case .success(let cardDetails):
                self?.cardDetails = cardDetails
                self?.delegate?.cardDetailsFetched()
            case .failure(let error):
                self?.delegate?.cardDetailsFetchFailed(withError: error)
            }
        }
    }
}