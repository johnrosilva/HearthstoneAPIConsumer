//
//  Filess.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 01/06/23.
//

import Foundation
@testable import HearthstoneAPIConsumer

class MockCardDetailViewModel: CardDetailViewModel {
    var fetchCardDetailsCalled = false
    var mockedCardDetails: CardDetails?
    var mockedError: Error?

    override func fetchCardDetails() {
        fetchCardDetailsCalled = true

        if let error = mockedError {
            delegate?.cardDetailsFetchFailed(withError: error)
        } else {
            cardDetails = mockedCardDetails
            delegate?.cardDetailsFetched()
        }
    }
}


