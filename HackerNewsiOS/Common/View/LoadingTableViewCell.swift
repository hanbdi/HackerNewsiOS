//
//  LoadingTableViewCell.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import SnapKit

class LoadingTableViewCell: UITableViewCell {

    static let id = "LoadingTableViewCell"
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
}

// MARK: private methods

private extension LoadingTableViewCell {
    
    func setup() {
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
