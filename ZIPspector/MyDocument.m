//
//  MyDocument.m
//  ZIPspector
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
    
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

/*
- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}
*/

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"Read from URL");
	
	// Which file are we getting zipinfo for?
	NSString * filename = [url path];
	
	// Prepare task object
	NSTask * task = [[NSTask alloc] init];
	[task setLaunchPath:@"/usr/bin/zipinfo"];
	NSArray * args = [NSArray arrayWithObjects:@"-1", filename, nil];
	[task setArguments:args];
	
	// Create pipe
	NSPipe * outPipe = [[NSPipe alloc] init];
	[task setStandardOutput:outPipe];
	[outPipe release];
	
	// Start process
	[task launch];
	
	// Read the output 
	NSData * data = [[outPipe fileHandleForReading] readDataToEndOfFile];
	
	// Make sure the task terminates normally
	[task waitUntilExit];
	int status = [task terminationStatus];
	[task release];
	
	// Check status
	if (status != 0)
	{
		if (outError)
		{
			NSDictionary * eDict = [NSDictionary dictionaryWithObject:@"zipinfo failed"
															   forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:0 userInfo:eDict];
		}
		return NO;
	}
	
	// Convert to a string
	NSString * aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	// Release the old filenames
	[filename release];
	
	// Break the string into lines
	filenames = [[aString componentsSeparatedByString:@"\n"] retain];
	NSLog(@"filenames = %@", filenames);
	
	// Release the string
	[aString release];
	
	// In case of revert
	[tableView reloadData];
	
	return YES;
}

- (int)numberOfRowsInTableView:(NSTableView *)tv 
{
	return [filenames count];
}

- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tc row:(NSInteger)row
{
	return [filenames objectAtIndex:row];
}


@end
