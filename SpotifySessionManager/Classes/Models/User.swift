//
//  User.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 11/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

class User {

    //MARK: Properties

    static let sessionUpdatedNotification: String = "SessionUpdatedNotification"
    static let sessionRemovedNotification: String = "SessionRemovedNotification"

    static let sharedInstance: User = User()

    var session: SPTSession? = nil {
        didSet {
            let notificationCenter = NSNotificationCenter.defaultCenter()

            if let newSession = session {
                notificationCenter.postNotificationName(User.sessionUpdatedNotification, object: nil)
            } else {
                notificationCenter.postNotificationName(User.sessionRemovedNotification, object: nil)
            }
        }
    }
}
