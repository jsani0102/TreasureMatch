//
//  TMTinderViewController.h
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMTinderView;
@class PFObject;

@interface TMTinderViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) PFObject *item;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
