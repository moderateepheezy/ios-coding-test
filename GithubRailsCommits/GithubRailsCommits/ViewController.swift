//
//  ViewController.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


final class TableViewCell: UITableViewCell {

    private lazy var commitDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Title Text"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            .append(commit.detail.author.name, font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray)
            .append(commit.sha, font: .systemFont(ofSize: 16, weight: .semibold), textColor: .gray)
            .append(commit.detail.message, font: .systemFont(ofSize: 14, weight: .regular), textColor: .lightGray)
    }
}
