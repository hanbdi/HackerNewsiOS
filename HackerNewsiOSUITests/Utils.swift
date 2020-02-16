//
//  Utils.swift
//  HackerNewsiOSUITests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    @discardableResult func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let testExpectation = expectation(for: predicate, evaluatedWith: element,
                                      handler: nil)
        let result = XCTWaiter().wait(for: [testExpectation], timeout: 5)
        return result == .completed
    }
    
    @discardableResult func waitForElementHittable(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "isHittable == true")
        let testExpectation = expectation(for: predicate, evaluatedWith: element,
                                      handler: nil)
        let result = XCTWaiter().wait(for: [testExpectation], timeout: 5)
        return result == .completed
    }

}
