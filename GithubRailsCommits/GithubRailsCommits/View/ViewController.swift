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
        guard
            let url = URL(string: "https://api.github.com/repos/rails/rails/commits")
        else { return }
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()

                guard let data = data else {
                    self?.setAlert(title: "Response Error", message: error?.localizedDescription)
                    return
                }
                do {
                    let commitData = try JSONDecoder().decode(Commits.self, from: data)
                    self?.commits = commitData
                    self?.tableView.reloadData()
                } catch let error {
                    print(error.localizedDescription)
                    self?.setAlert(title: "Codable Error", message: error.localizedDescription)
                }
            }
        }.resume()
    }
}

extension UIViewController {

    func setAlert(title: String?, message: String?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertViewController, animated: true)
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
