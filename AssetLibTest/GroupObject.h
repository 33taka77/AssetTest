//
//  GroupObject.h
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/01.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GroupObject : NSObject
@property (nonatomic, retain) ALAssetsGroup* groupAssets;
@property (nonatomic, retain) NSMutableArray* assets;
@end
