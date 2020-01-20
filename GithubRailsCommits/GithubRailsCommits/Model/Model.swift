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
    let url: String
    let commentCount: Int

    enum CodingKeys: String, CodingKey {
        case author, message, url
        case commentCount = "comment_count"
    }
}

// MARK: - CommitAuthor
struct CommitAuthor: Codable {
    let name, email: String
    let date: Date
}


typealias Commits = [Commit]
