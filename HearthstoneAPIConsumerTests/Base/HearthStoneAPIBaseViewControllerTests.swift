//
//  Testee.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 01/06/23.
//

import Foundation
import XCTest
@testable import HearthstoneAPIConsumer

class HearthStoneAPIBaseViewControllerTests: XCTestCase {

    func testShowLoadingIndicator() {
        // Given
        let viewController = HearthStoneAPIBaseViewController()
        let window = UIWindow()
        window.addSubview(viewController.view)
        window.makeKeyAndVisible()

        // When
        viewController.showLoadingIndicator()

        // Then
        XCTAssertNotNil(viewController.loadingIndicator, "Loading indicator should not be nil")
        XCTAssertTrue(viewController.loadingIndicator?.isAnimating ?? false, "Loading indicator should be animating")
    }
    
    func testShowAlert() {
        // Given
        let viewController = HearthStoneAPIBaseViewController()
        let window = UIWindow()
        window.addSubview(viewController.view)
        window.makeKeyAndVisible()

        // When
        let alertController = viewController.showAlert(message: "Test Message")

        // Then
        XCTAssertNotNil(alertController, "Failed to create UIAlertController")
        XCTAssertEqual(alertController.title, "Error")
        XCTAssertEqual(alertController.message, "Test Message")
        XCTAssertEqual(alertController.actions.count, 1)
        XCTAssertEqual(alertController.actions.first?.title, "OK")
    }
}

