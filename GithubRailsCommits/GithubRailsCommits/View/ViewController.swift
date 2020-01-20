//
//  ViewController.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import UIKit

class ViewController: NiblessViewController<View> {

    let githubRequest = GithubRequest()

    var commits = [Commit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.dataSource = self
        customView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        fetchCommits()
    }

    @objc
    private func refreshControlValueChanged() {
        fetchCommits()
    }

    func fetchCommits() {

        customView.refreshControl?.beginRefreshing()

        githubRequest.fetchRailsCommits {[weak self] commits, errorMessage in
            self?.customView.refreshControl?.endRefreshing()

            guard let commits = commits else {
                self?.setAlert(title: "Error", message: errorMessage)
                return
            }

            self?.commits = commits
            self?.customView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("Cannot dequeue TableViewCell")
        }

        cell.feed(commit: commits[indexPath.item])

        return cell
    }
}
