//
//  PPMediaObject.mm
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "Platinum.h"
#import "PltMediaItem.h"

#import "PPMediaObject.h"


@implementation PPMediaObject

- (id)initWithObject:(PLT_MediaObject *)obj {
	if ( self = [super init] ) {
		object = obj;
	}
    return self;
}

- (void)dealloc {
    delete object;
	
    [super dealloc];
}

@end
