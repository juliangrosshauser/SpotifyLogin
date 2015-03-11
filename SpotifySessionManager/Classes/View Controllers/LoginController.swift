//
//  SpotifyLoginController.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    //MARK: Initialization

    override init() {
        super.init(nibName: nil, bundle: nil)

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
        loginButton.addTarget(self, action: "createSession", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
    }

    @objc
    func createSession() {
        // Create SPTAuth instance; create login URL and open it
        let loginURL: NSURL = SPTAuth.defaultInstance().loginURLForClientId(SpotifyApp.clientID, declaredRedirectURL: NSURL(string: SpotifyApp.callbackURL), scopes: [SPTAuthStreamingScope])
        UIApplication.sharedApplication().openURL(loginURL)
    }

    func handleAuthCallBackWithTriggeredAuthURL(url: NSURL) -> Bool {
        // Ask SPTAuth if the URL given is a Spotify authentication callback
        if (SPTAuth.defaultInstance().canHandleURL(url, withDeclaredRedirectURL: NSURL(string: SpotifyApp.callbackURL))) {
            // Call the token swap service to get a logged in session
            SPTAuth.defaultInstance().handleAuthCallbackWithTriggeredAuthURL(url, tokenSwapServiceEndpointAtURL: NSURL(string: SpotifyApp.tokenSwapURL)) {
                (error, session) in
                if let sessionCreationError = error {
                    let alertController: UIAlertController = UIAlertController(title: "Login Error", message: sessionCreationError.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alertController.addAction(alertAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                } else {
                    User.sharedInstance.session = session

                    self.navigationController?.pushViewController(SpotifyController(session: session), animated: true)
                }
            }

            return true
        }

        return false
    }
}
