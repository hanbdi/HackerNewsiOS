//
//  StoryServiceTests.swift
//  HackerNewsiOSTests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import XCTest
@testable import HackerNewsiOS

class StoryServiceTests: XCTestCase {

    var sut: StoryService!
    var sessionMock: URLSessionMock!
    
    override func setUp() {
        sessionMock = URLSessionMock()
    }
    
    func testFetchStoryIdsContract() {
        // Given
        sut = StoryService(session: sessionMock)
        
        // When
        sut.fetchStoryIds {_, _ in}
        
        // Then
        XCTAssertNotNil(sessionMock.requestCalled)
        XCTAssertEqual(sessionMock.requestCalled.url?.absoluteString, "https://hacker-news.firebaseio.com/v0/topstories.json")
        XCTAssertEqual(sessionMock.requestCalled.httpMethod, "GET")
    }
    
    func testFetchStoryContract() {
        // Given
        sut = StoryService(session: sessionMock)
        
        // When
        sut.fetchStories(ids: [111]) {_, _ in}
        
        // Then
        XCTAssertNotNil(sessionMock.requestCalled)
        XCTAssertEqual(sessionMock.requestCalled.url?.absoluteString, "https://hacker-news.firebaseio.com/v0/item/111.json")
        XCTAssertEqual(sessionMock.requestCalled.httpMethod, "GET")
    }

}
