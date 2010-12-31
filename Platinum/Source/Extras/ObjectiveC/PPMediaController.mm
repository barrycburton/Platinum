//
//  PPMediaController.mm
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//

#import "NptTypes.h"
#import "NptResults.h"

#import "Platinum.h"
#import "PltMediaBrowser.h"
#import "PltMediaController.h"

#import "PPMediaController.h"

#import "PP_MediaDevice.h"
#import "PPMediaDevice.h"

#import "PP_MediaObject.h"
#import "PPMediaObject.h"

#import "PltDidl.h"



class PP_MediaController : public PLT_MediaBrowserDelegate, public PLT_MediaControllerDelegate {
public:
	PP_MediaController(PPMediaController *parent, PLT_UPnP *upnp) : master(parent) {
		controlPointRef = PLT_CtrlPointReference(new PLT_CtrlPoint());
		mediaController = new PLT_MediaController(controlPointRef, this);
		mediaBrowser = new PLT_MediaBrowser(controlPointRef, this);
		upnp->AddCtrlPoint(controlPointRef);
	}
	
	virtual ~PP_MediaController() {
		
	}
	
	virtual bool OnMSAdded(PLT_DeviceDataReference& device) {        
		[master.delegate shouldAddDevice:nil];
		return true;
	}
	
	virtual void OnMSRemoved(PLT_DeviceDataReference& device) {
		[master.delegate didRemoveDevice:nil];
	}
	
	virtual void OnMSStateVariablesChanged(PLT_Service*                  service,
										   NPT_List<PLT_StateVariable*>* vars) {
		
	}
	
	virtual void OnBrowseResult(NPT_Result               res,
								PLT_DeviceDataReference& device,
								PLT_BrowseInfo*          info,
								void*                    userdata) {
		
		// First convert result to Obj-C Objects
		NSLog(@"browse item id: %s", (char *)info->object_id);
		
		/*
		typedef struct {
			NPT_String                   object_id;
			PLT_MediaObjectListReference items;
			NPT_UInt32                   nr;
			NPT_UInt32                   tm;
			NPT_UInt32                   uid;
		} PLT_BrowseInfo;
		*/
		
		PPMediaObject *user = (PPMediaObject *)userdata;
		PP_MediaObject *usercpp = [user getMediaObject];
		usercpp->childList = info->items;
		
		NSMutableArray *list = nil;
		
		if ( [user isContainer] ) {
			// New Folder List
				  
			list = [NSMutableArray arrayWithCapacity:10];
			PLT_MediaObjectList::Iterator listIter = info->items->GetFirstItem();
			while ( listIter ) {
				PLT_MediaObject *item = *listIter;
				NSLog(@"title: %s", (char*)item->m_Title);
				
				if ( item->m_Resources.GetItemCount() > 0 ) {
					NSLog(@"Has resources");
				}
				
				PPMediaObject *object = [PPMediaObject PPMediaObjectWithObject:item];
				[list addObject:object];
				
				listIter++;
				
				NSLog(@"new title: %@", [object name]);
			}
		} else if ( info->items->GetItemCount() > 0 ) {
			// Song but with full info
			PLT_MediaObject *item;
			info->items->Get(0, item);
			if ( item ) {
				NSLog(@"title: %s", (char*)item->m_Title);
				
				if ( item->m_Resources.GetItemCount() > 0 ) {
					NSLog(@"Has resources");
				}
				
				[user setObject:item];
			}
		} else {
			NSLog(@"No data found");
		}
		
		// Call delegate with new Objects
		[master.delegate browseDidRespond:list toQuery:(id)userdata];
	}
	
	virtual void OnSearchResult(NPT_Result               res,
						PLT_DeviceDataReference& device,
						PLT_BrowseInfo*          info,
						void*                    userdata) {

		
	}





	// PLT_MediaControllerDelegate methods
	virtual bool OnMRAdded(PLT_DeviceDataReference&  device ) {
		[master.delegate shouldAddSpeaker:nil];
		return true;
	}
	
	virtual void OnMRRemoved(PLT_DeviceDataReference&  device ) {
		[master.delegate didRemoveSpeaker:nil];
	}
	
	virtual void OnMRStateVariablesChanged(PLT_Service*                   service, 
                                           NPT_List<PLT_StateVariable*>*  vars) {
		
		// TODO be more fine grained
		[master.delegate speakerUpdated:nil];
	}
	
    // AVTransport
	virtual void OnGetCurrentTransportActionsResult(NPT_Result                res,
											PLT_DeviceDataReference&  device,
											PLT_StringList*           actions,
											void*                     userdata) {
	
	}
	
	virtual void OnGetDeviceCapabilitiesResult(NPT_Result                res,
									   PLT_DeviceDataReference&  device,
									   PLT_DeviceCapabilities*   capabilities,
									   void*                     userdata) {
		/*
		typedef struct {
			PLT_StringList play_media;
			PLT_StringList rec_media;
			PLT_StringList rec_quality_modes;
		} PLT_DeviceCapabilities;
		*/
	}
	
	virtual void OnGetMediaInfoResult(NPT_Result                res,
							  PLT_DeviceDataReference&  device,
							  PLT_MediaInfo*            info,
							  void*                     userdata) {
		/*
		typedef struct {
			NPT_UInt32    num_tracks;
			NPT_TimeStamp media_duration;
			NPT_String    cur_uri;
			NPT_String    cur_metadata;
			NPT_String    next_uri;
			NPT_String    next_metadata;
			NPT_String    play_medium;
			NPT_String    rec_medium;
			NPT_String    write_status;
		} PLT_MediaInfo;
		 */
		
		if ( info ) {
			PPMediaDevice *speaker = (PPMediaDevice *)userdata;
			if ( 0 && !speaker.song && !info->cur_metadata.IsEmpty() ) {
				PLT_MediaObjectListReference objects;
				PLT_MediaObject *object;
				PLT_Didl::FromDidl((char *)info->cur_metadata, objects);
				objects->Get(0, object);
				if ( object ) {
					speaker.song = [[PPMediaItem alloc] initWithItem:(PLT_MediaItem *)object];
				}
			}
			[master.delegate speakerUpdated:speaker];
		}
	}
	
	virtual void OnGetPositionInfoResult(NPT_Result                res,
								 PLT_DeviceDataReference&  device,
								 PLT_PositionInfo*         info,
								 void*                     userdata) {
		/*
		typedef struct {
			NPT_UInt32    track;
			NPT_TimeStamp track_duration;
			NPT_String    track_metadata;
			NPT_String    track_uri;
			NPT_TimeStamp rel_time;
			NPT_TimeStamp abs_time;
			NPT_Int32     rel_count;
			NPT_Int32     abs_count;
		} PLT_PositionInfo;
		 */
		
		if ( info ) {
			PPMediaDevice *speaker = (PPMediaDevice *)userdata;
			if ( !speaker.song && !info->track_metadata.IsEmpty() ) {
				PLT_MediaObjectListReference objects;
				PLT_MediaObject *object;
				PLT_Didl::FromDidl((char *)info->track_metadata, objects);
				objects->Get(0, object);
				if ( object ) {
					speaker.song = [[PPMediaItem alloc] initWithItem:(PLT_MediaItem *)object];
				}
			}
			speaker.position = info->rel_time.ToSeconds();
			[master.delegate speakerUpdated:speaker];
		}
	}
	
	virtual void OnGetTransportInfoResult(NPT_Result                res,
								  PLT_DeviceDataReference&  device,
								  PLT_TransportInfo*        info,
								  void*                     userdata) {
		/*
		typedef struct {
			NPT_String cur_transport_state;
			NPT_String cur_transport_status;
			NPT_String cur_speed;
		} PLT_TransportInfo;
		 */
	
	}
	
	virtual void OnGetTransportSettingsResult(NPT_Result                res,
									  PLT_DeviceDataReference&  device,
									  PLT_TransportSettings*    settings,
									  void*                     userdata) {
		/*
		typedef struct {
			NPT_String play_mode;
			NPT_String rec_quality_mode;
		} PLT_TransportSettings;
		 */
	
	}
	
	virtual void OnNextResult(NPT_Result                res,
					  PLT_DeviceDataReference&  device,
					  void*                     userdata) {
	
	}
	
	virtual void OnPauseResult(NPT_Result                res,
					   PLT_DeviceDataReference&  device,
					   void*                     userdata) {
	
	}  
	
	virtual void OnPlayResult(NPT_Result                res,
					  PLT_DeviceDataReference&  device,
					  void*                     userdata) {
	
	}
	
	virtual void OnPreviousResult(NPT_Result                res,
						  PLT_DeviceDataReference&  device,
						  void*                     userdata) {
	
	}
	
	virtual void OnSeekResult(NPT_Result                res,
					  PLT_DeviceDataReference&  device,
					  void*                     userdata) {
	
	}
	
	virtual void OnSetAVTransportURIResult(NPT_Result                res,
								   PLT_DeviceDataReference&  device,
								   void*                     userdata) {
		if ( NPT_SUCCESS == res ) {
			NSLog(@"Set");
		}
	
	}
	
	virtual void OnSetPlayModeResult(NPT_Result                res,
							 PLT_DeviceDataReference&  device,
							 void*                     userdata) {
	
	}
	
	virtual void OnStopResult(NPT_Result                res,
					  PLT_DeviceDataReference&  device,
					  void*                     userdata) {
	
	}
	
    // ConnectionManager
	virtual void OnGetCurrentConnectionIDsResult(NPT_Result               res,
										 PLT_DeviceDataReference& device,
										 PLT_StringList*          ids,
										 void*                    userdata) {
	
	}
	
	virtual void OnGetCurrentConnectionInfoResult(NPT_Result               res,
										  PLT_DeviceDataReference& device,
										  PLT_ConnectionInfo*      info,
										  void*                    userdata) {
		/*
		typedef struct {
			NPT_UInt32 rcs_id;
			NPT_UInt32 avtransport_id;
			NPT_String protocol_info;
			NPT_String peer_connection_mgr;
			NPT_UInt32 peer_connection_id;
			NPT_String direction;
			NPT_String status;
		} PLT_ConnectionInfo;
		*/
	
	}
	
	virtual void OnGetProtocolInfoResult(NPT_Result               res,
								 PLT_DeviceDataReference& device,
								 PLT_StringList*          sources,
								 PLT_StringList*          sinks,
								 void*                    userdata) {
	
	}
	
    // RenderingControl
	virtual void OnSetMuteResult(NPT_Result               res,
						 PLT_DeviceDataReference& device,
						 void*                    userdata) {
	
	}
	
	virtual void OnGetMuteResult(NPT_Result                res,
						 PLT_DeviceDataReference&  device,
						 const char*               channel,
						 bool                      mute,
						 void*                     userdata) {
		PPMediaDevice *speaker = (PPMediaDevice *)userdata;
		speaker.mute = mute;
		[master.delegate speakerUpdated:speaker];
	
	}
	
	virtual void OnSetVolumeResult(NPT_Result                res,
						   PLT_DeviceDataReference&  device,
						   void*                     userdata) {

	}
	
	virtual void OnGetVolumeResult(NPT_Result                res,
						   PLT_DeviceDataReference&  device,
						   const char*               channel,
						   NPT_UInt32				 volume,
						   void*                     userdata) {
	
		PPMediaDevice *speaker = (PPMediaDevice *)userdata;
		speaker.volume = volume;
		[master.delegate speakerUpdated:speaker];
	}	
	
	PPMediaController *master;
	PLT_CtrlPointReference controlPointRef;
	PLT_MediaController *mediaController;
	PLT_MediaBrowser *mediaBrowser;
};



@implementation PPMediaController

@synthesize delegate;

- (id)initWithUPnP:(PPUPnP *)upnp {
	if ( self = [super init] ) {
		mediaController = new PP_MediaController(self, [upnp PLTUPnP]);
	}
	return self;
}

- (void)dealloc {

	delete mediaController;
	
	[super dealloc];
}



// Device lists

- (NSArray *)mediaRenderers {
	PLT_DeviceDataReferenceList pltMediaRendererList = PLT_DeviceDataReferenceList(mediaController->mediaController->GetMediaRenderers());
	
	NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
	PLT_DeviceDataReferenceList::Iterator listIter = pltMediaRendererList.GetFirstItem();
	while ( listIter ) {
		PLT_DeviceDataReference item = *listIter;
		PP_MediaDevice *device = new PP_MediaDevice(item);
		PPMediaDevice *mediaDevice = [[PPMediaDevice alloc] initWithController:self andDevice:device];
		mediaDevice.isSpeaker = YES;
		[list addObject:mediaDevice];
		
		listIter++;
	}
	
	return list;
}


- (NSArray *)mediaServers {
	PLT_DeviceDataReferenceList pltMediaRendererList = PLT_DeviceDataReferenceList(mediaController->mediaBrowser->GetMediaServers());
	
	NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
	PLT_DeviceDataReferenceList::Iterator listIter = pltMediaRendererList.GetFirstItem();
	while ( listIter ) {
		PLT_DeviceDataReference item = *listIter;
		PP_MediaDevice *device = new PP_MediaDevice(item);
		PPMediaDevice *mediaDevice = [[PPMediaDevice alloc] initWithController:self andDevice:device];
		mediaDevice.isSpeaker = NO;
		[list addObject:mediaDevice];
		
		listIter++;
	}
	
	return list;
}



// Server browsing

- (BOOL)browseContentsOfFolder:(NSString *)folderId onServer:(PPMediaDevice *)server fromIndex:(NSUInteger)start forNumber:(NSUInteger)count userData:(id)userData {
	if ( count == 0 ) {
		count = 30;
	}
	
	NPT_Result result = mediaController->mediaBrowser->Browse([server deviceData]->mediaDevice,
															  [folderId UTF8String], 
															  start,
															  count,
															  false,
															  "dc:date,upnp:genre,res,res@duration,res@size,upnp:albumArtURI,upnp:originalTrackNumber,upnp:album,upnp:artist,upnp:author",
															  "",
															  userData);
	
	return ( result == NPT_SUCCESS );

}


- (BOOL)browseMetadataOfItem:(NSString *)itemId onServer:(PPMediaDevice *)server userData:(id)userData {
	
	NPT_Result result = mediaController->mediaBrowser->Browse([server deviceData]->mediaDevice,
															  [itemId UTF8String], 
															  0,
															  0,
															  true,
															  "dc:date,upnp:genre,res,res@duration,res@size,upnp:albumArtURI,upnp:originalTrackNumber,upnp:album,upnp:artist,upnp:author",
															  "",
															  userData);
	
	return ( result == NPT_SUCCESS );
	
}



// Renderer controlling

- (BOOL)updateMediaInfoForSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->GetMediaInfo(
									[speaker deviceData]->mediaDevice,
									0,
									speaker);
	
	return ( result == NPT_SUCCESS );
}

- (BOOL)updatePositionInfoForSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->GetPositionInfo(
									[speaker deviceData]->mediaDevice,
									0,
									speaker);
	
	return ( result == NPT_SUCCESS );
}

- (BOOL)updateTransportInfoForSpeaker:(PPMediaDevice *)speaker {
NPT_Result result = mediaController->mediaController->GetTransportInfo(
									[speaker deviceData]->mediaDevice,
									0,
									speaker);

	return ( result == NPT_SUCCESS );
}


- (BOOL)pauseSpeaker:(PPMediaDevice *)speaker {
NPT_Result result = mediaController->mediaController->Pause(
									[speaker deviceData]->mediaDevice,
									0,
									speaker);

	return ( result == NPT_SUCCESS );
}

- (BOOL)playSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->Play(
									[speaker deviceData]->mediaDevice,
									0,
									NPT_String("1"),
									speaker);

	return ( result == NPT_SUCCESS );
}

- (BOOL)stopSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->Stop(
									[speaker deviceData]->mediaDevice,
									0,
									speaker);

	return ( result == NPT_SUCCESS );
}

- (BOOL)setCurrentSong:(PPMediaItem *)song onSpeaker:(PPMediaDevice *)speaker {
	NPT_Cardinal resource_index = 0;
	PLT_MediaObject *track = [song getMediaObject]->mediaObject;
	NPT_Result result = mediaController->mediaController->FindBestResource([speaker deviceData]->mediaDevice, *track, resource_index);
	
	result = mediaController->mediaController->SetAVTransportURI(
							[speaker deviceData]->mediaDevice,
							0,
							(const char*)track->m_Resources[resource_index].m_Uri,
							track->m_Didl,
							speaker);

	return ( result == NPT_SUCCESS );
}

- (BOOL)setMuted:(BOOL)mute onSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->SetMute(
								[speaker deviceData]->mediaDevice,
								0,
								"Master",
								mute,
								speaker);
	
	return ( result == NPT_SUCCESS );
}

- (BOOL)updateMutedForSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->GetMute(
							  [speaker deviceData]->mediaDevice,
							  0,
							  "Master",
							  speaker);
	
	return ( result == NPT_SUCCESS );	
}


- (BOOL)setVolume:(NSUInteger)volume onSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->SetVolume(
							  [speaker deviceData]->mediaDevice,
							  0,
							  "Master",
							  volume,
							  speaker);
	
	return ( result == NPT_SUCCESS );
}

- (BOOL)updateVolumeForSpeaker:(PPMediaDevice *)speaker {
	NPT_Result result = mediaController->mediaController->GetVolume(
							  [speaker deviceData]->mediaDevice,
							  0,
							  "Master",
							  speaker);
	
	return ( result == NPT_SUCCESS );	
}

@end
