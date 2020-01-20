//
//  NSError+Extension.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(_ localizedDescriprion: String) {
        self.init(domain: "com.sterling", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescriprion])
    }
}
