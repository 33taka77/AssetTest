//
//  PhotoViewBaseCell.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/02.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "PhotoViewBaseCell.h"

@implementation PhotoViewBaseCell

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
    static NSInteger counter = 0;
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        self.thumbnailCollectionView.delegate = self;
        self.thumbnailCollectionView.dataSource = self;
        counter++;
        identifier = counter;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    /*
     SectionData* sectionData = self.dateEntry[section];
     NSInteger num = sectionData.items.count;
     return num;
     */
    return 5;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoViewBaseCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoThumbnialCell" forIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
}


@end
