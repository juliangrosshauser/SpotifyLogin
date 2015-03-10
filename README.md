# SpotifySessionManager

[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://developer.apple.com/devcenter/ios/index.action)
[![License](https://img.shields.io/badge/license-MIT-3f3f3f.svg)](http://choosealicense.com/licenses/mit)

In order to run this project you need to checkout Spotify's iOS framework with [Carthage](https://github.com/Carthage/Carthage) first:

```shell
$ carthage update --no-build
```

## TokenSwapService

> The iOS SDK uses OAuth to authenticate the application user and to authorize your application to access the Spotify service.
> You will you need to run a small HTTP service, called a token exchange service, to complete the authorization process.

Source: [Spotify iOS SDK Tutorial](https://developer.spotify.com/technologies/spotify-ios-sdk/tutorial)

You can find all necessary files for this token exchange service in the [TokenSwapService](TokenSwapService) folder.  
The only thing you need to add is the `secrets.rb` file. This file should contain the following:

```ruby
CLIENT_ID = 'client_id'
CLIENT_SECRET = 'client_secret'
ENCRYPTION_SECRET = 'encryption_secret'
CLIENT_CALLBACK_URL = 'jgh-spotify-session-manager://client-callback-url'
```

You can obtain `CLIENT_ID` and `CLIENT_SECRET` after you created a new app on Spotify's [My Applications](http://developer.spotify.com/my-applications) page.  
On that page you can also set the `CLIENT_CALLBACK_URL`.  
`ENCRYPTION_SECRET` is just a random string, so it's content is entirely up to you.

Before you can run the service, make sure you have [`bundler`](http://bundler.io) installed.  
To install the service's dependencies run `bundle install`.  
After that you can run the service with `ruby spotify_token_swap.rb`.

## Architecture

```
                                                                                                      
                                         ┌──────────────────────┐           ┌────────────────────────┐
                                         │                      │           │                        │
          ┌─────────────┐     openURL    │      LoginView       │           │      SpotifyView       │
          │             │◀───────────────┤                      │           │                        │
          │ AppDelegate │                ├──────────────────────┼──────────▶├────────────────────────┤
          │             ├───────────────▶│                      │           │                        │
          └─────────────┘                │ LoginViewController  │           │ SpotifyViewController  │
 handleAuthCallBackWithTriggeredAuthURL  │                      │           │                        │
                                         └──────────────────────┘           └────────────────────────┘
                                                  ▲  │                                                
                                                  │  │                                                
                                                  │  │                                                
                                                  │  │ set session                                    
                           session changed signal │  │                                                
                                                  │  │                                                
                                                  │  ▼                                                
                                    ┌─────────────┴──────────────────┐                                
                                    │                                │                                
                                    │        User (Singleton)        │                                
                                    │                                │                                
                                    └─────┬────┬───────────────┬─────┘                                
                                          │    │ get user   ▲  │                                      
                                save user │    │            │  │ refresh token                        
                                          │    │   new token│  │                                      
                                          ▼    ▼            │  ▼                                      
                                       ┌──────────┐  ┌──────┴───────────┐                             
                                       │          │  │                  │                             
                                       │ Keychain │  │Token Swap Service│                             
                                       │          │  │                  │                             
                                       └──────────┘  └──────────────────┘                             
```

## License

[MIT](LICENSE)
