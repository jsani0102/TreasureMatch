//
//  TMSignupViewController.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMSignupViewController.h"
#import <Parse/Parse.h>

@implementation TMSignupViewController

- (IBAction)signup:(id)sender
{
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmationPassword = [self.confirmPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0 || [confirmationPassword length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Please enter a username, password, and email address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if ([password length] < 5)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Password length must be at least 5!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if ([password isEqualToString:confirmationPassword])
    {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Passwords do not match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }

}

@end
