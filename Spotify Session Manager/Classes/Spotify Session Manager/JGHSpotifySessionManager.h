//
//  JGHSpotifySessionManager.h
//  Spotify Session Manager
//
//  Created by Julian Grosshauser on 26/01/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import <Spotify/Spotify.h>
#import "JGHSpotifySessionManagerDelegate.h"

@interface JGHSpotifySessionManager : NSObject

@property (nonatomic, weak) id<JGHSpotifySessionManagerDelegate> delegate;

+ (instancetype)sharedInstance;
+ (void)createSession;
- (BOOL)handleAuthCallbackWithTriggeredAuthURL:(NSURL *)url;

@end
