//
//  LoginViewModel.swift
//  SpotifyLogin
//
//  Created by Julian Grosshauser on 12/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

class LoginViewModel {

    //MARK: Properties

    let loginFailedNotification: String = "LoginFailedNotification"

    //MARK: Login

    @objc
    func createSession() {
        // Create SPTAuth instance; create login URL and open it
        let loginURL: NSURL = SPTAuth.loginURLForClientId(SpotifyApp.clientID, withRedirectURL: NSURL(string: SpotifyApp.callbackURL), scopes: [SPTAuthStreamingScope], responseType: "code")
        UIApplication.sharedApplication().openURL(loginURL)
    }

    func handleAuthCallBackWithTriggeredAuthURL(url: NSURL) -> Bool {
        // Ask SPTAuth if the URL given is a Spotify authentication callback
        if (SPTAuth.defaultInstance().canHandleURL(url)) {
            // Call the token swap service to get a logged in session
            SPTAuth.defaultInstance().handleAuthCallbackWithTriggeredAuthURL(url) { (error, session) in
                if let sessionCreationError = error {
                    let notificationCenter = NSNotificationCenter.defaultCenter()
                    notificationCenter.postNotificationName(self.loginFailedNotification, object: error)
                } else {
                    User.sharedInstance.session = session
                }
            }

            return true
        }
        
        return false
    }
}
