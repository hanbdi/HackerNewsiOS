//
//  TopStoriesBuilder.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import UIKit

protocol ScreenBuilder {
    associatedtype T: UIViewController
    func build() -> T
}

struct TopStoriesBuilder: ScreenBuilder {
    
    typealias T = TopStoriesViewController
    
    private let service: StoryServiceProtocol
    
    init(service: StoryServiceProtocol) {
        self.service = service
    }
    
    func build() -> TopStoriesViewController {
        let presenter: TopStoriesPresenterProtocol = TopStoriesPresenter(service: service)
        let viewController: TopStoriesViewController = TopStoriesViewController(presenter: presenter)
        presenter.setDelegate(viewController)
        
        return viewController
    }

}
