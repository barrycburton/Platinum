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

@property (nonatomic) BOOL mute;
@property (nonatomic) NSUInteger volume;
@property (nonatomic) NSUInteger deviceVolume;
@property (nonatomic, retain) PPMediaItem *song;
@property (nonatomic) NSUInteger position;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL wasPlaying;
@property (nonatomic, assign) PPMediaController *controller;
@property (nonatomic) BOOL isSpeaker;
@property (nonatomic) BOOL stopRequested;
@property (nonatomic) BOOL songFinished;
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
