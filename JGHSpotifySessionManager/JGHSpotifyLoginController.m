//
//  JGHLoginController.m
//  JGHSpotifySessionManager
//
//  Created by Julian Grosshauser on 04/02/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import "JGHSpotifyLoginController.h"
#import "JGHSpotifySessionManager.h"
#import "JGHSpotifySessionController.h"

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
    [loginButton addTarget:[JGHSpotifySessionManager class] action:@selector(createSession) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

#pragma mark - JGHSpotifySessionManagerDelegate

- (void)createdSession:(SPTSession *)session withError:(NSError *)error {
    if(error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Login Error", nil) message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        JGHSpotifySessionController *sessionController = [[JGHSpotifySessionController alloc] initWithSession:session];
        [self.navigationController pushViewController:sessionController animated:YES];
    }
}

@end
