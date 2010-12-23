//
//  SpeakerViewController
//  CocoaTouchBrowser
//
//  Created by Barry Burton on 12/21/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "SpeakerViewController.h"


@implementation SpeakerViewController

@synthesize controller;
@synthesize speaker;

@synthesize artistName;
@synthesize albumName;
@synthesize trackName;
@synthesize currentTime;
@synthesize totalTime;

@synthesize playButton;
@synthesize nextButton;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id)initWithController:(PPMediaController *)theController speaker:(PPMediaDevice *)theSpeaker {
	self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization.
		self.controller = theController;
		self.speaker = theSpeaker;

    }
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
