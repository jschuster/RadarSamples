//
//  ViewController.h
//  ImagePickerAccessBug
//
//  Created by Joachim Schuster on 16.12.14.
//  Copyright (c) 2014 venqoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UISwitch* workaroundSwitch;
@property (nonatomic, strong) IBOutlet UILabel* photoLibraryAccessLabel;

@end

