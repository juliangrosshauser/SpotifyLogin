//
//  SpotifyLoginController.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class SpotifyLoginController: UIViewController, SpotifySessionManagerDelegate {

    //MARK: Initialization

    override init() {
        super.init(nibName: nil, bundle: nil)

        SpotifySessionManager.sharedInstance.delegate = self
        self.title = "Login with Spotify"
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        loginButton.setTitle("Login with Spotify", forState: UIControlState.Normal)
        loginButton.sizeToFit()
        loginButton.center = self.view.center
        loginButton.addTarget(SpotifySessionManager.self, action: "createSession", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
    }

    //MARK: SpotifySessionManagerDelegate

    func createdSession(session: SPTSession?, error: NSError?) {
        if let sessionCreationError = error {
            let alertController: UIAlertController = UIAlertController(title: "Login Error", message: sessionCreationError.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            if let createdSession = session {
                let sessionController: SpotifySessionController = SpotifySessionController(session: createdSession)
                self.navigationController?.pushViewController(sessionController, animated: true)
            }
        }
    }
}
