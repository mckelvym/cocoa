//
//  AppController.m
//  TodoApp
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init
{
	if (![super init])
		return nil;
	
	todoList = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)awakeFromNib
{
	//int defaultRow = [voiceList indexOfObject:defaultVoice]; 
	//NSIndexSet * set = [[NSIndexSet alloc] initWithIndex:defaultRow];
	//[tableView selectRowIndexes:set byExtendingSelection:NO]; // TODO Deprecated
	//[tableView scrollRowToVisible:defaultRow];
}


- (id)tableView:(NSTableView *)aTableView
	objectValueForTableColumn:(NSTableColumn *)aTableColumn
	row:(NSInteger)rowIndex
{
	NSString *s = [todoList objectAtIndex:rowIndex];
	return s;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [todoList count];
}

- (IBAction)removeItem:(id)sender
{
	NSIndexSet * set = [tableView selectedRowIndexes];
	
	unsigned index = [set firstIndex];
    while (index != NSNotFound)
    {
        if (index < [todoList count])
            [todoList removeObjectAtIndex:index];
		
        index = [set indexGreaterThanIndex:index];
    }
	
	[tableView reloadData];
}

- (IBAction)addItem:(id)sender
{
	NSString * add = [addField stringValue];
	if ([add length] == 0)
		return;
	
	[todoList addObject:add];
	[tableView reloadData];
}

@end
