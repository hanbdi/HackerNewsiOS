//
//  OptionalTests.swift
//  HackerNewsiOSTests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import XCTest
@testable import HackerNewsiOS

class OptionalTests: XCTestCase {

    func testStringIsNil() {
        // Given
        let nilString: String? = nil
        
        // When
        let emptyString = nilString.orEmpty()
        
        // Then
        XCTAssertEqual(emptyString, "")
    }
    
    func testIntIsNil() {
        // Given
        let nilInt: Int? = nil
        
        // When
        let defaultOne: Int = nilInt.or(1)
        
        // Then
        XCTAssertEqual(defaultOne, 1)
    }

}
