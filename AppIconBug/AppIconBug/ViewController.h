//
//  ViewController.h
//  AppIconBug
//
//  Created by Joachim Schuster on 23.05.16.
//  Copyright © 2016 venqoo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSButton *imageButton;

- (IBAction)buttonClicked:(id)sender;

@end

