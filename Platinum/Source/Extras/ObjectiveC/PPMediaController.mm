//
//  PPMediaController.mm
//  Platinum
//
//  Created by Barry Burton on 12/15/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//


#import "Platinum.h"
#import "PltMediaBrowser.h"
#import "PltMediaController.h"

#import "PPMediaController.h"

#import "PP_MediaDevice.h"
#import "PPMediaDevice.h"

#import "PP_MediaObject.h"
#import "PPMediaObject.h"




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
		[master.delegate stateVariableDidChange:master];
	}
	
	virtual void OnBrowseResult(NPT_Result               res,
								PLT_DeviceDataReference& device,
								PLT_BrowseInfo*          info,
								void*                    userdata) {
		
		// First convert result to Obj-C Objects
		NSLog(@"browse container id: %s", (char *)info->object_id);
		
		// PLT_MediaObjectListReference pltListRef = PLT_MediaObjectListReference(info->items);
		
		PPMediaObject *user = (PPMediaObject *)userdata;
		PP_MediaObject *usercpp = [user getMediaObject];
		usercpp->childList = info->items;
			  
		NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
		PLT_MediaObjectList::Iterator listIter = info->items->GetFirstItem();
		while ( listIter ) {
			PLT_MediaObject *item = *listIter;
			NSLog(@"title: %s", (char*)item->m_Title);
			PPMediaObject *object = [PPMediaObject PPMediaObjectWithObject:item];
			[list addObject:object];
			
			listIter++;
			
			NSLog(@"new title: %@", [object name]);
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
	
	}
	
	virtual void OnGetMediaInfoResult(NPT_Result                res,
							  PLT_DeviceDataReference&  device,
							  PLT_MediaInfo*            info,
							  void*                     userdata) {
	
	}
	
	virtual void OnGetPositionInfoResult(NPT_Result                res,
								 PLT_DeviceDataReference&  device,
								 PLT_PositionInfo*         info,
								 void*                     userdata) {
	
	}
	
	virtual void OnGetTransportInfoResult(NPT_Result                res,
								  PLT_DeviceDataReference&  device,
								  PLT_TransportInfo*        info,
								  void*                     userdata) {
	
	}
	
	virtual void OnGetTransportSettingsResult(NPT_Result                res,
									  PLT_DeviceDataReference&  device,
									  PLT_TransportSettings*    settings,
									  void*                     userdata) {
	
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



- (NSArray *)mediaRenderers {
	PLT_DeviceDataReferenceList pltMediaRendererList = PLT_DeviceDataReferenceList(mediaController->mediaController->GetMediaRenderers());
	
	NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
	PLT_DeviceDataReferenceList::Iterator listIter = pltMediaRendererList.GetFirstItem();
	while ( listIter ) {
		PLT_DeviceDataReference item = *listIter;
		PP_MediaDevice *device = new PP_MediaDevice(item);
		PPMediaDevice *mediaDevice = [[PPMediaDevice alloc] initWithDevice:device];
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
		PPMediaDevice *mediaDevice = [[PPMediaDevice alloc] initWithDevice:device];
		[list addObject:mediaDevice];
		
		listIter++;
	}
	
	return list;
}


- (BOOL)browseContentsOfFolder:(NSString *)folderId onServer:(PPMediaDevice *)server fromIndex:(NSUInteger)start forNumber:(NSUInteger)count userData:(id)userData {
	if ( count == 0 ) {
		count = 30;
	}
	
	NPT_Result result = mediaController->mediaBrowser->Browse([server deviceData]->mediaDevice,
															  [folderId UTF8String], 
															  start,
															  count,
															  false,
															  NULL, NULL, userData);
	
	return ( result == NPT_SUCCESS );

}


- (BOOL)browseMetadataOfItem:(NSString *)itemId onServer:(PPMediaDevice *)server userData:(id)userData {
	
	NPT_Result result = mediaController->mediaBrowser->Browse([server deviceData]->mediaDevice,
															  [itemId UTF8String], 
															  0,
															  1,
															  true,
															  NULL, NULL, userData);
	
	return ( result == NPT_SUCCESS );
	
}


@end
