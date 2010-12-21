//
//  PPMediaDevice.mm
//  Platinum
//
//  Created by Barry Burton on 12/16/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "Platinum.h"
#import "PltDeviceData.h"

#import "PP_MediaDevice.h"
#import "PPMediaDevice.h"

#import "PltMediaItem.h"

@implementation PPMediaDevice

- (id)initWithDevice:(PP_MediaDevice *)deviceData {
	if ( self = [super init] ) {
		device = deviceData;
	}
    return self;
}

- (void)dealloc {
	
    [super dealloc];
}

- (PP_MediaDevice *)deviceData {
	return device;
}

- (NSString *)name {
	return [NSString stringWithUTF8String:(char*)device->mediaDevice->GetFriendlyName()];
}

- (PPMediaContainer *)rootContainer {
	PLT_MediaContainer *rootcpp = new PLT_MediaContainer();
	rootcpp->m_ObjectID = NPT_String("0");
	rootcpp->m_Title = NPT_String(device->mediaDevice->GetFriendlyName());
	PPMediaContainer *root = [[PPMediaContainer alloc] initWithContainer:rootcpp];
	return root;
}

@end
