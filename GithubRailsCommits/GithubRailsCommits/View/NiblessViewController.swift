//
//  NiblessViewController.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import UIKit

class NiblessViewController<ViewType: UIView>: UIViewController {
    /// Provides typed access to the view controllers custom view
    var customView: ViewType { return self.view as! ViewType }

    override func loadView() {
        self.view = ViewType(frame: UIScreen.main.bounds)
    }
}
