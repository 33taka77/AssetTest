//
//  ViewController.h
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/01.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) ALAssetsLibrary* assetLibrary;
@property (nonatomic, retain) NSMutableArray* group;
@end
