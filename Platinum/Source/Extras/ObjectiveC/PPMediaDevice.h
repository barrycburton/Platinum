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
}

@property (nonatomic) BOOL mute;
@property (nonatomic) NSUInteger volume;
@property (nonatomic, retain) PPMediaItem *song;
@property (nonatomic) NSUInteger position;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic, assign) PPMediaController *controller;

- (id)initWithController:(PPMediaController *)theController andDevice:(PP_MediaDevice *)deviceData;
- (PP_MediaDevice *)deviceData;

- (NSString *)name;

- (PPMediaContainer *)rootContainer;

- (void)setIsPlaying:(BOOL)playing;

@end
