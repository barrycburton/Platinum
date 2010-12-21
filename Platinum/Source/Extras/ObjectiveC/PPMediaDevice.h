//
//  PPMediaDevice.h
//  Platinum
//
//  Created by Barry Burton on 12/16/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPUPnP.h"
#import "PPMediaContainer.h"


#if !defined(_PP_MEDIA_DEVICE_H_)
typedef struct PP_MediaDevice PP_MediaDevice;
#endif


@interface PPMediaDevice : NSObject {
	PP_MediaDevice *device;
}

- (id)initWithDevice:(PP_MediaDevice *)deviceData;
- (PP_MediaDevice *)deviceData;

- (NSString *)name;

- (PPMediaContainer *)rootContainer;

@end
