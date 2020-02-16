//
//  StoryTests.swift
//  HackerNewsiOSTests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import XCTest
@testable import HackerNewsiOS

class StoryTests: XCTestCase {
    
    var sut: Story!

    func testInvalidUrlNil() {
        // Given
        sut = Story(id: 1, title: "", url: nil, author: "")
        
        // Then
        XCTAssertFalse(sut.isValidUrl())
    }
    
    func testInvalidUrlEmpty() {
        // Given
        sut = Story(id: 1, title: "", url: "", author: "")
        
        // Then
        XCTAssertFalse(sut.isValidUrl())
    }
    
    func testValidUrl() {
        // Given
        sut = Story(id: 1, title: "", url: "https://google.com", author: "")
        
        // Then
        XCTAssertTrue(sut.isValidUrl())
    }

}
