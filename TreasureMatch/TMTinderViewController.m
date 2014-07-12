//
//  TMTinderViewController.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMTinderViewController.h"
#import "TMTinderView.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@implementation TMTinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.noButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yesButton setBackgroundColor:[UIColor greenColor]];
    [self.noButton setBackgroundColor:[UIColor redColor]];
    self.yesButton.layer.cornerRadius = 10.0;
    self.noButton.layer.cornerRadius = 10.0;
    
    [self.noButton addTarget:self action:@selector(noButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.yesButton addTarget:self action:@selector(yesButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadNewImage];
}
    
- (void)noButtonPressed
{
    [self loadNewImage];
}

- (void)yesButtonPressed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You have been matched!" message:[NSString stringWithFormat: @"Contact the owner of this item at: jayant@handybook.com"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)loadNewImage
{
    if ([self.items count] > 0)
    {
        PFObject *item = (PFObject *)self.items[0];
        [self.items removeObject:item];
        
        PFFile *imageFile = [item objectForKey:@"file"];
        NSURL *imageFileURL = [[NSURL alloc] initWithString:imageFile.url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageFileURL];
        self.imageView.image = [UIImage imageWithData:imageData];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[NSString stringWithFormat: @"No more items match your search"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}
    
@end
