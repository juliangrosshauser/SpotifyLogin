//
//  LoginController.swift
//  SpotifyLogin
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    //MARK: Properties

    let viewModel = LoginViewModel()

    let loginButton: UIButton = {
        let button = UIButton()

        button.setTitle("Login with Spotify", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.sizeToFit()

        return button
    }()

    //MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Login with Spotify"

        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserverForName(viewModel.loginFailedNotification, object: nil, queue: nil) { (notification) in
            let error = notification.object as! NSError

            let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(alertAction)

            self.presentViewController(alertController, animated: true, completion: nil)
        }

        notificationCenter.addObserverForName(User.sessionUpdatedNotification, object: nil, queue: nil) { (notification) in
            navigationController?.pushViewController(SpotifyController(), animated: true)
        }

        notificationCenter.addObserverForName(User.sessionRemovedNotification, object: nil, queue: nil) { (notification) in
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(viewModel, action: "createSession", forControlEvents: .TouchUpInside)
        view.addSubview(loginButton)
    }

    override func viewWillLayoutSubviews() {
        loginButton.center = view.center
    }
}
