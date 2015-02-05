//
//  JGHLoginController.m
//  JGHSpotifySessionManager
//
//  Created by Julian Grosshauser on 04/02/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import "JGHSpotifyLoginController.h"
#import "JGHSpotifySessionManager.h"

@implementation JGHSpotifyLoginController

- (instancetype)init {
    if (self = [super init]) {
        [JGHSpotifySessionManager sharedInstance].delegate = self;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:NSLocalizedString(@"Login with Spotify", nil) forState:UIControlStateNormal];
    [loginButton sizeToFit];
    loginButton.center = self.view.center;
    [loginButton addTarget:[JGHSpotifySessionManager sharedInstance] action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

#pragma mark - JGHSpotifySessionManagerDelegate

- (void)createdSession:(SPTSession *)session withError:(NSError *)error {
    if(error) {
        NSLog(@"%@", error.localizedDescription);
    } else {
        NSLog(@"Successfully created session");
    }
}

@end
