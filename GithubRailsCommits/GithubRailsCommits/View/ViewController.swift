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

    let githubRequest = GithubRequest()

    var commits = [Commit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        fetchCommits()
    }

    @objc
    private func refreshControlValueChanged() {
        fetchCommits()
    }

    func fetchCommits() {
        
        tableView.refreshControl?.beginRefreshing()

        githubRequest.fetchRailsCommits {[weak self] commits, errorMessage in
            self?.tableView.refreshControl?.endRefreshing()

            guard let commits = commits else {
                self?.setAlert(title: "Response Error", message: errorMessage)
                return
            }

            self?.commits = commits
            self?.tableView.reloadData()
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
