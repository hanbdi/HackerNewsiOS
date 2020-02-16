//
//  MockStoryService.swift
//  HackerNewsiOSTests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
@testable import HackerNewsiOS

class MockStoryService: StoryServiceProtocol {
    
    var fetchStoryIdsWasCalled: Int = 0
    var fetchStoriesWasCalled: Int = 0
    
    var mockStoryIdsResponse: StoryIds = []
    var mockStoriesResponse: [Story] = []
    
    private let fetchStoryIdsSuccess: Bool
    private let fetchStoriesSuccess: Bool
    
    init(fetchStoryIdsSuccess: Bool, fetchStoriesSuccess: Bool) {
        self.fetchStoryIdsSuccess = fetchStoryIdsSuccess
        self.fetchStoriesSuccess = fetchStoriesSuccess
    }
    
    func fetchStoryIds(completion: @escaping (StoryIds, Error?) -> Void) {
        fetchStoryIdsWasCalled += 1
        if fetchStoryIdsSuccess {
            completion(mockStoryIdsResponse, nil)
        } else {
            completion([], AppError.generic)
        }
    }
    
    func fetchStories(ids: StoryIds, completion: @escaping ([Story], Error?) -> Void) {
        fetchStoriesWasCalled += 1
        if fetchStoriesSuccess {
            completion(mockStoriesResponse, nil)
        } else {
            completion([], AppError.generic)
        }
    }
    
    
}

