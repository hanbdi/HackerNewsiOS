//
//  TopStoriesViewController.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import UIKit
import SnapKit

class TopStoriesViewController: UIViewController {

    // MARK: UI components
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    var storiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func refreshStories() {
        // TODO: fetch stories using presenter
    }
}

// MARK: private methods

private extension TopStoriesViewController {
    
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        setupRootView()
        setupStoriesTableView()
    }
    
    func setupRootView() {
        view.backgroundColor = .white
        title = "Top Stories"
        edgesForExtendedLayout = []
    }
    
    func setupStoriesTableView() {
        storiesTableView = UITableView()
        view.addSubview(storiesTableView)
        storiesTableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
                
        refreshControl.addTarget(self, action:  #selector(refreshStories), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(
            string: "Fetching Top Stories...",
            attributes: [
                .foregroundColor: UIColor.blue
            ])
        storiesTableView.refreshControl = refreshControl
        
        storiesTableView.tableFooterView = UIView() // not display bottom empty cells
        storiesTableView.backgroundView = activityIndicator
    }
}
