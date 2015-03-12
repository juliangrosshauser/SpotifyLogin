//
//  LoginViewModel.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 12/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

class LoginViewModel {

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
                    NSLog("Error during session creation")
                } else {
                    User.sharedInstance.session = session
                }
            }

            return true
        }
        
        return false
    }
}
