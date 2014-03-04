//
//  PhotoViewBaseCell.h
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/02.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionData.h"

@protocol PhotoViewBaseCellDelegate

- (SectionData*)prepareDataWithIndex:(NSInteger)index;

@end

@interface PhotoViewBaseCell : UICollectionViewCell <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSInteger identifier;
}
+(void)setSectionData:(NSMutableArray*)data;
@property (weak, nonatomic) IBOutlet UICollectionView *thumbnailCollectionView;
@property id < PhotoViewBaseCellDelegate > delegate;
@property (nonatomic, retain) SectionData* sectionData;
- (void)initializeData:(NSNotification *)notification;

@end
