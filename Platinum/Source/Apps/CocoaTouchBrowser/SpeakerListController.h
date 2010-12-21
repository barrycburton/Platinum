//
//  SpeakerListController.h
//  CocoaTouchBrowser
//
//  Created by Barry Burton on 12/21/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMediaController.h"

@interface SpeakerListController : UITableViewController { }

@property (nonatomic, retain) PPMediaController *controller;
@property (nonatomic, retain) NSArray *list;
@property (nonatomic, retain) UIBarButtonItem *doneButtonItem;

- (id)initWithController:(PPMediaController *)theController;
- (void)refreshList;

@end
