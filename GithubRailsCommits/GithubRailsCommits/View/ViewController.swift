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
    private var currentPage = 1

    var commits = [Commit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.dataSource = self
        customView.prefetchDataSource = self
        customView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        fetchCommits()
    }

    @objc
    private func refreshControlValueChanged() {
        fetchCommits()
    }

    func fetchCommits() {

        customView.refreshControl?.beginRefreshing()

        githubRequest.fetchRailsCommits(currentPage: currentPage) {[weak self] commits, errorMessage in
            self?.customView.refreshControl?.endRefreshing()

            guard let commits = commits else {
                self?.setAlert(title: "Error", message: errorMessage)
                return
            }

            self?.currentPage += 1
            self?.commits = commits
            self?.customView.reloadData()

            if self!.currentPage > 1 {
              let indexPathsToReload = self?.calculateIndexPathsToReload(from: commits)
              self?.onFetchCompleted(with: indexPathsToReload)
            } else {
              self?.onFetchCompleted(with: .none)
            }
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

        if isLoadingCell(for: indexPath) {
            cell.feedNone()
        } else {
            cell.feed(commit: commits[indexPath.item])
        }
        cell.feed(commit: commits[indexPath.item])

        return cell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            fetchCommits()
        }
    }

    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            customView.refreshControl?.endRefreshing()
            customView.isHidden = false
            customView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        customView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
}

private extension ViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= commits.count
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = customView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }

    private func calculateIndexPathsToReload(from newCommits: [Commit]) -> [IndexPath] {
      let startIndex = commits.count - newCommits.count
      let endIndex = startIndex + newCommits.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
