//
//  ManagingViewController.h
//  Departments
//
//  Created by mark mckelvy on 5/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ManagingViewController : NSViewController {
	NSManagedObjectContext * managedObjectContext;
}
@property (retain) NSManagedObjectContext * managedObjectContext;


@end
