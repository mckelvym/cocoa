//
//  AppController.h
//  KVCFun
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	int fido;
}
// assign (the default) makes a simple assignment happen. assign does not 
	// retain the new value. If you are dealing with an object type and you 
	// are not using the garbage collector, you probably don't want assign.
// retain releases the old value and retains the new value. This attribute 
	// is used only for Objective-C object types. If you are using the 
	// garbage collector, assign and retain are equivalent.
// copy makes a copy of the new value and assigns the variable to the copy. 
	// This attribute is often used for properties that are strings.
@property(readwrite, assign) int fido;
- (IBAction)incrementFido:(id)sender;
- (IBAction)incrementFido2:(id)sender;
- (IBAction)incrementFido3:(id)sender;
@end
