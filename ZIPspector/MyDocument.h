//
//  MyDocument.h
//  ZIPspector
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	IBOutlet NSTableView * tableView;
	NSArray * filenames;
}
@end
