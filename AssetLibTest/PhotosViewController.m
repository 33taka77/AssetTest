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


@interface PhotosViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *photoBaseCollection;
@property (nonatomic, retain) NSMutableArray* dateEntry;
@property (nonatomic, retain) NSMutableArray* photoInfoArray;
@end

@implementation PhotosViewController

- (NSDictionary *)getPhotoMetaData:(ALAsset*)asset {
    NSDictionary *metaData = [[asset defaultRepresentation] metadata];
    return [metaData objectForKey:(NSString *)kCGImagePropertyExifDictionary];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.photoInfoArray = nil;
        self.dateEntry = nil;
    }
    return self;
}

- (void)buildPhotoDictionsry
{
    if( self.photoInfoArray == nil )
    {
        self.photoInfoArray = [[NSMutableArray alloc] init];
    }
    for( ALAsset* asset in self.targetGroupObj.assets )
    {
        NSDictionary* dict = [self getPhotoMetaData:asset];
        NSMutableDictionary* targetDictionary = [dict mutableCopy];//[NSMutableDictionary dictionaryWithDictionary:dict];
        [targetDictionary setObject:asset forKey:@"Asset"];
        [self.photoInfoArray addObject:targetDictionary];
    }
}

- (void)rebuildForDate
{
    if( self.dateEntry ==nil )
    {
        self.dateEntry = [[NSMutableArray alloc] init];
    }
    for( NSDictionary* dict in self.photoInfoArray )
    {
        //NSDate* date = dict[kCGImagePropertyExifDateTimeOriginal];
        
    }
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
