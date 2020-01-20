//
//  View.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import UIKit

class View: UITableView {

    var identifer: String {
        return "cell"
    }
    // MARK: - Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    private func configure() {
        register(TableViewCell.self, forCellReuseIdentifier: identifer)
        refreshControl = UIRefreshControl()
    }

}
