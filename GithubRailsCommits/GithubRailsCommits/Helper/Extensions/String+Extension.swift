//
//  String+Extensions.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import UIKit


extension NSMutableAttributedString {
    @discardableResult func append(
        _ text: String,
        font: UIFont,
        textColor: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor]
        let textString = NSMutableAttributedString(string: text, attributes: attrs)
        append(textString)
        return self
    }
}
