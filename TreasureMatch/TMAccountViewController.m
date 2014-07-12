//
//  TMAccountViewController.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMAccountViewController.h"
#import "TMValidationHelper.h"
#import <Parse/Parse.h>

@implementation TMAccountViewController

- (IBAction)updateInfoPressed:(id)sender
{
    NSArray *textFields = @[self.updateAddressField, self.updateEmailField, self.updatePhoneField];
    
    if ([TMValidationHelper validateTextFields:textFields])
    {
        PFUser *currentUser = [PFUser currentUser];
        
        [currentUser setObject:self.updateAddressField.text forKey:@"address"];
        [currentUser setObject:self.updateEmailField.text forKey:@"email"];
        [currentUser setObject:self.updatePhoneField.text forKey:@"phone"];
        
        // dismiss keyboard
        [self dismissTextFields:textFields];
        
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your info was updated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else
            {
                NSLog(@"%@ %@", error, error.userInfo);
            }
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Please fill out all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Helpers

- (void)dismissTextFields:(NSArray *)textFieldArray
{
    for (UITextField *textField in textFieldArray)
    {
        [textField resignFirstResponder];
    }
}

@end
