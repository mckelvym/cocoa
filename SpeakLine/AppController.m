//
//  AppController.m
//  SpeakLine
//
//  Created by mark mckelvy on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init
{
	[super init];
	
	NSLog(@"init");
	
	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
	voiceList = [[NSSpeechSynthesizer availableVoices] retain];
	[stopButton setEnabled:NO];
	[speechSynth setDelegate:self];
	
	//[speechSynth startSpeakingString:@"What the frack?"];
	
	return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector 
{
	NSString *methodName = NSStringFromSelector(aSelector); 
	NSLog(@"respondsToSelector: %@", methodName); 
	return [super respondsToSelector:aSelector];
}

- (void)awakeFromNib
{
	// When the table view appears on screen, the default voice 
	// should be selected 
	NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice]; 
	int defaultRow = [voiceList indexOfObject:defaultVoice]; 
	[tableView selectRow:defaultRow byExtendingSelection:NO]; // TODO Deprecated
	[tableView scrollRowToVisible:defaultRow];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender 
	didFinishSpeaking:(BOOL)finishedSpeaking
{
	[tableView setEnabled:YES];
	[stopButton setEnabled:NO];
	[speakButton setEnabled:YES];
	NSLog(@"Done speaking.");
}

- (int)numberOfRowsInTableView:(NSTableView *)tv 
{
	return [voiceList count];
}

- (id)tableView:(NSTableView *)tv 
	objectValueForTableColumn:(NSTableColumn *)tableColumn
	row:(int)row
{ 
	NSString *v = [voiceList objectAtIndex:row]; 
	NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v]; 
	return [dict objectForKey:NSVoiceName];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	int row = [tableView selectedRow]; 
	if (row == -1) 
	{
		return;
	} 
	
	NSString *selectedVoice = [voiceList objectAtIndex:row]; 
	[speechSynth setVoice:selectedVoice]; 
	NSLog(@"new voice = %@", selectedVoice);
}

- (IBAction)sayIt:(id)sender;
{
	NSString * toSay = [textField stringValue];
	
	if ([toSay length] == 0)
		return;
	
	[tableView setEnabled:NO];
	[speechSynth startSpeakingString:toSay];
	[stopButton setEnabled:YES];
	[speakButton setEnabled:NO];
	NSLog(@"Saying %@", toSay);
}

- (IBAction)stopIt:(id)sender
{
	[speechSynth stopSpeaking];
}

- (void)curseIt:(id)sender
{
	[speechSynth startSpeakingString:@"What the frack?"];
	NSLog(@"Just cursed..");		
}

@end
