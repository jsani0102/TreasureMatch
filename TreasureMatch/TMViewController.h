//
//  TMViewController.h
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *postItemButton;
@property (weak, nonatomic) IBOutlet UIButton *searchForItemButton;

- (IBAction)logout:(id)sender;
- (IBAction)hitAccountButton:(id)sender;

@end
