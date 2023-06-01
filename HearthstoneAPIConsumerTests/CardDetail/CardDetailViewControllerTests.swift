//
//  File.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 01/06/23.
//

import XCTest
@testable import HearthstoneAPIConsumer

class CardDetailViewControllerTests: XCTestCase {
    var viewController: CardDetailViewController!
    var viewModel: CardDetailViewModel!
    
    let card = Card(cardId: "EX1_572", name: "Ysera", cardSet: "Classic", type: "Minion", faction: "Neutral", rarity: "Legendary", cost: 9, attack: 4, health: 12, flavor: "Ysera rules the Emerald Dream. Which is some kind of green-mirror-version of the real world, or something?", text: "At the end of your turn, add a Dream Card to your hand.", img: "http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_572.png")
    
    let cardDetails = CardDetails(cardId: "EX1_572", cardImageURL: "http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_572.png", name: "Ysera", flavorText: "Ysera rules the Emerald Dream. Which is some kind of green-mirror-version of the real world, or something?", shortDescription: "At the end of your turn, add a Dream Card to your hand.", cardSet: "Classic", type: "Minion", faction: "Neutral", rarity: "Legendary", attack: 4, cost: 9, health: 12)

    override func setUp() {
        super.setUp()
        viewModel = CardDetailViewModel(card: card, apiService: MockCardService())
        viewController = CardDetailViewController(viewModel: viewModel)
        viewController.viewModel.delegate = viewController
        // Load the view hierarchy
        _ = viewController.view
    }

    override func tearDown() {
        viewController = nil
        viewModel = nil
        super.tearDown()
    }

    func testViewDidLoad_ConfiguresViews() {
        // Given
        let cardImageView = viewController.cardImageView
        let nameLabel = viewController.nameLabel
        let flavorLabel = viewController.flavorLabel
        let descriptionLabel = viewController.descriptionLabel
        let setLabel = viewController.setLabel
        let typeLabel = viewController.typeLabel
        let factionLabel = viewController.factionLabel
        let rarityLabel = viewController.rarityLabel
        let attackLabel = viewController.attackLabel
        let costLabel = viewController.costLabel
        let healthLabel = viewController.healthLabel

        // Then
        XCTAssertNotNil(cardImageView)
        XCTAssertNotNil(nameLabel)
        XCTAssertNotNil(flavorLabel)
        XCTAssertNotNil(descriptionLabel)
        XCTAssertNotNil(setLabel)
        XCTAssertNotNil(typeLabel)
        XCTAssertNotNil(factionLabel)
        XCTAssertNotNil(rarityLabel)
        XCTAssertNotNil(attackLabel)
        XCTAssertNotNil(costLabel)
        XCTAssertNotNil(healthLabel)
    }

    func testSetupViewModel_SetsDelegate() {
        // When
        let delegate = viewController.viewModel.delegate

        // Then
        XCTAssertTrue(delegate === viewController)
    }

    func testFetchCardDetails_CallsFetchCardDetails() {
        // Given
        let mockViewModel = MockCardDetailViewModel(card: card)
        viewController.viewModel = mockViewModel

        // When
        viewController.fetchCardDetails()

        // Then
        XCTAssertTrue(mockViewModel.fetchCardDetailsCalled)
    }

    func testDisplayCardDetails_SetsCardDetails() {
        // Given
        let mockCardDetails = cardDetails
        let mockViewModel = MockCardDetailViewModel(card: card)
        viewController.viewModel = mockViewModel
        viewController.viewModel.fetchCardDetails()
        
        let expectation = XCTestExpectation(description: "Card details fetched")
        
        // When
        viewController.displayCardDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Then
            XCTAssertEqual(self.viewController.nameLabel.text, mockCardDetails.name)
            XCTAssertEqual(self.viewController.flavorLabel.attributedText?.string, mockCardDetails.flavorText)
            XCTAssertEqual(self.viewController.descriptionLabel.attributedText?.string, mockCardDetails.shortDescription)
            XCTAssertEqual(self.viewController.setLabel.text, "Set: \(mockCardDetails.cardSet ?? "Unknown")")
            XCTAssertEqual(self.viewController.typeLabel.text, "Type: \(mockCardDetails.type ?? "")")
            XCTAssertEqual(self.viewController.factionLabel.text, "Faction: \(mockCardDetails.faction ?? "")")
            XCTAssertEqual(self.viewController.rarityLabel.text, "Rarity: \(mockCardDetails.rarity ?? "")")
            XCTAssertEqual(self.viewController.attackLabel.text, "Attack: \(mockCardDetails.attack ?? 0)")
            XCTAssertEqual(self.viewController.costLabel.text, "Cost: \(mockCardDetails.cost ?? 0)")
            XCTAssertEqual(self.viewController.healthLabel.text, "Health: \(mockCardDetails.health ?? 0)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    
    func testCardDetailsFetched_HidesLoadingIndicator() {
        // Given
        let activityIndicatorView = viewController.activityIndicatorView

        // When
        viewController.cardDetailsFetched()

        // Then
        XCTAssertFalse(activityIndicatorView.isAnimating)
        XCTAssertTrue(activityIndicatorView.isHidden)
    }

    func testCardDetailsFetchFailed_ShowsAlert() {
        // Given
        let mockError = NSError(domain: "test", code: 0, userInfo: nil)
        let mockViewModel = MockCardDetailViewModel(card: card)
        viewController.viewModel = mockViewModel

        // When
        let expectation = XCTestExpectation(description: "Card details fetched")
        viewController.viewModel.fetchCardDetails()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            mockViewModel.delegate?.cardDetailsFetchFailed(withError: mockError)
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1.0)

        let alertController = viewController.showAlert(message: mockError.localizedDescription)
        XCTAssertNotNil(alertController, "Failed to create UIAlertController")
        XCTAssertEqual(alertController.title, "Error")
        XCTAssertEqual(alertController.message, mockError.localizedDescription)
        XCTAssertEqual(alertController.actions.count, 1)
        XCTAssertEqual(alertController.actions.first?.title, "OK")
    }
}

