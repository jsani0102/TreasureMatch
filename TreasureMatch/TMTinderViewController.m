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

@implementation TMTinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.yesButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.noButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    NSLog(@"%@", self.items);
    
    PFObject *item = (PFObject *)self.items[0];
    
    PFFile *imageFile = [item objectForKey:@"file"];
    NSURL *imageFileURL = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileURL];
    self.imageView.image = [UIImage imageWithData:imageData];
}

@end
