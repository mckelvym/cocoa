//
//  AppController.h
//  AmaZone
//
//  Created by mark mckelvy on 5/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject 
{
	IBOutlet NSProgressIndicator * progress;
	IBOutlet NSTextField * searchField;
	IBOutlet NSTableView * tableView;
	
	NSXMLDocument * doc;
	NSArray * itemNodes;
}

- (IBAction)fetchBooks:(id)sender;
- (NSString *)stringForPath:(NSString *)xpath ofNode:(NSXMLNode *)node;

@end
