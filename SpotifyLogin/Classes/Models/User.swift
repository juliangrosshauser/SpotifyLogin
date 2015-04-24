//
//  User.swift
//  SpotifyLogin
//
//  Created by Julian Grosshauser on 11/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

class User {

    //MARK: Properties

    static let sessionUpdatedNotification = "SessionUpdatedNotification"
    static let sessionRemovedNotification = "SessionRemovedNotification"

    static let sharedInstance = User()

    var session: SPTSession? = nil {
        didSet {
            let notificationCenter = NSNotificationCenter.defaultCenter()

            if let session = session {
                notificationCenter.postNotificationName(User.sessionUpdatedNotification, object: nil)
            } else {
                notificationCenter.postNotificationName(User.sessionRemovedNotification, object: nil)
            }
        }
    }
}
