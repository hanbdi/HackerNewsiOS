//
//  StoryDatasource.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import UIKit

class StoriesDataSource: NSObject {
    
    private let presenter: TopStoriesPresenterProtocol
    
    init(presenter: TopStoriesPresenterProtocol) {
        self.presenter = presenter
    }
    
}

// MARK: implements UITableViewDataSource

extension StoriesDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSections(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == storySectionIndex {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopStoriesTableViewCell.id, for: indexPath) as? TopStoriesTableViewCell else {
                fatalError("cell should be type of TopStoriesTableViewCell")
            }

            cell.story = presenter.getStoryAt(section: indexPath.section, row: indexPath.row)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.id, for: indexPath) as? LoadingTableViewCell else {
            fatalError("cell should be type of LoadingTableViewCell")
        }

        cell.startAnimating()
        return cell
    }

}

