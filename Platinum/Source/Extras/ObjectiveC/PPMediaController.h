//
//  PPMediaController.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "NptTypes.h"
#import "NptResults.h"

#if !defined(_PLATINUM_H_)
typedef struct PLT_CtrlPoint PLT_CtrlPoint;
typedef struct PLT_MediaController PLT_MediaController;
typedef struct PLT_MediaBrowser PLT_MediaBrowser;
typedef struct PLT_MediaDelegate
#endif


@protocol PPMediaControllerDelegate

-(void) handleDiscovery: (DiscoveryWrapper*) wrapper;
-(void) handleBrowseResponse: (BrowseResponseWrapper*) wrapper;

@end


@class PPMediaController : NSObject {
	PLT_CtrlPoint *ctrlPoint;
	PLT_MediaController *mediaController;
	PLT_MediaBrowser *mediaBrowser;
	PLT_MediaDelegate *mediaDelegate;
}

@end
