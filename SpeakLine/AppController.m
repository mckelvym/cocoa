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
	
	[speechSynth startSpeakingString:@"What the frack?"];
	
	return self;
}

- (IBAction)sayIt:(id)sender;
{
	NSString * toSay = [textField stringValue];
	
	if ([toSay length] == 0)
		return;
	
	[speechSynth startSpeakingString:toSay];
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
