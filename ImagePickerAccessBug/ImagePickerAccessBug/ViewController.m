//
//  ViewController.m
//  ImagePickerAccessBug
//
//  Created by Joachim Schuster on 16.12.14.
//  Copyright (c) 2014 venqoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView* resultImage;

@end

@implementation ViewController

- (IBAction)takePhoto:(id)sender {
  UIImagePickerController* picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
  picker.allowsEditing = YES;
  [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage* image = info[UIImagePickerControllerEditedImage];
  self.resultImage.image = image;
  [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
