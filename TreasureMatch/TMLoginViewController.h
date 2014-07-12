//
//  TMLoginViewController.h
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end
