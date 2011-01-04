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
@synthesize song;
@synthesize position;
@synthesize isPlaying;
@synthesize wasPlaying;
@synthesize controller;
@synthesize isSpeaker;

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

- (void)setVolume:(NSUInteger)newVolume {
	volume = newVolume;
}

- (void)updateTime {
	if ( isPlaying ) {
		CFAbsoluteTime newTime = CFAbsoluteTimeGetCurrent();
		if ( newTime - absoluteTime >= 1.0 ) {
			position += (NSUInteger)(newTime - absoluteTime);
			absoluteTime = newTime;
			[self.controller.delegate speakerUpdated:self];
		}
		[self performSelector:@selector(updateTime) withObject:nil afterDelay:0.1];
	}
}

- (void)startTimer {
	absoluteTime = CFAbsoluteTimeGetCurrent();
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

- (NSUInteger)volume {
	NSUInteger ret = volume;
	return ret;
}

- (BOOL)isPlaying {
	BOOL ret = isPlaying;
	return ret;
}

- (void)setOwner:(id)parent {
	device->owner = parent;
}

- (id)getOwner {
	return device->owner;
}

- (BOOL)isDeviceEqual:(void *)otherDevice {
	PLT_DeviceData *speakerDevice = (PLT_DeviceData *)otherDevice;
	return device->mediaDevice->GetUUID().Compare(speakerDevice->GetUUID(), true);
}

@end
