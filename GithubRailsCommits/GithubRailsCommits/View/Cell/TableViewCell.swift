//
//  TableViewCell.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {

    private lazy var commitDetailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }

    private func config() {
        setupHeirachys()
        setupConstraints()
    }

    private func setupHeirachys() {
        addSubview(commitDetailsLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            commitDetailsLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 20),
            commitDetailsLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 20),
            commitDetailsLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            commitDetailsLabel
                .bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    func feed(commit: Commit) {
        let attributedText = NSMutableAttributedString()
        attributedText
            .append(commit.detail.author.name, font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, lineSpacing: 0)
            .append("\n\n" + "Commit: ", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .black)
            .append(commit.sha, font: .systemFont(ofSize: 14, weight: .semibold), textColor: .gray, lineSpacing: 0)
            .append("\n\n" + "Message: ", font: .systemFont(ofSize: 14, weight: .regular), textColor: .black)
            .append(commit.detail.message, font: .systemFont(ofSize: 14, weight: .regular), textColor: .lightGray)
        commitDetailsLabel.attributedText = attributedText
    }
}
