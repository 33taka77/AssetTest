//
//  SectionData.m
//  AssetLibTest
//
//  Created by Aizawa Takashi on 2014/03/03.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "SectionData.h"

@implementation SectionData

- (id)init
{
    self = [super init];
    if( self )
    {
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title
{
    self = [super init];
    if( self )
    {
        self.items = [[NSMutableArray alloc] init];
        self.sectionTitle = title;
    }
    return self;
}
@end
