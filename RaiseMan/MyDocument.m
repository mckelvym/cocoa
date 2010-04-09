//
//  MyDocument.m
//  RaiseMan
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//

#import "Person.h"
#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
		employees = [[NSMutableArray alloc] init];
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

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

	[[tableView window] endEditingFor:nil];
	
	return [NSKeyedArchiver archivedDataWithRootObject:employees];
    
	//if ( outError != NULL ) {
	//	*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	//}
	//return nil;
}

/*
- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError *)error
{
	return nil;
}

- (BOOL)writeToURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
	return NO;
}
*/

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
	NSLog(@"About to read data of type %@", typeName);
	NSMutableArray * newArray = nil;
	
	@try
	{
		newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	@catch (NSException * e)
	{
		if (outError != NULL)
		{
			NSDictionary * d = [NSDictionary dictionaryWithObject:@"The data is corrupted."
														   forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
		}
		return NO;
	}
	
	[self setEmployees:newArray];
    return YES;
}

/*
- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError **)outError
{
	return NO;
}

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
	return NO;
}
*/

- (void)dealloc
{
	[self setEmployees:nil];
	[super dealloc];
}

- (void)changeKeyPath:(NSString *)keyPath
	ofObject:(id)obj 
	toValue:(id)newValue
{
	[obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
ofObject:(id)object
change:(NSDictionary *)change
context:(void *)context
{
	NSUndoManager *undo = [self undoManager];
	id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
	
	if (oldValue == [NSNull null])
	{
		oldValue = nil;
	}
	
	NSLog(@"oldValue = %@", oldValue);
	[[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath 
												  ofObject:object toValue:oldValue];
	
	[undo setActionName:@"Edit"];
}

- (IBAction)createEmployee:(id)sender
{
	NSLog(@"createEmployee of MyDocument");
	NSWindow * w = [tableView window];
	
	// Try to end any editing taking place.
	BOOL editingEnded = [w makeFirstResponder:w];
	if (!editingEnded)
	{
		return;
	}
	
	NSUndoManager * undo = [self undoManager];
	
	// Has an edit occurred already in this event?
	if ([undo groupingLevel])
	{
		// Close the last group
		[undo endUndoGrouping];
		// Open a new group
		[undo beginUndoGrouping];
	}
	
	// Create the person object
	Person * p = [employeeController newObject];
	
	// Add it to the content array of 'employeeController'
	[employeeController addObject:p];
	[p release];
	
	// Resort
	[employeeController rearrangeObjects];
	
	// Get the sorted array
	NSArray * a = [employeeController arrangedObjects];
	
	// Find the object just added
	int row = [a indexOfObjectIdenticalTo:p];
	NSLog(@"Starting to edit %@ in row %d", p, row);
	
	// Begin the edit in the first column
	[tableView editColumn:0	
					  row:row withEvent:nil select:YES];
}

- (void)setEmployees:(NSMutableArray *)a
{
	if (a == employees)
		return;
	
	for (Person * p in employees)
	{
		NSLog(@"No longer observing person %@", p);
		[self stopObservingPerson:p];
	}
	
	[a retain];
	[employees release];
	employees = a;
	
	for (Person * p in employees)
	{
		NSLog(@"Now observing person %@", p);
		[self startObservingPerson:p];
	}
}

- (void)insertObject:(Person *)p
	inEmployeesAtIndex:(int)index
{
	NSLog(@"adding %@ to employees %@", p, employees);
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
	
	if (![undo isUndoing])
	{
		[undo setActionName:@"Insert person"];
	}
	
	[self startObservingPerson:p];
	[employees insertObject:p atIndex:index];
}

- (void)removeObjectFromEmployeesAtIndex:(int)index
{
	Person *p = [employees objectAtIndex:index];
	NSLog(@"removing %@ from %@", p, employees);
	
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
	
	if (![undo isUndoing])
	{
		[undo setActionName:@"Remove person"];
	}
	
	[self stopObservingPerson:p];
	[employees removeObject:p];
}

- (void)startObservingPerson:(Person *)p
{
	[p addObserver:self	
		forKeyPath:@"personName" 
		   options:NSKeyValueObservingOptionOld 
		   context:NULL];
	
	[p addObserver:self	
		forKeyPath:@"expectedRaise" 
		   options:NSKeyValueObservingOptionOld 
		   context:NULL];
}

- (void)stopObservingPerson:(Person *)p
{
	[p removeObserver:self forKeyPath:@"personName"];
	[p removeObserver:self forKeyPath:@"expectedRaise"];
}

@end
