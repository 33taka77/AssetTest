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


@interface PhotosViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *photoBaseCollection;
@property (nonatomic, retain) NSMutableArray* dateEntry;
//@property (nonatomic, retain) NSMutableArray* photoInfoArray;
//@property (nonatomic, retain) NSMutableArray* displayItems;
@end

@implementation PhotosViewController

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
    }
    return self;
}

- (void)buildSectionsForDate
{
    for( ALAsset* asset in self.targetGroupObj.assets )
    {
        NSDictionary* dict = [[asset defaultRepresentation] metadata];
        NSDictionary* exifData = [self getPhotoExifMetaData:dict];
        NSString* date = exifData[@"DateTimeOriginal"];
        [self rebuildForDate:date asset:asset];
        dict = nil;
        exifData = nil;
        date = nil;
    }
}

/*
- (void)buildPhotoDictionary
{
    if( self.photoInfoArray == nil )
    {
        self.photoInfoArray = [[NSMutableArray alloc] init];
    }
    for( ALAsset* asset in self.targetGroupObj.assets )
    {
        NSDictionary* dict = [[asset defaultRepresentation] metadata];
        NSMutableDictionary* targetDictionary = [dict mutableCopy];//[NSMutableDictionary dictionaryWithDictionary:dict];
        [targetDictionary setObject:asset forKey:@"Asset"];
        [self.photoInfoArray addObject:targetDictionary];
    }
}
*/

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
/*
- (void)rebuildForDate
{
    if( self.dateEntry ==nil )
    {
        self.dateEntry = [[NSMutableArray alloc] init];
        SectionData* emptySection = [[SectionData alloc] initWithTitle:@"Unknown"];
        [self.dateEntry addObject:emptySection];
    }
    
    for( NSDictionary* dict in self.photoInfoArray )
    {
        NSDictionary* exifData = [self getPhotoExifMetaData:dict];
        NSString* date = exifData[@"DateTimeOriginal"];
        //NSLog(@"date: %@",date);
        NSArray* strs = [date componentsSeparatedByString:@" "];
        NSString* title = strs[0];
        if( title == nil )
        {
            title = @"Unknown";
        }
        BOOL isNewItem = YES;
        for( SectionData* section in self.dateEntry )
        {
            if( [section.sectionTitle isEqual:title] )
            {
                [section.items addObject:dict];
                isNewItem = NO;
                break;
            }
        }
        if( isNewItem == YES )
        {
            SectionData* newSection = [[SectionData alloc] initWithTitle:title];
            [newSection.items addObject:dict];
            [self.dateEntry addObject:newSection];
        }
        //NSLog(@"title: %@ sub:%@",strs[0],strs[1]);
    }
}
*/

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

@end
