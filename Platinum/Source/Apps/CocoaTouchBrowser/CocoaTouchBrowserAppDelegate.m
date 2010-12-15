//
//  CocoaTouchBrowserAppDelegate.m
//  CocoaTouchBrowser
//
//  Created by Sylvain on 10/13/09.
//  Copyright Veodia 2009. All rights reserved.
//

#import "CocoaTouchBrowserAppDelegate.h"
#import "RootViewController.h"


@implementation CocoaTouchBrowserAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize upnp;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	self.upnp = [[PltUPnPObject alloc] init];
	[self.upnp start];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[upnp release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

