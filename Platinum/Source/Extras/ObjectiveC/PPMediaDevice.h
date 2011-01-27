//
//  PPMediaDevice.h
//  Platinum
//
//  Created by Barry Burton on 12/16/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPUPnP.h"
#import "PPMediaContainer.h"
#import "PPMediaItem.h"


#if !defined(_PP_MEDIA_DEVICE_H_)
typedef struct PP_MediaDevice PP_MediaDevice;
#endif

@class PPMediaController;

@interface PPMediaDevice : NSObject {
	PP_MediaDevice *device;
	CFAbsoluteTime absoluteTime;
	CFAbsoluteTime lastSync;
}

@property (assign) BOOL mute;
@property (assign) NSUInteger volume;
@property (assign) NSUInteger deviceVolume;
@property (retain) PPMediaItem *song;
@property (assign) NSUInteger position;
@property (assign) BOOL isPlaying;
@property (assign) BOOL wasPlaying;
@property (assign) PPMediaController *controller;
@property (assign) BOOL isSpeaker;
@property (assign) BOOL stopRequested;
@property (assign) BOOL songFinished;
@property (assign) CFAbsoluteTime lastVolChange;

- (id)initWithController:(PPMediaController *)theController andDevice:(PP_MediaDevice *)deviceData;
- (PP_MediaDevice *)deviceData;

- (NSString *)name;
- (NSString *)uuid;

- (PPMediaContainer *)rootContainer;

- (void)setIsPlaying:(BOOL)playing;

- (void)setOwner:(id)parent;
- (id)getOwner;

- (PP_MediaDevice *)getDevice;

- (BOOL)isDeviceEqual:(void *)device;

- (BOOL)isEqual:(PPMediaDevice *)mediaDevice;

@end
