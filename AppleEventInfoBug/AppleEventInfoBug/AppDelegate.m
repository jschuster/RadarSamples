//
//  AppDelegate.m
//  AppleEventInfoBug
//
//  Created by Joachim Schuster on 27.10.14.
//  Copyright (c) 2014 venqoo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  NSAppleEventManager* em = [NSAppleEventManager sharedAppleEventManager];
  [em setEventHandler:self
          andSelector:@selector(getUrl:withReplyEvent:)
        forEventClass:kInternetEventClass
           andEventID:kAEGetURL];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void) getUrl:(NSAppleEventDescriptor*)event
 withReplyEvent:(NSAppleEventDescriptor*)replyEvent {
  
  NSAppleEventDescriptor* processSerialDescriptor = [event attributeDescriptorForKeyword:keyAddressAttr];
  NSAppleEventDescriptor* pidDescriptor = [processSerialDescriptor coerceToDescriptorType:typeKernelProcessID];
  pid_t pid = *(pid_t *)[[pidDescriptor data] bytes];
  NSRunningApplication *runningApplication = [NSRunningApplication runningApplicationWithProcessIdentifier:pid];
  NSLog(@"initiating app: %@", runningApplication);
}

@end
