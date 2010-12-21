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
#import "PPMediaContainer.h"
#import "PPMediaItem.h"


class PP_MediaObject {
public:
	PP_MediaObject(PLT_MediaObject *object) : mediaObject(object) {
		
	}
	
	virtual ~PP_MediaObject() {
		
	}
	
	
	PLT_MediaObject *mediaObject;
	PLT_MediaObjectListReference childList;
};



@implementation PPMediaObject


+ (id)PPMediaObjectWithObject:(PLT_MediaObject *)obj {
	PPMediaObject *newObject;
	if ( obj->IsContainer() ) {
		newObject = [[PPMediaContainer alloc] initWithContainer:(PLT_MediaContainer *)obj];
	} else {
		newObject = [[PPMediaItem alloc] initWithItem:(PLT_MediaItem *)obj];
	}
    return newObject;
}

- (id)initWithObject:(PLT_MediaObject *)obj {
	if ( self = [super init] ) {
		object = new PP_MediaObject(obj);
	}
    return self;
}

- (void)dealloc {
    delete object;
	
    [super dealloc];
}

- (NSString *)name {
	return [NSString stringWithUTF8String:(char*)object->mediaObject->m_Title];
}

- (NSString *)objectId {
	return [NSString stringWithUTF8String:(char*)object->mediaObject->m_ObjectID];
}

- (BOOL)isContainer {
	return (BOOL)object->mediaObject->IsContainer();
}

- (PP_MediaObject *)getMediaObject {
	return object;
}

@end
