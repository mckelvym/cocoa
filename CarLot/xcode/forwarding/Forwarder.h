//
//  Forwarder.h
//  forwarding
//
//  Created by mark mckelvy on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <objc/Object.h>

@interface Forwarder : Object {
	id recipient; //The object we want to forward the message to. 
}

//Accessor methods
- (id) recipient;
- (id) setRecipient:(id) _recipient; 

@end
