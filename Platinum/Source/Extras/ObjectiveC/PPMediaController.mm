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

#import "PP_MediaDevice.h"
#import "PPMediaController.h"

#import "PPMediaDevice.h"


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

		return true;
	}
	
	virtual void OnMSRemoved(PLT_DeviceDataReference& device) {

	}
	
	virtual void OnMSStateVariablesChanged(PLT_Service*                  service,
								   NPT_List<PLT_StateVariable*>* vars) {
		[master.delegate stateVariableDidChange:master];
	}
	
	virtual void OnBrowseResult(NPT_Result               res,
						PLT_DeviceDataReference& device,
						PLT_BrowseInfo*          info,
						void*                    userdata) {    
		[master.delegate browseDidRespond:master];
	}
	
	virtual void OnSearchResult(NPT_Result               res,
						PLT_DeviceDataReference& device,
						PLT_BrowseInfo*          info,
						void*                    userdata) {

	}

	
	
	
	
	// PLT_MediaControllerDelegate methods
	virtual bool OnMRAdded(PLT_DeviceDataReference&  device ) {
		return true;
	}
	
	virtual void OnMRRemoved(PLT_DeviceDataReference&  device ) {
	
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
	NPT_Lock<PLT_DeviceDataReferenceList> pltMediaRendererList = mediaController->mediaController->GetMediaRenderers();
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
	NPT_Lock<PLT_DeviceDataReferenceList> pltMediaRendererList = mediaController->mediaBrowser->GetMediaServers();
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











@end
