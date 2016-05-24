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
     /**
     * Copy or move Safari.app from your Applications folder to your Desktop.
     * If you run the example open the Console app and filter for appiconbug.
     * You will find a log of the kind:
     * 24.05.16 08:42:16,555 sandboxd[129]: ([36785]) AppIconBug(36785) deny file-read-data /Users/xyz/Desktop/Safari.app/Contents/PkgInfo
     * The icon will be fetched correctly anyway.
     */
    self.fullPath = [@"~/Desktop/Safari.app" stringByExpandingTildeInPath];
    NSImage* icon = [[NSWorkspace sharedWorkspace] iconForFile:self.fullPath];
    self.imageButton.image = icon;
}

- (IBAction)buttonClicked:(id)sender {
    /**
     * The same App used to open an URL will open the app in that location and shows the given url without any sandboxd warnung.
     */
    NSError* error;
    NSURL* appUrlFromPath = [NSURL fileURLWithPath:self.fullPath];
    [[NSWorkspace sharedWorkspace] openURLs:@[[NSURL URLWithString:@"http://www.apple.com"]] withApplicationAtURL:appUrlFromPath options:NSWorkspaceLaunchDefault configuration:@{} error:&error];
}

@end
