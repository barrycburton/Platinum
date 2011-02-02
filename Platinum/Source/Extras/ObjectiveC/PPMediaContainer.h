//
//  PPMediaContainer.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPMediaObject.h"

#if !defined(_PLT_MEDIA_ITEM_H_)
typedef struct PLT_MediaContainer PLT_MediaContainer;
#endif

@interface PPMediaContainer : PPMediaObject {
	PLT_MediaContainer *container;
}

@property (nonatomic, assign) NSUInteger childCount;

- (id)initWithContainer:(PLT_MediaContainer *)obj;
- (BOOL)updateChildCount:(NSUInteger)newChildCount;

@end