//
//  StoryService.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation

enum AppError: Error {
    case generic
    case responseIsNotSuccess
    case cantParseData
    case cantParseUrl
    case urlIsNil
}

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
        let urlString: String = "\(baseURL)/topstories.json"
        guard let url = URL.init(string: urlString) else {
            appLog("Cant parse URL!!", urlString)
            completion([], AppError.cantParseUrl)
            return
        }

        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let response = response, response.isSuccess,
                let responseData = data, error == nil else {
                    appLog("Request for \(urlString) is not success!!")
                    completion([], AppError.responseIsNotSuccess)
                    return
            }

            let decoder = JSONDecoder()

            do {

                let storyIds = try decoder.decode(StoryIds.self, from: responseData)
                completion(storyIds, nil)

            } catch {
                appLog(error.localizedDescription)
                completion([], AppError.responseIsNotSuccess)
            }
        }
        task.resume()
    }
    
    func fetchStories(ids: StoryIds, completion: @escaping ([Story], Error?) -> Void) {
        var storiesMap = [Int: Story]()
        let group = DispatchGroup()
        var stories: [Story] = []
        for id in ids {
            group.enter()
            fetchStory(id: id) { story, error in
                guard let story = story else {
                    completion([], error)
                    return
                }
                
                storiesMap[id] = story
                if storiesMap.count == ids.count {
                    for id in ids {
                        stories.append(storiesMap[id]!)
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.global()) {
            completion(stories, nil)
        }
    }
}

private extension StoryService {
    
    func fetchStory(id: Int, completion: @escaping (Story?, Error?) -> Void) {
        appLog("Fetching story id: \(id)")
        let urlString: String = "\(baseURL)/item/\(id).json"
        guard let url = URL.init(string: urlString) else {
            appLog("Cant parse URL!!", urlString)
            completion(nil, AppError.cantParseUrl)
            return
        }

        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let response = response, response.isSuccess,
                let responseData = data, error == nil else {
                    appLog("Request for \(urlString) is not success!!")
                    completion(nil, AppError.responseIsNotSuccess)
                    return
            }

            let decoder = JSONDecoder()

            do {
                appLog("=> Fetched story id: \(id)")
                let story = try decoder.decode(Story.self, from: responseData)
                completion(story, nil)

            } catch {
                appLog(error.localizedDescription)
                completion(nil, AppError.responseIsNotSuccess)
            }
        }
        task.resume()
    }
}
