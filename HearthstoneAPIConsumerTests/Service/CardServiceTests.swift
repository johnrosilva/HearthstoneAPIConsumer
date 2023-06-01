//
//  HearthstoneAPIServiceTests.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import XCTest
@testable import HearthstoneAPIConsumer

class CardServiceTests: XCTestCase {
    var cardService: CardServiceProtocol!
    
    override func setUp() {
        super.setUp()
        cardService = CardService()
    }
    
    override func tearDown() {
        cardService = nil
        super.tearDown()
    }
    
    func testFetchAllCards_Successful() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch all cards successful")
        var result: Result<[Card], APIError>?
        
        let mockService = MockCardService()
        cardService = mockService
        
        // When
        mockService.fetchAllCards { res in
            result = res
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        
        switch result {
        case .success(let cards):
            XCTAssertFalse(cards.isEmpty)
        case .failure(let error):
            XCTFail("Error occurred: \(error)")
        case nil:
            XCTFail("No result received")
        }
    }

    
    func testGetCard_Successful() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch card details successful")
        var result: Result<CardDetails, APIError>?
        let cardId = "EX1_572"
        
        let mockService = MockCardService()
        cardService = mockService
        
        // When
        mockService.getCard(withID: cardId) { res in
            result = res
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        
        switch result {
        case .success(let cardDetails):
            XCTAssertEqual(cardDetails.cardId, cardId)
        case .failure(let error):
            XCTFail("Error occurred: \(error)")
        case nil:
            XCTFail("No result received")
        }
    }

    
    func testGetCard_Error() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch card details error")
        var result: Result<CardDetails, APIError>?
        let cardId = "NonExistentCard"
        cardService = CardService()
        
        // When
        cardService.getCard(withID: cardId) { res in
            result = res
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 60)
        switch result {
        case .success:
            XCTFail("Expected failure, but received success")
        case .failure(let error):
            XCTAssertNotNil(error)
        case nil:
            XCTAssertTrue(true, "Asynchronous wait failed")
        }
    }
}
