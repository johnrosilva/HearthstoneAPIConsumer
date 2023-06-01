//
//  CardListTableViewCellTests.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import XCTest
@testable import HearthstoneAPIConsumer

class CardListTableViewCellTests: XCTestCase {
    
    var cell: CardListTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = CardListTableViewCell(style: .default, reuseIdentifier: CardListTableViewCell.reuseIdentifier)
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testCellHasImageView() {
        XCTAssertTrue(cell.contentView.subviews.contains(cell.cardImageView))
    }
    
    func testCellHasNameLabel() {
        XCTAssertTrue(cell.contentView.subviews.contains(cell.nameLabel))
    }
    
    func testCellHasTypeLabel() {
        XCTAssertTrue(cell.contentView.subviews.contains(cell.typeLabel))
    }
    
    func testConfigureCell() {
        let card = Card(cardId: "1", name: "Test Card", cardSet: nil, type: "Minion", faction: nil, rarity: nil, cost: nil, attack: nil, health: nil, flavor: nil, text: nil, img: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/d720b94c47bf022e95d8c4e916336a8f56b8cf895d491c792a746e7056f95dc7.png")
        
        cell.configure(with: card)
        
        XCTAssertEqual(cell.nameLabel.text, "Test Card")
        XCTAssertEqual(cell.typeLabel.text, "Minion")
        
        let expectation = XCTestExpectation(description: "Image loading")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.cell.cardImageView.image)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}

