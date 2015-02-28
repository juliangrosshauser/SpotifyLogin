//
//  JGHAppDelegate.m
//  SpotifySessionManager
//
//  Created by Julian Grosshauser on 04/02/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import "JGHAppDelegate.h"
#import "JGHSpotifyLoginController.h"
#import "JGHSpotifySessionManager.h"

@implementation JGHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    JGHSpotifyLoginController *loginController = [JGHSpotifyLoginController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {

    return [[JGHSpotifySessionManager sharedInstance] handleAuthCallbackWithTriggeredAuthURL:url];
}

@end
