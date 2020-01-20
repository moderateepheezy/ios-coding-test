//
//  GithubRequest.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation

final class GithubRequest {

    private let requestFactory = RequestFactory()
    private let httpPerformer = HTTPNetworkRequestPerformer()

    func fetchRailsCommits(
        currentPage: Int = 1,
        completion: @escaping ([Commit]?, _ errorMessage: String?) -> Void) {
        let request = requestFactory.makeRequest(url: "https://api.github.com/repos/rails/rails/commits", method: .GET, parameters: ["page": currentPage, "per_page": 30], headers: nil)

        return httpPerformer.performDataTask(with: request, responseType: [Commit].self, completion: completion)
    }

}
