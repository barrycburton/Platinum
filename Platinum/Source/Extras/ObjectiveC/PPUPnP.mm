//
//  PltUPnPObject.mm
//  Platinum
//
//  Created by Sylvain on 9/14/10.
//  Copyright 2010 Plutinosoft LLC. All rights reserved.
//

#import "Platinum.h"
#import "PltMediaController.h"

#import "PPUPnP.h"

@implementation PPUPnP

- (id)init {
    if ( ( self = [super init]) ) {
        upnp = new PLT_UPnP();
    }
    return self;
}

- (void)dealloc {
    delete upnp;
    [super dealloc];
}

- (PLT_UPnP*)PLTUPnP {
	return upnp;
}

- (BOOL)isRunning {
    return upnp->IsRunning();
}

- (NPT_Result)start {
    return upnp->Start();
}

- (NPT_Result)stop {
    return upnp->Stop();
}

@end
