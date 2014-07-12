//
//  TMSearchViewController.h
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMSearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *firstSearchTag;
@property (weak, nonatomic) IBOutlet UITextField *secondSearchTag;
@property (weak, nonatomic) IBOutlet UITextField *thirdSearchTag;
@property (strong, nonatomic) NSArray *items;

- (IBAction)searchForItems:(id)sender;

@end
