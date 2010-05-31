//
//  ManagingViewController.m
//  Departments
//
//  Created by mark mckelvy on 5/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ManagingViewController.h"


@implementation ManagingViewController

@synthesize managedObjectContext;

- (void)deallac
{
	[managedObjectContext release];
	[super dealloc];
}

@end
