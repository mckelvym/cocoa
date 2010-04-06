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

    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

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

- (void)setEmployees:(NSMutableArray *)a
{
	if (a == employees)
		return;
	
	for (Person * p in employees)
		[self stopObservingPerson:p];
	
	[a retain];
	[employees release];
	employees = a;
	
	for (Person * p in employees)
		[self startObservingPerson:p];
}

- (void)insertObject:(Person *)p
	inEmployeesAtIndex:(int)index
{
	NSLog(@"adding %@ to %@", p, employees);
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
