//
//  TopStoriesTableViewCell.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import SnapKit

class TopStoriesTableViewCell: UITableViewCell {
        
    static let id: String = "TopStoriesTableViewCell"
    
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    
    private let margin: CGFloat = 8
    
    var story: Story? {
        didSet {
            configure(with: story)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension TopStoriesTableViewCell {
    
    func setup() {
        setupSeparator()
        setupTitle()
        setupAuthor()
    }
    
    func setupSeparator() {
        separatorInset = .zero // full width
    }
    
    func setupTitle() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top
                .equalToSuperview().offset(margin)
            $0.trailing.equalToSuperview().offset(-margin)
        }
    }
    
    func setupAuthor() {
        authorLabel = UILabel()
        authorLabel.font = UIFont.italicSystemFont(ofSize: 14)
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.topMargin
                .equalTo(titleLabel.snp.bottomMargin)
                .offset(margin * 3)
            $0.bottom.equalToSuperview().offset(-margin)
        }
        authorLabel.setContentHuggingPriority(.required, for: .vertical)
        authorLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configure(with story: Story?) {
        titleLabel.text = (story?.title).orEmpty()
        authorLabel.text = (story?.formatAuthor()).orEmpty()
        if (story?.isValidUrl()).or(false) {
            accessoryType = .disclosureIndicator
        } else {
            accessoryType = .none
        }
    }
}
