//
//  PPMediaController.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPUPnP.h"
#import "PPMediaDevice.h"
#import "PPMediaItem.h"

typedef struct PP_MediaController PP_MediaController;


@protocol PPMediaControllerDelegate

- (BOOL)shouldAddDevice:(void *)wrapper;
- (void)didRemoveDevice:(void *)wrapper;
- (BOOL)shouldAddSpeaker:(void *)wrapper;
- (void)didRemoveSpeaker:(void *)wrapper;
- (void)browseDidRespond:(NSArray *)list toQuery:(id)userData;
- (void)speakerUpdated:(PPMediaDevice *)speaker;

@end


@interface PPMediaController : NSObject { 
	PP_MediaController *mediaController;
}

@property (nonatomic, assign) id<PPMediaControllerDelegate> delegate;

- (id)initWithUPnP:(PPUPnP *)upnp;

- (NSArray *)mediaRenderers;
- (NSArray *)mediaServers;

- (BOOL)browseContentsOfFolder:(NSString *)folderId onServer:(PPMediaDevice *)server fromIndex:(NSUInteger)start forNumber:(NSUInteger)count userData:(id)userData;

- (BOOL)browseMetadataOfItem:(NSString *)itemId onServer:(PPMediaDevice *)server userData:(id)userData;


- (BOOL)updateMediaInfoForSpeaker:(PPMediaDevice *)speaker;

- (BOOL)updatePositionInfoForSpeaker:(PPMediaDevice *)speaker;

- (BOOL)updateTransportInfoForSpeaker:(PPMediaDevice *)speaker;

- (BOOL)pauseSpeaker:(PPMediaDevice *)speaker;

- (BOOL)playSpeaker:(PPMediaDevice *)speaker;

- (BOOL)stopSpeaker:(PPMediaDevice *)speaker;

- (BOOL)setCurrentSong:(PPMediaItem *)song onSpeaker:(PPMediaDevice *)speaker;

- (BOOL)setMuted:(BOOL)mute onSpeaker:(PPMediaDevice *)speaker;

- (BOOL)updateMutedForSpeaker:(PPMediaDevice *)speaker;

- (BOOL)setVolume:(NSUInteger)volume onSpeaker:(PPMediaDevice *)speaker;

- (BOOL)updateVolumeForSpeaker:(PPMediaDevice *)speaker;

@end
