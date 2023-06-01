//
//  CardListViewModel.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import XCTest
@testable import HearthstoneAPIConsumer

class CardListViewModelTests: XCTestCase {
    var apiServiceMock: MockHearthstoneAPIService!
    var viewModel: CardListViewModel!
    var delegateMock: MockCardListViewModelDelegate!

    override func setUp() {
        super.setUp()
        apiServiceMock = MockHearthstoneAPIService()
        viewModel = CardListViewModel(apiService: apiServiceMock)
        delegateMock = MockCardListViewModelDelegate()
        viewModel.delegate = delegateMock
    }

    override func tearDown() {
        apiServiceMock = nil
        viewModel = nil
        delegateMock = nil
        super.tearDown()
    }

    func testFetchCards_Successful() {
        // Given
        let mockData = loadMockCardsData()
        let cardResponse = parseCardsFromData(mockData)
        let cards = cardResponse.allCards
        apiServiceMock.fetchAllCardsCompletionResult = .success(cards)

        // When
        viewModel.fetchCards()

        // Then
        XCTAssertTrue(apiServiceMock.fetchAllCardsCalled)
        XCTAssertEqual(apiServiceMock.fetchAllCardsCallCount, 1)
        XCTAssertTrue(delegateMock.cardsFetchedCalled)
        XCTAssertEqual(delegateMock.cardsFetchedCallCount, 1)
        XCTAssertEqual(viewModel.cards.count, cards.count)
    }
    
    func testFetchCards_Failure() {
        // Given
        let error = APIError.invalidURL
        apiServiceMock.fetchAllCardsCompletionResult = .failure(error)

        // When
        viewModel.fetchCards()

        // Then
        XCTAssertTrue(apiServiceMock.fetchAllCardsCalled)
        XCTAssertEqual(apiServiceMock.fetchAllCardsCallCount, 1)
        XCTAssertTrue(delegateMock.cardsFetchFailedCalled)
        XCTAssertEqual(delegateMock.cardsFetchFailedCallCount, 1)
        XCTAssertEqual((delegateMock.cardsFetchFailedError as? APIError)?.localizedDescription, error.localizedDescription)
        XCTAssertTrue(viewModel.cards.isEmpty)
    }

    // Helper method to load mock cards data from JSON file
    private func loadMockCardsData() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "cards_mock", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load mock cards data")
        }
        return data
    }

    // Helper method to parse cards from JSON data
    private func parseCardsFromData(_ data: Data) -> CardResponse {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(CardResponse.self, from: data)
        } catch {
            fatalError("Failed to parse mock cards data: \(error)")
        }
    }
}

class MockHearthstoneAPIService: CardService {
    var fetchAllCardsCalled = false
    var fetchAllCardsCallCount = 0
    var fetchAllCardsCompletionResult: Result<[Card], APIError>?

    override func fetchAllCards(completion: @escaping (Result<[Card], APIError>) -> Void) {
        fetchAllCardsCalled = true
        fetchAllCardsCallCount += 1
        if let result = fetchAllCardsCompletionResult {
            completion(result)
        }
    }
}

class MockCardListViewModelDelegate: CardListViewModelDelegate {
    var cardsFetchedCalled = false
    var cardsFetchedCallCount = 0
    var cardsFetchFailedCalled = false
    var cardsFetchFailedCallCount = 0
    var cardsFetchFailedError: Error?

    func cardsFetched() {
        cardsFetchedCalled = true
        cardsFetchedCallCount += 1
    }

    func cardsFetchFailed(withError error: Error) {
        cardsFetchFailedCalled = true
        cardsFetchFailedCallCount += 1
        cardsFetchFailedError = error
    }
}

