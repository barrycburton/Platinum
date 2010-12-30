//
//  PPMediaItem.m
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "Platinum.h"
#import "PltMediaItem.h"

#import "PPMediaItem.h"


@implementation PPMediaItem

- (id)initWithItem:(PLT_MediaItem *)obj {
	if ( self = [super initWithObject:obj] ) {
		item = obj;
	}
    return self;
}

- (void)dealloc {
	
    [super dealloc];
}

- (NSString *)metaData {
	return [NSString stringWithUTF8String:(char *)item->m_Didl];
}

- (NSString *)trackName {
	return [super name];
}

- (NSString *)albumName {
	return [NSString stringWithUTF8String:(char *)item->m_Affiliation.album];
}

- (NSString *)artistName {
	return [NSString stringWithUTF8String:(char *)item->m_Creator];
}

- (NSUInteger)duration {
	if ( item->m_Resources.GetItemCount() > 0 ) {
		PLT_MediaItemResource resource = item->m_Resources[0];
		return resource.m_Duration;
	}
	return 0;
}


@end
