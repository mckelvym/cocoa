//
//  AppController.h
//  TodoApp
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject 
{
	IBOutlet NSButton * addButton;
	IBOutlet NSButton * removeButton;
	IBOutlet NSTextField * addField;
	IBOutlet NSTableView * tableView;
	NSMutableArray * todoList;
}

- (IBAction)removeItem:(id)sender;
- (IBAction)addItem:(id)sender;

@end
