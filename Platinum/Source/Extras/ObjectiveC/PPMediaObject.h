//
//  PPMediaObject.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPUPnP.h"


#if !defined(_PLT_MEDIA_ITEM_H_)
typedef struct PLT_MediaObject PLT_MediaObject;
#endif


@interface PPMediaObject : NSObject {
	PLT_MediaObject *object;
}

- (id)initWithObject:(PLT_MediaObject *)obj;

@end
