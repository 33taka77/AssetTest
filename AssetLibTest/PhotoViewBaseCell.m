//
//  PhotoViewBaseCell.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/02.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "PhotoViewBaseCell.h"
#import "Params.h"
#import "AppDelegate.h"

@implementation PhotoViewBaseCell

static NSInteger counter = 0;
static NSMutableArray* sectionData = nil;

+(void)setSectionData:(NSMutableArray*)data
{
    sectionData = data;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self != nil)
    {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        //self.thumbnailCollectionView.delegate = self;
        //self.thumbnailCollectionView.dataSource = self;
        identifier = counter;
        counter++;
        Params* pram = [[Params alloc] init];
        pram.param1 = identifier;
        self.sectionData = [self.delegate prepareDataWithIndex:identifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializeData:) name:@"BaseCollectionInit" object:pram];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"BaseCollectionInit" object:self userInfo:nil];
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        NSLog(@" param = %@",appDelegate.gParam);
        
    }
    return self;
}

- (void)initializeData:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    SectionData *dataEntry = userInfo[@"data"];
    sectionData = dataEntry;
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
