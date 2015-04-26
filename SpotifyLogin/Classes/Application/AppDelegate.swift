//
//  AppDelegate.swift
//  SpotifyLogin
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: Properties

    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = .whiteColor()
        window.rootViewController = UINavigationController(rootViewController: LoginController())
        return window
    }()

    //MARK: UIApplicationDelegate

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window?.makeKeyAndVisible()
        
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        if let
            window = window,
            rootViewController = window.rootViewController as? UINavigationController,
            loginController = rootViewController.topViewController as? LoginController {
                return loginController.viewModel.handleAuthCallBackWithTriggeredAuthURL(url)
        }

        return false;
    }
}
