//
//  SpotifySessionController.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class SpotifyController: UIViewController {

    //MARK: Initialization

    override init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        let label: UILabel = UILabel()
        label.text = "Successfully created Spotify session"
        label.sizeToFit()
        label.center = self.view.center
        self.view.addSubview(label)

        let logoutButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteSession")
        self.navigationItem.leftBarButtonItem = logoutButton
    }

    //MARK: SpotifySessionController

    @objc
    func deleteSession() {
        User.sharedInstance.session = nil;
    }
}
