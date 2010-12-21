//
//  PPMediaController.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPUPnP.h"
#import "PPMediaDevice.h"

typedef struct PP_MediaController PP_MediaController;


@protocol PPMediaControllerDelegate

- (BOOL)shouldAddDevice:(void *)wrapper;
- (void)didRemoveDevice:(void *)wrapper;
- (void)stateVariableDidChange:(void *)wrapper;
- (void)browseDidRespond:(NSArray *)list toQuery:(id)userData;

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

@end
