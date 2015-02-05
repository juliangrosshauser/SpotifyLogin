//
//  JGHSpotifySessionManagerDelegate.h
//  JGHSpotifySessionManager
//
//  Created by Julian Grosshauser on 27/01/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import <Spotify/Spotify.h>

@protocol JGHSpotifySessionManagerDelegate <NSObject>

- (void)createdSession:(SPTSession *)session withError:(NSError *)error;

@end
