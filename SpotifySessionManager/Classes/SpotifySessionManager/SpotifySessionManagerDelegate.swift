//
//  SpotifySessionManagerDelegate.swift
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/03/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

protocol SpotifySessionManagerDelegate {
    func createdSession(session: SPTSession?, error: NSError?)
}
