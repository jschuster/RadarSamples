//
//  ViewController.m
//  ImagePickerAccessBug
//
//  Created by Joachim Schuster on 16.12.14.
//  Copyright (c) 2014 venqoo. All rights reserved.
//

#import "ViewController.h"
@import Photos;


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView* resultImage;

@property (nonatomic) BOOL photoLibraryAccess;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  /**
   This Provides a workaround to the Bug.
   
   The Bug:
   crash on cropping an photo while on using the camera.
   Using UIImagePickerController allowsEditing provides some cropping feature after taking a photo.
   With iOS 8 the rights for ImagePicker was separated into Camera and Photo Library.
   If you take a photo with the camera, you will be asked to grand the app access to the camera.
   But with allowEditing = YES you will also be asked for access to the Photo Library - which should not be necessary, as the rights for camera and Photo Library are granded separately.
   If you deny the access to Photo Library and do some changes to the image in the editing view, the app will crash.
   If you deny the access to Photo Library and make no changes, the app will not crash!
   
   The Workaround:
   First check the Authorization state and disable the editing in the UIImagePickerController it the access is denied.
   Along with that you may show some alert to indicate that the app needs the access to the Photo Library for editing even if only the camera is used.
   */
  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    switch (status) {
      case PHAuthorizationStatusAuthorized: {
        dispatch_async(dispatch_get_main_queue(), ^{
          self.photoLibraryAccess = YES;
        });
        break;
      }
      case PHAuthorizationStatusRestricted:
        break;
      case PHAuthorizationStatusDenied: {
        dispatch_async(dispatch_get_main_queue(), ^{
          self.photoLibraryAccess = NO;
        });
        break;
      }
      default:
        break;
    }
  }];

}

- (void)setPhotoLibraryAccess:(BOOL)photoLibraryAccess {
  _photoLibraryAccess = photoLibraryAccess;
  self.photoLibraryAccessLabel.text = _photoLibraryAccess ? @"YES": @"NO";
}

- (IBAction)takePhoto:(id)sender {
  UIImagePickerController* picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
  if (_workaroundSwitch.on && !_photoLibraryAccess) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"This App needs access to the Photo Library to allow editing (cropping) after taking the photo." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    picker.allowsEditing = NO;
  }
  else {
    picker.allowsEditing = YES;
  }
  [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage* image;
  if (picker.allowsEditing) {
    image = info[UIImagePickerControllerEditedImage];
  }
  else {
    image = info[UIImagePickerControllerOriginalImage];
  }
  self.resultImage.image = image;
  [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
