//
//  PhotosViewController.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/02.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "PhotosViewController.h"
#import "GroupObject.h"
#import <ImageIO/ImageIO.h>
#import "SectionData.h"
#import "PhotoViewBaseCell.h"
#import "ThumbnaileCollectionView.h"
#import "ThumbnaileCell.h"
#import "BaseHeaderVIew.h"
#import "PhotoViewBaseCell.h"


@interface PhotosViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *photoBaseCollection;
@property (nonatomic, retain) NSMutableArray* dateEntry;
//@property (nonatomic, retain) NSMutableArray* photoInfoArray;
//@property (nonatomic, retain) NSMutableArray* displayItems;
@end

@implementation PhotosViewController

#define kBaseCellWidth      (320)
#define kBaseCellHeight     (170)

- (GroupObject*)prepareDataWithIndex:(NSInteger)index
{
    return self.dateEntry[index];
}


- (NSDictionary *)getPhotoExifMetaData:(NSDictionary*)dict {
    //NSDictionary *metaData = [[asset defaultRepresentation] metadata];
    return [dict objectForKey:(NSString *)kCGImagePropertyExifDictionary];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.photoInfoArray = nil;
        self.dateEntry = nil;
        PhotoViewBaseCell* cell = [[PhotoViewBaseCell alloc] init];
        cell.delegate = self;
    }
    return self;
}

- (void)initializeData:(NSNotification *)notification
{
    
}

- (void)buildSectionsForDate
{
    for( ALAsset* asset in self.targetGroupObj.assets )
    {
        @autoreleasepool {
            NSDictionary* dict = [[asset defaultRepresentation] metadata];
            NSDictionary* exifData = [self getPhotoExifMetaData:dict];
            NSString* date = exifData[@"DateTimeOriginal"];
            [self rebuildForDate:date asset:asset];
            dict = nil;
            exifData = nil;
            date = nil;
        }
    }
    NSInteger count = self.dateEntry.count;
    NSLog(@"entry count: %ld",(long)count);
    for( SectionData* section in self.dateEntry )
    {
        NSInteger num = section.items.count;
        NSLog(@"name;%@ count:%ld",section.sectionTitle, (long)num);
    }
}

- (void)rebuildForDate:(NSString*)date asset:(ALAsset*)asset
{
    if( self.dateEntry == nil )
    {
        self.dateEntry = [[NSMutableArray alloc] init];
        SectionData* emptySection = [[SectionData alloc] initWithTitle:@"Unknown"];
        [self.dateEntry addObject:emptySection];
    }
    NSArray* strs = [date componentsSeparatedByString:@" "];
    NSString* title = strs[0];
    NSURL* url = [asset valueForProperty:ALAssetPropertyAssetURL];
       
    if( title == nil )
    {
        title = @"Unknown";
    }
    BOOL isNewItem = YES;
    for( SectionData* section in self.dateEntry )
    {
        if( [section.sectionTitle isEqual:title] )
        {
            [section.items addObject:url];
            isNewItem = NO;
            break;
        }
    }
    if( isNewItem == YES )
    {
        SectionData* newSection = [[SectionData alloc] initWithTitle:title];
        [newSection.items addObject:url];
        [self.dateEntry addObject:newSection];
    }
        //NSLog(@"title: %@ sub:%@",strs[0],strs[1]);
    strs = nil;
    title = nil;
    url = nil;
}

- (ALAsset*)GetAssetFromArray:(NSURL*)url
{
    ALAsset* result = nil;
    for( ALAsset* asset in self.targetGroupObj.assets )
    {
        if( [[asset valueForProperty:ALAssetPropertyAssetURL] isEqual:url] )
        {
            result = asset;
            break;
        }
    }
    return result;
}

- (id)initWitheGroupName:(NSString*)name
{
    self = [super init];
    if( self )
    {
        self.groupName = name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = self.groupName;
    [self buildSectionsForDate];
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:self.dateEntry forKey:@"data"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BaseCollectionInit" object:self userInfo:userInfo];
    [PhotoViewBaseCell setSectionData:self.dateEntry];
}

- (void)viewWillDisappear:(BOOL)animated
{
    for( SectionData* section in self.dateEntry )
    {
        [section.items removeAllObjects];
        section.items = nil;
    }
    [self.dateEntry removeAllObjects];
    self.dateEntry = nil;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if( [collectionView isKindOfClass:[ThumbnaileCollectionView class]] )
    {
        return 1;
    }else{
        return self.dateEntry.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    /*
    SectionData* sectionData = self.dateEntry[section];
    NSInteger num = sectionData.items.count;
    return num;
    */
    if( [collectionView isKindOfClass:[ThumbnaileCollectionView class]] )
    {
        ThumbnaileCollectionView* thumbnaulCollection = (ThumbnaileCollectionView*)collectionView;
        NSInteger index = thumbnaulCollection.identifier;
        SectionData* sectionData = self.dateEntry[index-1];
        NSInteger num = sectionData.items.count;
        return num;
    }else{
        return 1;//self.dateEntry.count;
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if( [collectionView isKindOfClass:[ThumbnaileCollectionView class]] )
    {
        ThumbnaileCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoThumbnialCell" forIndexPath:indexPath];
        ThumbnaileCollectionView* thumbnaulCollection = (ThumbnaileCollectionView*)collectionView;
        NSInteger index = thumbnaulCollection.identifier;
        SectionData* sectionData = self.dateEntry[index-1];
        NSURL* targetUrl = sectionData.items[indexPath.row];
        ALAsset* asset = [self GetAssetFromArray:targetUrl];
        
        UIImage* image = [UIImage imageWithCGImage:[asset thumbnail]];
        cell.thumbnailImageView.image = image;
        return cell;
    }else{
        PhotoViewBaseCell* baseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoBaseCell" forIndexPath:indexPath];
        return baseCell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize retval;
    if( [collectionView isKindOfClass:[ThumbnaileCollectionView class]] )
    {
        ThumbnaileCollectionView* thumbnaulCollection = (ThumbnaileCollectionView*)collectionView;
        NSInteger index = thumbnaulCollection.identifier;
        SectionData* sectionData = self.dateEntry[index-1];
        NSURL* targetUrl = sectionData.items[indexPath.row];
        ALAsset* asset = [self GetAssetFromArray:targetUrl];

        UIImage* image = [UIImage imageWithCGImage:[asset thumbnail]];

        retval = image.size.width > 0 ? CGSizeMake(image.size.width, image.size.height): CGSizeMake(100, 100);
    }else{
        /*
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
                retval = CGSizeMake(kBaseCellWidth, kBaseCellHeight);
                break;
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                retval = CGSizeMake(kBaseCellHeight, kBaseCellWidth);
            default:
                break;
        }
        */
        retval = CGSizeMake(kBaseCellWidth, kBaseCellHeight);
    }
    //retval.height += 15; retval.width += 15;
    return retval;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if( [collectionView isKindOfClass:[ThumbnaileCollectionView class]] )
    {
        return nil;
    }else{
        BaseHeaderVIew *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseHeader" forIndexPath:indexPath];
        
        SectionData* sectionData = self.dateEntry[indexPath.section];
        NSString* title = sectionData.sectionTitle;
        headerView.headerTitle.text = title;
        return headerView;
    }
}


@end
