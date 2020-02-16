//
//  TopStoriesPresenterTests.swift
//  HackerNewsiOSTests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import XCTest
@testable import HackerNewsiOS

class TopStoriesPresenterTests: XCTestCase {

    var sut: TopStoriesPresenter!
    var view: MockTopStoriesView!
    var service: MockStoryService!
    
    func testViewDidLoadShouldFetchStories() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(service.fetchStoryIdsWasCalled, 1)
    }
    
    
    func testRefreshShouldFetchStories() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.refreshStories()
        
        // Then
        XCTAssertEqual(service.fetchStoryIdsWasCalled, 1)
    }
    
    func testRefreshFailedLoadStoryIds() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: false, fetchStoriesSuccess: false)
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.refreshStories()
        
        // Then
        XCTAssertEqual(service.fetchStoryIdsWasCalled, 1)
        XCTAssertEqual(service.fetchStoriesWasCalled, 0)
        XCTAssertEqual(view.showLoadingWasCalled, 1)
        XCTAssertEqual(view.hideLoadingWasCalled, 1)
        XCTAssertEqual(view.showErrorWasCalled, 1)
    }
    
    func testRefreshStoriesFailedLoadStories() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: false)
        service.mockStoryIdsResponse = [1, 2, 3]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        XCTAssertEqual(sut.storyIds, [])
        XCTAssertEqual(sut.stories, [])
        
        // When
        sut.refreshStories()
        
        // Then
        XCTAssertEqual(service.fetchStoryIdsWasCalled, 1)
        XCTAssertEqual(sut.storyIds, [1, 2, 3])
        XCTAssertEqual(service.fetchStoriesWasCalled, 1)
        XCTAssertEqual(sut.stories, [])
        XCTAssertEqual(view.showLoadingWasCalled, 1)
        XCTAssertEqual(view.hideLoadingWasCalled, 1)
        XCTAssertEqual(view.showErrorWasCalled, 1)
        
    }
    
    func testRefreshStoriesSuccess() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: nil, author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        XCTAssertEqual(sut.storyIds, [])
        XCTAssertEqual(sut.stories, [])
        
        // When
        sut.refreshStories()
        
        // Then
        XCTAssertEqual(service.fetchStoryIdsWasCalled, 1)
        XCTAssertEqual(sut.storyIds, [1, 2])
        XCTAssertEqual(service.fetchStoriesWasCalled, 1)
        XCTAssertEqual(sut.stories, [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: nil, author: "B")
        ])
        XCTAssertEqual(view.showLoadingWasCalled, 1)
        XCTAssertEqual(view.hideLoadingWasCalled, 1)
        XCTAssertEqual(view.showErrorWasCalled, 0)
        
    }
    
    func testFetchMoreStories() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: false, fetchStoriesSuccess: false)
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.fetchMoreStories()
        
        // Then
        XCTAssertEqual(service.fetchStoryIdsWasCalled, 0)
        XCTAssertEqual(service.fetchStoriesWasCalled, 1)
        XCTAssertEqual(view.showLoadMoreAnimateWasCalled, 1)
        XCTAssertEqual(view.showLoadMoreAnimateAtSection, 1)
    }
    
    func testOpenInvalidUrl() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        sut.viewDidLoad()
        
        // When
        sut.openUrl(section: 0, row: 0)
        
        // Then
        XCTAssertEqual(view.showErrorWasCalled, 1)
        XCTAssertEqual(view.openUrlWasCalled, 0)
    }
    
    func testOpenValidUrl() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        sut.viewDidLoad()
        
        // When
        sut.openUrl(section: 0, row: 1)
        
        // Then
        XCTAssertEqual(view.showErrorWasCalled, 0)
        XCTAssertEqual(view.openUrlWasCalled, 1)
        XCTAssertEqual(view.openUrl, "https://google.com")
    }
    
    func testNumberOfSections() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        sut = TopStoriesPresenter(service: service)
        
        // Then
        XCTAssertEqual(sut.numberOfSections(), 2)
    }
    
    func testNumberOfRowsInInvalidSection() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.numberOfRowsInSections(3), 0)
    }
    
    func testNumberOfRowsInStorySection() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.numberOfRowsInSections(0), 2)
    }
    
    func testNumberOfRowsInLoadingSection() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2, 3]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        
        // When
        sut.viewDidLoad()
        sut.loadingMore = true
        
        // Then
        XCTAssertEqual(sut.numberOfRowsInSections(1), 1)
    }
    
    func testRowHeight() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        sut = TopStoriesPresenter(service: service)
        
        // Then
        XCTAssertEqual(sut.getRowHeight(), 80)
    }
    
    func testGetNilStoryAtInvalidIndex() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.getStoryAt(section: 0, row: 0), Story(id: 1, title: "1", url: nil, author: "A"))
    }
    
    func testGetValidStoryAtValidIndex() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        sut.viewDidLoad()
        
        // Then
        XCTAssertNil(sut.getStoryAt(section: 0, row: 2))
    }
    
    func testCanLoadMore() {
        // Given
        service = MockStoryService(fetchStoryIdsSuccess: true, fetchStoriesSuccess: true)
        service.mockStoryIdsResponse = [1, 2, 3]
        service.mockStoriesResponse = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        sut = TopStoriesPresenter(service: service)
        view = MockTopStoriesView()
        sut.setDelegate(view)
        sut.storyIds = [1, 2, 3]
        sut.stories = [
            Story(id: 1, title: "1", url: nil, author: "A"),
            Story(id: 2, title: "2", url: "https://google.com", author: "B")
        ]
        
        // When
        sut.loadMoreIfNeeded()
        
        // Then
        XCTAssertEqual(view.showLoadMoreAnimateWasCalled, 1)
        XCTAssertEqual(view.showLoadMoreAnimateAtSection, 1)
    }

}

class MockTopStoriesView: TopStoriesViewProtocol {
    var openUrlWasCalled: Int = 0
    var openUrl: String? = nil
    
    var reloadStoriesWasCalled: Int = 0
    
    var showLoadingWasCalled: Int = 0
    var hideLoadingWasCalled: Int = 0
    
    var showLoadMoreAnimateWasCalled: Int = 0
    var showLoadMoreAnimateAtSection: Int? = nil
    
    var showErrorWasCalled: Int = 0
    
    func openUrl(url: String) {
        openUrlWasCalled += 1
        openUrl = url
    }
    
    func reloadStories() {
        reloadStoriesWasCalled += 1
    }
    
    func showLoading() {
        showLoadingWasCalled += 1
    }
    
    func hideLoading() {
        hideLoadingWasCalled += 1
    }
    
    func showLoadMoreAnimate(at section: Int) {
        showLoadMoreAnimateWasCalled += 1
        showLoadMoreAnimateAtSection = section
    }
    
    func showError(_ error: Error) {
        showErrorWasCalled += 1
    }
    
    
}
