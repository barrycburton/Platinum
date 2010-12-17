//
//  PP_MediaDevice.h
//  Platinum
//
//  Created by Barry Burton on 12/16/10.
//  Copyright 2010 Gravity Mobile. All rights reserved.
//


class PP_MediaDevice {
public:
	PP_MediaDevice(PLT_DeviceDataReference device) : mediaDevice(device) {

	}
	
	virtual ~PP_MediaDevice() {

	}


	PLT_DeviceDataReference mediaDevice;
};
