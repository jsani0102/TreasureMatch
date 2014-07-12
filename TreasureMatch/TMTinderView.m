//
//  TMTinderView.m
//  TreasureMatch
//
//  Created by Jayant Sani on 7/12/14.
//  Copyright (c) 2014 Jayant Sani. All rights reserved.
//

#import "TMTinderView.h"
#import "TMDraggableView.h"

@interface TMTinderView()

@property (nonatomic, strong) TMDraggableView *draggableView;

@end

@implementation TMTinderView

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    [self loadDraggableCustomView];
    
    return self;
}

- (void)loadDraggableCustomView
{
    self.draggableView = [[TMDraggableView alloc] init];
    [self addSubview:self.draggableView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.draggableView.frame = CGRectMake(60, 100, 200, 260);
}


@end
