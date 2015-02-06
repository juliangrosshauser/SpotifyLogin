//
//  JGHSpotifySessionController.h
//  JGHSpotifySessionManager
//
//  Created by Julian Grosshauser on 06/02/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Spotify/Spotify.h>

@interface JGHSpotifySessionController : UIViewController

- (instancetype)initWithSession:(SPTSession *)session;

@end
