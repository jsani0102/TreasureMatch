//
//  TMPostItemViewController.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMPostItemViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>
#import "TMValidationHelper.h"

@implementation TMPostItemViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.image == nil)
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
}

#pragma mark - Image Picker Controller delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Please select a valid image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)cancel:(id)sender
{
    self.image = nil;
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)postItem:(id)sender
{
    
    if (self.image == nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Try again!" message:@"Please capture a photo or video to share!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
    else if ([TMValidationHelper validateTextFields:@[/*self.addressField, self.detailsField,*/self.firstTagField, self.secondTagField, self.thirdTagField]])
    {
        [self uploadItem];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Try again!" message:@"You must fill out all required fields!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Helper methods

- (void)uploadItem
{
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    if (self.image == nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"You can only upload images" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        UIImage *newImage = [self resizeImage:self.image toWidth:200.0f andHeight:260.0f];
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"image";
    
        PFFile *file = [PFFile fileWithName:fileName data:fileData];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!" message:@"Please try sending your message again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else
            {
                PFObject *item = [PFObject objectWithClassName:@"Items"];
                [item setObject:file forKey:@"file"];
                [item setObject:fileType forKey:@"fileType"];
                [item setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
                [item setObject:[[PFUser currentUser] username] forKey:@"senderName"];
                
                NSArray *tags = @[self.firstTagField.text, self.secondTagField.text, self.thirdTagField.text];
                [item setObject:tags forKey:@"tags"];
                [item setObject:self.addressField.text forKey:@"address"];
                [item setObject:self.detailsField.text forKey:@"details"];
                [item setObject:self.lengthField.text forKey:@"length"];
                [item setObject:self.widthField.text forKey:@"width"];
                [item setObject:self.heightField.text forKey:@"height"];
                
                [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error)
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!" message:@"Please try uploading your image again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alertView show];
                    }
                    else
                    {
                        // Everything was successful!
                        self.image = nil;
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your item was uploaded successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alertView show];
                    }
                }];
            }
        }];
    }
}

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:newRectangle];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

@end
