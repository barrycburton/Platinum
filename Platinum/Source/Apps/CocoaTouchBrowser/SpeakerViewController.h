//
//  SpeakerViewController.h
//  CocoaTouchBrowser
//
//  Created by Barry Burton on 12/21/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMediaController.h"
#import "PPMediaDevice.h"


@interface SpeakerViewController : UIViewController { }

- (id)initWithController:(PPMediaController *)theController speaker:(PPMediaDevice *)theSpeaker;

@end
