//
//  File.swift
//  HearthstoneAPIConsumerTests
//
//  Created by Johnatas Rodrigues on 01/06/23.
//

import Foundation
import XCTest
@testable import HearthstoneAPIConsumer

class UIImageExtensionTests: XCTestCase {

    func testResize() {
        // Given
        let image = UIImage(named: "default_card")
        let newSize = CGSize(width: 100, height: 100)

        // When
        let resizedImage = image?.resize(newSize)

        // Then
        XCTAssertNotNil(resizedImage)
        XCTAssertEqual(resizedImage?.size, newSize)
    }

    func testFromSuccess() {
        // Given
        let imageUrlString = "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/9fdba7eca884d01a5fefbcdbef4b251f14896cec7481fd8082cbd9eefcd0d204.png"
        let expectation = XCTestExpectation(description: "Image loaded")

        // When
        UIImage.from(imageUrlString, sizeOfResize: nil) { image in
            // Then
            XCTAssertNotNil(image)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }

    func testFromFailure() {
        // Given
        let invalidImageUrlString = "https://example.com/invalid_image.jpg"
        let expectation = XCTestExpectation(description: "Image failed to load")

        // When
        UIImage.from(invalidImageUrlString, sizeOfResize: nil) { image in
            // Then
            XCTAssertNil(image)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}

