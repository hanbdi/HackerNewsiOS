//
//  TopStoriesViewController.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import UIKit
import SnapKit
import SafariServices

protocol TopStoriesViewProtocol: class {
    func openUrl(url: String)
    func reloadStories()
    func showLoading()
    func hideLoading()
    func showLoadMoreAnimate(at section: Int)
    func showError(_ error: Error)
}

class TopStoriesViewController: UIViewController, ErrorHandler {

    var presenter: TopStoriesPresenterProtocol
    private var dataSource: StoriesDataSource!
    
    // MARK: UI components
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    var storiesTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
    
    init(presenter: TopStoriesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func refreshStories() {
        presenter.refreshStories()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            presenter.loadMoreIfNeeded()
        }
    }
    
}

// MARK: Implements TopStoriesViewProtocol

extension TopStoriesViewController: TopStoriesViewProtocol {
    
    func openUrl(url: String) {
        let webViewController = SFSafariViewController(url: URL(string: url)!)
        webViewController.delegate = self
        present(webViewController, animated: true)
    }
    
    func reloadStories() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.storiesTableView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showLoadMoreAnimate(at section: Int) {
        storiesTableView.beginUpdates()
        storiesTableView.reloadSections(IndexSet(integer: section), with: .none)
        storiesTableView.endUpdates()
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        }
        displayError(error: error)
    }
}

// MARK: implements UITableViewDelegate

extension TopStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.openUrl(section: indexPath.section, row: indexPath.row)
    }
}

// MARK: Implements SFSafariViewControllerDelegate

extension TopStoriesViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
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
        
        storiesTableView.rowHeight = UITableView.automaticDimension
        storiesTableView.estimatedRowHeight = CGFloat(presenter.getRowHeight())
        storiesTableView.backgroundColor = UIColor.clear
        dataSource = StoriesDataSource(presenter: presenter)
        storiesTableView.dataSource = dataSource
        storiesTableView.delegate = self
        storiesTableView.register(
            TopStoriesTableViewCell.self,
            forCellReuseIdentifier: TopStoriesTableViewCell.id)
        storiesTableView.register(
            LoadingTableViewCell.self,
            forCellReuseIdentifier: LoadingTableViewCell.id)
        storiesTableView.accessibilityIdentifier = "storiesTableView"
        
        storiesTableView.tableFooterView = UIView() // not display bottom empty cells
        storiesTableView.backgroundView = activityIndicator
    }
}
