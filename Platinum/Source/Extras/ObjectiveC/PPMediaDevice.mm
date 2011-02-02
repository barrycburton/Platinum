//
//  PPMediaDevice.mm
//  Platinum
//
//  Created by Barry Burton on 12/16/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "NptTypes.h"
#import "NptResults.h"

#import "Platinum.h"
#import "PltDeviceData.h"

#import "PP_MediaDevice.h"
#import "PPMediaDevice.h"

#import "PltMediaItem.h"

#import "PPMediaController.h"

#import <CoreFoundation/CFDate.h>

@implementation PPMediaDevice

@synthesize mute;
@synthesize volume;
@synthesize deviceVolume;
@synthesize song;
@synthesize position;
@synthesize isPlaying;
@synthesize wasPlaying;
@synthesize controller;
@synthesize isSpeaker;
@synthesize stopRequested;
@synthesize songFinished;
@synthesize lastVolChange;


- (id)initWithController:(PPMediaController *)theController andDevice:(PP_MediaDevice *)deviceData {
	if ( self = [super init] ) {
		device = deviceData;
		controller = theController;
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

- (NSString *)uuid {
	return [NSString stringWithUTF8String:(char*)device->mediaDevice->GetUUID()];
}

- (PPMediaContainer *)rootContainer {
	PLT_MediaContainer *rootcpp = new PLT_MediaContainer();
	rootcpp->m_ObjectClass.type = NPT_String("object.container");
	rootcpp->m_ObjectID = NPT_String("0");
	rootcpp->m_Title = NPT_String(device->mediaDevice->GetFriendlyName());
	PPMediaContainer *root = [[PPMediaContainer alloc] initWithContainer:rootcpp];
	return root;
}

- (void)updateTime {
	if ( isPlaying ) {
		CFAbsoluteTime newTime = CFAbsoluteTimeGetCurrent();
		if ( newTime < absoluteTime ) {
			absoluteTime = CFAbsoluteTimeGetCurrent();
		}
		if ( newTime - absoluteTime >= 1.0 ) {
			position += (NSUInteger)(newTime - absoluteTime);
			absoluteTime = newTime;
			if ( position >= song.duration ) {
				position = song.duration;
			}
			if ( position + 2 >= song.duration ) {
				self.songFinished = YES;
			}
			[self.controller.delegate speakerUpdated:self];
		}
		if ( newTime - lastSync >= 10 || newTime < lastSync ) {
			lastSync = newTime;
			[self.controller updatePositionInfoForSpeaker:self];
		}
		[self performSelector:@selector(updateTime) withObject:nil afterDelay:0.1];
	}
}

- (void)startTimer {
	absoluteTime = CFAbsoluteTimeGetCurrent();
	lastSync = CFAbsoluteTimeGetCurrent();
	[self performSelector:@selector(updateTime) withObject:nil afterDelay:0.1];
}

- (void)setIsPlaying:(BOOL)playing {
	if ( isPlaying != playing ) {
		isPlaying = playing;
		if ( isPlaying ) {
			// start timer
			[self performSelectorOnMainThread:@selector(startTimer) withObject:nil waitUntilDone:NO];
		}
	}
}

- (BOOL)isPlaying {
	BOOL ret = isPlaying;
	return ret;
}

- (void)setOwner:(id)parent {
	if ( parent != device->owner ) {
		[parent retain];
		[device->owner release];
		device->owner = parent;
	}
}

- (id)owner {
	return device->owner;
}

- (PP_MediaDevice *)getDevice {
	return device;
}

- (BOOL)isEqualToMediaDevice:(PPMediaDevice *)mediaDevice {
	if ( [mediaDevice isKindOfClass:[PPMediaDevice class]] ) {
		PP_MediaDevice *otherDevice = [mediaDevice getDevice];
		return device->mediaDevice->GetUUID().Compare(otherDevice->mediaDevice->GetUUID(), true) == 0 ? YES : NO;
	}
	return NO;
}

- (BOOL)isEqualToPltDevice:(void *)pltDevice {
	PLT_DeviceData *pltDeviceData = (PLT_DeviceData *)pltDevice;
	return device->mediaDevice->GetUUID().Compare(pltDeviceData->GetUUID(), true) == 0 ? YES : NO;
}

@end
