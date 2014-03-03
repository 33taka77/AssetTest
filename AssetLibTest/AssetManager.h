//
//  AssetManager.h
//  AssetLibTest
//
//  Created by Aizawa Takashi on 2014/03/03.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@interface AssetManager : NSObject
{
    //static AssetManager* myself;
}
@property (nonatomic, retain) ALAssetsLibrary* assetLibrary;


@end
