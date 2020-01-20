//
//  Model.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation

// MARK: - Commit
struct Commit: Codable {
    let sha: String
    let detail: CommitDetail

    enum CodingKeys: String, CodingKey {
        case sha
        case detail = "commit"
    }
}

// MARK: - CommitDetail
struct CommitDetail: Codable {
    let author: CommitAuthor
    let message: String

    enum CodingKeys: String, CodingKey {
        case author, message
    }
}

// MARK: - CommitAuthor
struct CommitAuthor: Codable {
    let name: String
}


typealias Commits = [Commit]
