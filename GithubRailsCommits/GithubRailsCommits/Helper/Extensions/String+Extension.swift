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
        textColor: UIColor,
        lineSpacing: CGFloat = 0) -> NSMutableAttributedString {
        let paragraphStype = NSMutableParagraphStyle()
        paragraphStype.lineSpacing = lineSpacing
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: paragraphStype]
        let textString = NSMutableAttributedString(string: text, attributes: attrs)
        append(textString)
        return self
    }
}
