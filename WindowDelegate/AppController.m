//
//  AppController.m
//  WindowDelegate
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init
{
	[super init];
	
	NSLog(@"init");
	
	return self;
}

- (void)awakeFromNib
{
	//[window 
}

- (void)windowDidResize:(NSNotification *)notification
{
	NSLog(@"resized");
}

- (NSSize)windowWillResize:(NSWindow *)sender 
					toSize:(NSSize)frameSize;
{
	frameSize.width = 2*frameSize.height;
	return frameSize;
}

@end
