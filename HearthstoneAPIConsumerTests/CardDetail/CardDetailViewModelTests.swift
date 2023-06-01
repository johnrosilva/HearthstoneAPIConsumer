//
//  File.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 01/06/23.
//

import Foundation
import XCTest
@testable import HearthstoneAPIConsumer

class CardDetailViewModelTests: XCTestCase {
    var viewModel: CardDetailViewModel!
    var mockService: MockCardService!
    
    override func setUp() {
        super.setUp()
        
        let card = Card(cardId: "EX1_572", name: "Ysera", cardSet: "Classic", type: "Minion", faction: "Neutral", rarity: "Legendary", cost: 9, attack: 4, health: 12, flavor: "Ysera rules the Emerald Dream. Which is some kind of green-mirror-version of the real world, or something?", text: "At the end of your turn, add a Dream Card to your hand.", img: "http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_572.png")
        
        mockService = MockCardService()
        viewModel = CardDetailViewModel(card: card, apiService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchCardDetails_Successful() {
        // Given
        let delegate = CardDetailViewModelDelegateMock()
        viewModel.delegate = delegate
        
        let expectation = XCTestExpectation(description: "Fetch card details successful")
        
        // When
        viewModel.fetchCardDetails()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(delegate.cardDetailsFetchedCallCount, 1)
            XCTAssertNil(delegate.cardDetailsFetchFailedError)
            XCTAssertEqual(self.viewModel.cardDetails?.cardId, "EX1_572")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchCardDetails_Error() {
        // Given
        let delegate = CardDetailViewModelDelegateMock()
        viewModel.delegate = delegate
        mockService.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Fetch card details error")
        
        // When
        viewModel.fetchCardDetails()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(delegate.cardDetailsFetchedCallCount, 0)
            XCTAssertEqual(delegate.cardDetailsFetchFailedCallCount, 1)
            XCTAssertNotNil(delegate.cardDetailsFetchFailedError)
            XCTAssertNil(self.viewModel.cardDetails)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

class CardDetailViewModelDelegateMock: CardDetailViewModelDelegate {
    var cardDetailsFetchedCallCount = 0
    var cardDetailsFetchFailedCallCount = 0
    var cardDetailsFetchFailedError: Error?
    
    func cardDetailsFetched() {
        cardDetailsFetchedCallCount += 1
    }
    
    func cardDetailsFetchFailed(withError error: Error) {
        cardDetailsFetchFailedCallCount += 1
        cardDetailsFetchFailedError = error
    }
}

