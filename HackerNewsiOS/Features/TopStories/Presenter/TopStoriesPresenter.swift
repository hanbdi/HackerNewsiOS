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
    func fetchMoreStories()
    func openUrl(section: Int, row: Int)
    
    func numberOfSections() -> Int
    func numberOfRowsInSections(_ section: Int) -> Int
    func getRowHeight() -> Float
    
    func getStoryAt(section: Int, row: Int) -> Story?
    func loadMoreIfNeeded()
}

class TopStoriesPresenter {
    var service: StoryServiceProtocol
    weak var delegate: TopStoriesViewProtocol?
    
    var storyIds: StoryIds = []
    var stories: [Story] = []
    var loadingMore: Bool = false
    
    private let maxStoriesPerRequest: Int = 20
    
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
        fetchStoryIdsThenStories()
    }
    
    func fetchMoreStories() {
        loadingMore = true
        delegate?.showLoadMoreAnimate(at: loadingSectionIndex)
        fetchStories()
    }
    
    func openUrl(section: Int, row: Int) {
        guard let story = getStoryAt(section: section, row: row), let url = story.url, story.isValidUrl() else {
            delegate?.showError(AppError.urlIsNil)
            return
        }
        
        delegate?.openUrl(url: url)
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
    
    func getRowHeight() -> Float {
        return 80
    }
    
    func getStoryAt(section: Int, row: Int) -> Story? {
        let totalStories: Int = stories.count
        if totalStories > 0 && row >= 0 && row < totalStories {
            return stories[row]
        }
        return nil
    }
    
    func loadMoreIfNeeded() {
        if canLoadMore() {
            fetchMoreStories()
        }
    }
    
    
}

// MARK: private methods

private extension TopStoriesPresenter {
    
    func fetchStoryIdsThenStories() {
        self.delegate?.showLoading()
        service.fetchStoryIds { [weak self] storyIds, storyIdsError in

            guard let self = self else {
                return
            }
            
            if let error = storyIdsError {
                self.delegate?.hideLoading()
                self.delegate?.showError(error)
                return
            }
            
            self.storyIds = storyIds
            self.fetchStories()
        }
    }
    
    func fetchStories() {
        let count = self.stories.count
        let ids: [Int]!
        let idsCount = self.storyIds.count

        if count + self.maxStoriesPerRequest > idsCount {
            ids = Array(self.storyIds[count..<idsCount])
        } else {
            ids = Array(self.storyIds[count..<count + self.maxStoriesPerRequest])
        }

        self.service.fetchStories(ids: ids) { [weak self]
            stories, storiesError in
            guard let self = self else {
                return
            }
            
            self.delegate?.hideLoading()
            if let error = storiesError {
                self.delegate?.showError(error)
                return
            }

            self.stories.append(contentsOf: stories)
            self.loadingMore = false
            self.delegate?.reloadStories()
        }
    }
    
    func canLoadMore() -> Bool {
        let totalLoadedStories: Int = stories.count
        return !loadingMore && totalLoadedStories != storyIds.count &&
            totalLoadedStories != 0
    }
}
