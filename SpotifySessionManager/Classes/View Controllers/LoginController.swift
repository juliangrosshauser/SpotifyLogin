//
//  SpotifyLoginController.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    //MARK: Properties

    let viewModel: LoginViewModel = LoginViewModel()

    //MARK: Initialization

    override init() {
        super.init(nibName: nil, bundle: nil)

        self.title = "Login with Spotify"

        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserverForName(self.viewModel.loginFailedNotification, object: nil, queue: nil) { (notification) in
            let error: NSError = notification.object as! NSError!

            let alertController: UIAlertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(alertAction)

            self.presentViewController(alertController, animated: true, completion: nil)
        }

        notificationCenter.addObserverForName(User.sessionUpdatedNotification, object: nil, queue: nil) { (notification) in
            self.navigationController?.pushViewController(SpotifyController(), animated: true)
        }

        notificationCenter.addObserverForName(User.sessionRemovedNotification, object: nil, queue: nil) { (notification) in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
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
        loginButton.addTarget(self.viewModel, action: "createSession", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
    }
}
