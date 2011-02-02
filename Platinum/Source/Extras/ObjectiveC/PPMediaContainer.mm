//
//  PPMediaContainer.mm
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "NptTypes.h"
#import "NptResults.h"

#import "Platinum.h"
#import "PltMediaItem.h"

#import "PPMediaContainer.h"



@implementation PPMediaContainer

- (id)initWithContainer:(PLT_MediaContainer *)obj {
	if ( self = [super initWithObject:obj] ) {
		container = obj;
	}
    return self;
}

- (NSUInteger)childCount {
	return container->m_ChildrenCount;
}

- (void)setChildCount:(NSUInteger)childCount {
	container->m_ChildrenCount = childCount;
}

- (BOOL)updateChildCount:(NSUInteger)newChildCount {
	if ( self.childCount == -1 && newChildCount != -1 ) {
		self.childCount = newChildCount;
		return YES;
	} else {
		return NO;
	}
}

- (void)dealloc {

    [super dealloc];
}

@end