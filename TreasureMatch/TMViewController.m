//
//  TMViewController.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMViewController.h"
#import <Parse/Parse.h>

@interface TMViewController ()

@end

@implementation TMViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self setUpUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender
{
    [PFUser logOut];
    
    [self setUpUI];
}

- (void)setUpUI
{
    if ([PFUser currentUser])
    {
        [self.accountButton setTitle:@"Account" forState:UIControlStateNormal];
        self.logoutButton.style = UIBarButtonItemStyleBordered;
        self.logoutButton.enabled = YES;
        self.logoutButton.title = @"Logout";
    }
    else
    {
        [self.accountButton setTitle:@"Login" forState:UIControlStateNormal];
        self.logoutButton.style = UIBarButtonItemStylePlain;
        self.logoutButton.enabled = NO;
        self.logoutButton.title = nil;
    }
}

@end
