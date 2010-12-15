//
//  PPUPnP.h
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "NptTypes.h"
#import "NptResults.h"

#if !defined(_PLATINUM_H_)
typedef struct PLT_UPnP PLT_UPnP;
#endif

@interface PPUPnP : NSObject {
@private
    PLT_UPnP *upnp;
}

@property (nonatomic, readonly, getter=isRunning) BOOL running;

- (NPT_Result)start;
- (NPT_Result)stop;

@end
