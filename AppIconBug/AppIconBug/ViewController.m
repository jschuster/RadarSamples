//
//  ViewController.m
//  AppIconBug
//
//  Created by Joachim Schuster on 23.05.16.
//  Copyright © 2016 venqoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString* fullPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fullPath = [@"~/Desktop/Safari.app" stringByExpandingTildeInPath];
    NSImage* icon = [[NSWorkspace sharedWorkspace] iconForFile:self.fullPath];
    self.imageButton.image = icon;
}

- (IBAction)buttonClicked:(id)sender {
    NSError* error;
    NSURL* appUrlFromPath = [NSURL fileURLWithPath:self.fullPath];
    [[NSWorkspace sharedWorkspace] openURLs:@[[NSURL URLWithString:@"http://www.apple.com"]] withApplicationAtURL:appUrlFromPath options:NSWorkspaceLaunchDefault configuration:@{} error:&error];
}

@end
