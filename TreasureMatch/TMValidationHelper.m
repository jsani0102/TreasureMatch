//
//  TMValidationHelper.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMValidationHelper.h"

@implementation TMValidationHelper

+ (BOOL)validateTextFields:(NSArray *)textFieldArray
{
    for (UITextField *textField in textFieldArray)
    {
        if ([textField.text length] == 0)
        {
            return NO;
        }
    }
    return YES;
}

@end
