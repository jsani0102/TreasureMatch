//
//  TMAccountViewController.h
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *updateAddressField;
@property (weak, nonatomic) IBOutlet UITextField *updateEmailField;
@property (weak, nonatomic) IBOutlet UITextField *updatePhoneField;

- (IBAction)updateInfoPressed:(id)sender;

@end
