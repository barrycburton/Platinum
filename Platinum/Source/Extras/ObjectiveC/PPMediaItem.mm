//
//  PPMediaItem.m
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "Platinum.h"
#import "PltMediaItem.h"

#import "PPMediaItem.h"



@implementation PPMediaItem

- (id)initWithItem:(PLT_MediaItem *)obj {
	if ( self = [super initWithObject:obj] ) {
		item = obj;
	}
    return self;
}

- (void)dealloc {
	
    [super dealloc];
}

@end
