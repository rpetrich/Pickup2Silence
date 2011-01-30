#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

CHDeclareClass(SBAccelerometerInterface);
CHDeclareClass(SBCallAlertDisplay);

static SBCallAlertDisplay *callAlert;

CHMethod(5, void, SBAccelerometerInterface, accelerometerDataReceived,double,received,x,float,x,y,float,y,z,float,z,type,unsigned,type)
{
	if (x>0.3 || z> 0.1 || y>.1)
		[callAlert stopRingingOrVibrating];
	CHSuper(5, SBAccelerometerInterface, accelerometerDataReceived,received,x,x,y,y,z,z,type,type);
}

CHMethod(0, void, SBCallAlertDisplay, alertDisplayWillBecomeVisible)
{
	callAlert = self;
	CHSuper(0, SBCallAlertDisplay, alertDisplayWillBecomeVisible);
}

CHMethod(0, void, SBCallAlertDisplay, dealloc)
{
	if (callAlert == self)
		callAlert = nil;
	CHSuper(0, SBCallAlertDisplay, dealloc);
}

CHConstructor
{	
	CHLoadLateClass(SBCallAlertDisplay);
	CHHook(0, SBCallAlertDisplay, alertDisplayWillBecomeVisible);
	CHHook(0, SBCallAlertDisplay, dealloc);
	CHLoadLateClass(SBAccelerometerInterface);
	CHHook(5, SBAccelerometerInterface, accelerometerDataReceived,x,y,z,type);
}

