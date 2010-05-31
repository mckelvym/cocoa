//
//  MyDocument.m
//  Departments
//
//  Created by mark mckelvy on 5/30/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//

#import "MyDocument.h"
#import "DepartmentViewController.h"
#import "EmployeeController.h"

@implementation MyDocument

- (id)init 
{
    self = [super init];
    if (self != nil) {
        viewControllers = [[NSMutableArray alloc] init];
		
		ManagingViewController * vc;
		
		vc = [[DepartmentViewController alloc] init];
		[vc setManagedObjectContext:[self managedObjectContext]];
		[viewControllers addObject:vc];
		[vc release];
		
		vc = [[EmployeeController alloc] init];
		[vc setManagedObjectContext:[self managedObjectContext]];
		[viewControllers addObject:vc];
		[vc release];
    }
    return self;
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
	NSMenu * menu = [popUp menu];
	int i;
	int itemCount;
	itemCount = [viewControllers count];
	
	for (i = 0; i < itemCount; i++)
	{
		NSViewController * vc = [viewControllers objectAtIndex:i];
		NSMenuItem * menuItem = [[NSMenuItem alloc] 
								 initWithTitle:[vc title] 
								 action:@selector(changeViewController:) 
								 keyEquivalent:@""];
		[menuItem setTag:i];
		[menu addItem:menuItem];
		[menuItem release];
	}
	// Initially show the first controller
	[self displayViewController:[viewControllers objectAtIndex:0]];
	[popUp selectItemAtIndex:0];
}

- (IBAction)changeViewController:(id)sender
{
	int i = [sender tag];
	ManagingViewController * vc = [viewControllers objectAtIndex:i];
	[self displayViewController:vc];
}

- (void)displayViewController:(ManagingViewController *)vc
{
	// Try to end editing
	NSWindow * w = [box window];
	BOOL ended = [w makeFirstResponder:w];
	if (!ended)
	{
		NSBeep();
		return;
	}
	
	// Put the view in the box
	NSView * view = [vc view];
	[box setContentView:view];
}

- (void)dealloc
{
	[viewControllers release];
	[super dealloc];
}


@end
