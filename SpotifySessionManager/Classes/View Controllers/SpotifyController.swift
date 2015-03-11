//
//  SpotifySessionController.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class SpotifyController: UIViewController {

    //MARK: Properties

    private var session: SPTSession?

    //MARK: Initialization

    init(session: SPTSession) {
        super.init(nibName: nil, bundle: nil)

        self.session = session
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
    }

    //MARK: SpotifySessionController

    func deleteSession() {
        self.session = nil
        self.navigationController?.popViewControllerAnimated(true)
    }
}
