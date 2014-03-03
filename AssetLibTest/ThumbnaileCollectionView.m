//
//  ThumbnaileCollectionView.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/03.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "ThumbnaileCollectionView.h"

@implementation ThumbnaileCollectionView

static NSInteger counter = 0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    //static NSInteger counter = 0;
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        counter++;
        self.identifier = counter;
    }
    return self;
}

- (void)dealloc
{
    counter = 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
