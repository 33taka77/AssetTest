//
//  PhotosViewController.h
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/02.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotosViewController : UIViewController
@property (nonatomic, retain) ALAssetsLibrary* assetLibrary;
@property (nonatomic, retain) NSMutableArray* group;
@property (nonatomic, retain) NSString* groupName;

- (id)initWitheGroupName:(NSString*)name;

@end
