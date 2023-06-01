//
//  CardListViewControllerTests.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import XCTest
@testable import HearthstoneAPIConsumer

class CardListViewControllerTests: XCTestCase {
    var sut: CardListViewController!
    var viewModelMock: CardListViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModelMock = CardListViewModelMock()
        sut = CardListViewController(viewModel: viewModelMock)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModelMock = nil
        super.tearDown()
    }
    
    func testTableView_NumberOfRowsInSection_ShouldReturnNumberOfCards() {
        // Given
        let expectedNumberOfCards = 20
        viewModelMock.cards = createMockCards()
        
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, expectedNumberOfCards)
    }
    
    func testTableView_CellForRowAt_ShouldReturnConfiguredCell() {
        // Given
        let cards = createMockCards()
        viewModelMock.cards = cards
        sut.tableView.reloadData()
        
        // When
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath) as? CardListTableViewCell
        
        // Then
        XCTAssertNotNil(cell)
        //XCTAssertEqual(cell?.card.cardId, cards[indexPath.row].cardId)
    }
    
    func testTableView_HeightForRowAt_ShouldReturnFixedHeight() {
        // Given
        let expectedHeight: CGFloat = 64
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let heightForRow = sut.tableView(sut.tableView, heightForRowAt: indexPath)
        
        // Then
        XCTAssertEqual(heightForRow, expectedHeight)
    }
    
    func testTableView_DidSelectRowAt_ShouldPushCardDetailViewController() {
        // Given
        let cards = createMockCards()
        viewModelMock.cards = cards
        sut.tableView.reloadData()
        
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        
        // When
        let indexPath = IndexPath(row: 2, section: 0)
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)
        
        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is CardDetailViewController)
        let cardDetailVC = mockNavigationController.pushedViewController as? CardDetailViewController
        XCTAssertEqual(cardDetailVC?.viewModel.card.cardId, cards[indexPath.row].cardId)
    }
    
    // Helper method to create mock cards
    func createMockCards() -> [Card] {
        let bundle = Bundle.main
        guard let fileUrl = bundle.url(forResource: "cards_mock", withExtension: "json") else {
            fatalError("Failed to find cards_mock.json file")
        }
        
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let cardResponse = try decoder.decode(CardResponse.self, from: jsonData)
            return cardResponse.allCards
        } catch {
            fatalError("Failed to parse cards_mock.json: \(error)")
        }
    }
    
    // Helper class for mocking UINavigationController
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}

