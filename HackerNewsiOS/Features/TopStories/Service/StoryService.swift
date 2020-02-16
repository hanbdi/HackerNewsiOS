//
//  StoryService.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation

protocol StoryServiceProtocol: class {
    func fetchStoryIds(completion: @escaping (StoryIds, Error?) -> Void)
    func fetchStories(ids: StoryIds, completion: @escaping ([Story], Error?) -> Void)
}

class StoryService {
    private let session: URLSessionProtocol!
    private let baseURL: String = "https://hacker-news.firebaseio.com/v0"
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

// MARK: implements StoryServiceProtocol

extension StoryService: StoryServiceProtocol {
    func fetchStoryIds(completion: @escaping (StoryIds, Error?) -> Void) {
        // TODO: implement later
    }
    
    func fetchStories(ids: StoryIds, completion: @escaping ([Story], Error?) -> Void) {
        // TODO: implement later
    }
    

}
