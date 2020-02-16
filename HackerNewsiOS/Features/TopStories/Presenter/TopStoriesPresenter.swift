//
//  TopStoriesPresenter.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation

let storySectionIndex: Int = 0
let loadingSectionIndex: Int = 1

protocol TopStoriesPresenterProtocol {
    func viewDidLoad()
    func setDelegate(_ delegate: TopStoriesViewProtocol)
    func refreshStories()
    func fetchStories()
    
    func numberOfSections() -> Int
    func numberOfRowsInSections(_ section: Int) -> Int
    
    func getStoryAt(section: Int, row: Int) -> Story?
}

class TopStoriesPresenter {
    var service: StoryServiceProtocol
    weak var delegate: TopStoriesViewProtocol?
    
    var storyIds: StoryIds = []
    var stories: [Story] = []
    var loadingMore: Bool = false
    
    init(service: StoryServiceProtocol) {
        self.service = service
    }
}

// MARK: Implement TopStoriesPresenterProtocol

extension TopStoriesPresenter: TopStoriesPresenterProtocol {
                    
    func viewDidLoad() {
        refreshStories()
    }
    
    func setDelegate(_ delegate: TopStoriesViewProtocol) {
        self.delegate = delegate
    }
    
    func refreshStories() {
        // clear all stories before refresh
        stories.removeAll()
        fetchStories()
    }
    
    func fetchStories() {
        // TODO: fetch stories using story service
    }
        
    func numberOfSections() -> Int {
        return 2 // one fore story cell, one for loading cell
    }
    
    func numberOfRowsInSections(_ section: Int) -> Int {
        if section == storySectionIndex {
            return stories.count
        }
        
        if section == loadingSectionIndex && loadingMore && stories.count != storyIds.count {
            return 1
        }
        
        return 0
    }
    
    func getStoryAt(section: Int, row: Int) -> Story? {
        let totalStories: Int = stories.count
        if totalStories > 0 && row >= 0 && row < totalStories {
            return stories[row]
        }
        return nil
    }
    
}

// MARK: private methods

private extension TopStoriesPresenter {
    
    func canLoadMore() -> Bool {
        let totalLoadedStories: Int = stories.count
        return !loadingMore && totalLoadedStories != storyIds.count &&
            totalLoadedStories != 0
    }
}
