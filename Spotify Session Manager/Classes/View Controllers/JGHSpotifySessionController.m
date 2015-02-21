//
//  JGHSpotifySessionController.m
//  Spotify Session Manager
//
//  Created by Julian Grosshauser on 06/02/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import "JGHSpotifySessionController.h"

@interface JGHSpotifySessionController ()

@property (nonatomic) SPTSession *session;

@end

@implementation JGHSpotifySessionController

- (instancetype)initWithSession:(SPTSession *)session {
    if (self = [super init]) {
        _session = session;
        UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Logout", nil) style:UIBarButtonItemStylePlain target:self action:@selector(deleteSession)];
        self.navigationItem.leftBarButtonItem = logoutButton;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [UILabel new];
    label.text = @"Successfully created Spotify session";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}

- (void)deleteSession {
    self.session = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
