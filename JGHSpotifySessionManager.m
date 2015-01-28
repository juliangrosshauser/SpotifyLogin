//
//  JGHSpotifySessionManager.m
//
//  Created by Julian Grosshauser on 26/01/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import "JGHSpotifySessionManager.h"

@implementation JGHSpotifySessionManager

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class JGHSpotifyAuthenticationManager"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initSharedInstance {
    return [super init];
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initSharedInstance];
    });

    return sharedInstance;
}

- (void)login {
    if (self.session) {
        [self.delegate didLoginSuccessfully];
        return;
    }

    // Create SPTAuth instance; create login URL and open it
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURLForClientId:kJGHSpotifyClientID
                                                 declaredRedirectURL:[NSURL URLWithString:kJGHSpotifyCallbackURL]
                                                              scopes:@[SPTAuthStreamingScope]];

    [[UIApplication sharedApplication] openURL:loginURL];
}

- (BOOL)handleAuthCallbackWithTriggeredAuthURL:(NSURL *)url {
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:url withDeclaredRedirectURL:[NSURL URLWithString:kJGHSpotifyCallbackURL]]) {
        // Call the token swap service to get a logged in session
        [[SPTAuth defaultInstance]
         handleAuthCallbackWithTriggeredAuthURL:url
         tokenSwapServiceEndpointAtURL:[NSURL URLWithString:kJGHSpotifyTokenSwapURL]
         callback:^(NSError *error, SPTSession *session) {
             if (error) {
                 NSLog(@"Authentication error: %@", error);
                 return;
             }

             self.session = session;
             [self.delegate didLoginSuccessfully];
         }];

        return YES;
    }

    return NO;
}

@end
