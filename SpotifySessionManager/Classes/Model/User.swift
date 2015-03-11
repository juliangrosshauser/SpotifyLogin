//
//  User.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 11/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

class User {

    //MARK: Properties
    
    static let sharedInstance: User = User(session: nil)
    var session: SPTSession?

    //MARK: Initialization

    init(session: SPTSession?) {
        self.session = session
    }
}