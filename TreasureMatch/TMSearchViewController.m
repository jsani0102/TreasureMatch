//
//  TMSearchViewController.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMSearchViewController.h"
#import <Parse/Parse.h>
#import "TMTinderViewController.h"

@implementation TMSearchViewController

- (IBAction)searchForItems:(id)sender
{
    if ([self.firstSearchTag.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"You must provide at least one tag" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        NSArray *searchTags = [self createSearchTagsArray];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Items"];
        
        for (NSString *tag in searchTags)
        {
            [query whereKey:@"tags" equalTo:tag];
        }
        
        [query orderByDescending:@"createdAt"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@ %@", error, error.userInfo);
            }
            else
            {
                // We found items!
                self.items = objects;
                NSLog(@"%@", self.items);
                [self performSegueWithIdentifier:@"showSearchResults" sender:self];
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSearchResults"])
    {
        TMTinderViewController *tinderViewController = (TMTinderViewController *)segue.destinationViewController;
        tinderViewController.items = self.items.mutableCopy;
        NSLog(@"%@", self.items);
    }
}

- (NSArray *)createSearchTagsArray
{
    NSMutableArray *searchTags = @[self.firstSearchTag.text, self.secondSearchTag.text, self.thirdSearchTag.text].mutableCopy;
    
    if ([self.secondSearchTag.text length] == 0)
    {
        [searchTags removeObject:self.secondSearchTag.text];
    }
    if ([self.thirdSearchTag.text length] == 0)
    {
        [searchTags removeObject:self.thirdSearchTag.text];
    }
    
    return searchTags;
}

@end
