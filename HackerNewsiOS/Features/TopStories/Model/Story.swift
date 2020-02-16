//
//  Story.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation

typealias StoryIds = [Int]

struct Story {
    var id: Int
    var title: String
    var url: String?
    var author: String
}

extension Story: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, url
        case author = "by"
    }
}

extension Story {
    func isValidUrl() -> Bool {
        return !url.orEmpty().isEmpty
    }
    
    func formatAuthor() -> String {
        return "by \(author.uppercased())"
    }
}

// MARK: - Equatable

extension Story: Equatable {
    public static func == (lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }
}
