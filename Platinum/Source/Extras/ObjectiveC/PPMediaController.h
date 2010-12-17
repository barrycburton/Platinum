//
//  PPMediaController.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "PPUPnP.h"


typedef struct PP_MediaController PP_MediaController;


@protocol PPMediaControllerDelegate

- (BOOL)shouldAddDevice:(void *)wrapper;
- (void)didRemoveDevice:(void *)wrapper;
- (void)stateVariableDidChange:(void *)wrapper;
- (void)browseDidRespond:(void *)wrapper;
- (void)searchDidRespond:(void *)wrapper;

@end


@interface PPMediaController : NSObject { 
	PP_MediaController *mediaController;
}

@property (nonatomic, assign) id<PPMediaControllerDelegate> delegate;

- (id)initWithUPnP:(PPUPnP *)upnp;

- (NSArray *)mediaRenderers;
- (NSArray *)mediaServers;

@end
