//
//  SectionData.h
//  AssetLibTest
//
//  Created by Aizawa Takashi on 2014/03/03.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionData : NSObject
@property (nonatomic, retain) NSString* sectionTitle;
@property (nonatomic, retain) NSMutableArray* items;

- (id)init;
- (id)initWithTitle:(NSString*)title;

@end
