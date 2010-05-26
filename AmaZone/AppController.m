//
//  AppController.m
//  AmaZone
//
//  Created by mark mckelvy on 5/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

#define AWS_ID @"1CKE6MZ62S27EFQ458402"

@implementation AppController

- (void)awakeFromNib
{
	[tableView setDoubleAction:@selector(openItem:)];
	[tableView setTarget:self];
}

- (void)openItem:(id)sender
{
	int row = [tableView clickedRow];
	if (row == -1)
	{
		return;
	}
	
	NSXMLNode * clickedItem = [itemNodes objectAtIndex:row];
	NSString * urlString = [self stringForPath:@"DetailPageURL" ofNode:clickedItem];
	
	NSURL * url = [NSURL URLWithString:urlString];
	[[NSWorkspace sharedWorkspace] openURL:url];
}
	
- (IBAction)fetchBooks:(id)sender
{
	// Show the user what is happening
	[progress startAnimation:nil];
	
	// Put together request
	
	// Get the string and percent-escape for insertion into URL
	NSString * input = [searchField stringValue];
	NSString * searchString = [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"search string: %@", searchString);
	
	// Create the URL 
	NSString * urlString = [NSString stringWithFormat:
							@"http://ecs.amazonaws.com/onca/xml?"
							@"Service=AWSECommerceService&"
							@"AWSAccessKeyID=%@&"
							@"SearchIndex=Books&"
							@"Keywords=%@&"
							@"Operation=ItemSearch&"
							@"Version=2007-07-16",
							AWS_ID, searchString];
	
	NSURL * url = [NSURL URLWithString:urlString];
	NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url
												 cachePolicy:NSURLRequestReturnCacheDataElseLoad
											 timeoutInterval:30];
	
	// Fetch the XML response
	
	NSData * urlData;
	NSURLResponse * response;
	NSError * error;
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
	if (!urlData)
	{
		NSAlert * alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	// Parse the XML response
	[doc release];
	doc = [[NSXMLDocument alloc] initWithData:urlData options:0 error:&error];
	
	NSLog(@"doc = %@", doc);
	if (!doc)
	{
		NSAlert * alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	[itemNodes release];
	itemNodes = [[doc nodesForXPath:@"ItemSearchResponse/Items/Item" error:&error] retain];
	
	if (!itemNodes)
	{
		NSAlert * alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	// Update the interface
	[tableView reloadData];
	[progress stopAnimation:nil];
}

- (NSString *)stringForPath:(NSString *)xpath ofNode:(NSXMLNode *)node
{
	NSError * error;
	NSArray * nodes = [node nodesForXPath:xpath error:&error];
	
	if (!nodes)
	{
		NSAlert * alert = [NSAlert alertWithError:error];
		[alert runModal];
		return nil;
	}
	
	if ([nodes count] == 0)
	{
		return nil;
	}
	else
	{
		return [[nodes objectAtIndex:0] stringValue];
	}
}

#pragma mark TableView data source methods

- (int)numberOfRowsInTableView:(NSTableView *)tableview
{
	return [itemNodes count];
}

- (id)tableView:(NSTableView *)tableview objectValueForTableColumn:(NSTableColumn *)col row:(int)row
{
	NSXMLNode * node = [itemNodes objectAtIndex:row];
	NSString * xPath = [col identifier];
	return [self stringForPath:xPath ofNode:node];
}

	
@end
