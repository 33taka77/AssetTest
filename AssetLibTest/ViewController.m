//
//  ViewController.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/01.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "ViewController.h"
#import "GroupObject.h"
#import "GroupCell.h"
#import "PhotosViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *groupCollectionView;
@property (nonatomic, retain) UIColor* groupCellDefaultColor;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.assetLibrary = [[ALAssetsLibrary alloc] init];
    self.group = [[NSMutableArray alloc] init];
    [self searchPhotoGroup];
    
}


- (void)searchPhotoGroup
{
    void (^groupBlock)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
        if( group != nil )
        {
            GroupObject *obj = [[GroupObject alloc] init];
            obj.groupAssets = group;
            [self.group addObject:obj];
            [self searchPhotos:obj];
            NSLog(@"Group:%@ images:%lu",[obj.groupAssets valueForProperty:ALAssetsGroupPropertyName], (unsigned long)obj.assets.count );
            [self.groupCollectionView reloadData];
        }
    };
    [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:groupBlock failureBlock:^(NSError *error) {
        NSLog(@"AssetLib error %@",error);
    }];
}

- (void)searchPhotos:(GroupObject*)group
{
    group.assets = [[NSMutableArray alloc] init];
    void (^photosBlock)(ALAsset*, NSUInteger, BOOL*) = ^(ALAsset* asset, NSUInteger index, BOOL* stop){
        if( asset != nil )
        {
            if( ![group.assets containsObject:asset] )
            {
                if( [[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto] )
                {
                    [group.assets addObject:asset];
                    /*dispatch_async(
                                   dispatch_get_main_queue(),
                                   ^{
                                       [self.groupCollectionView reloadData];
                                   }
                                   );
                     */
                }
            }
        }
    };
    [group.groupAssets enumerateAssetsUsingBlock:photosBlock];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.group.count;
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = self.group.count;
    return num;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCell" forIndexPath:indexPath];
    
    GroupObject* groupObj = self.group[indexPath.row];
    NSString* groupName = [groupObj.groupAssets valueForProperty:ALAssetsGroupPropertyName];
    cell.title.text = groupName;
    
    NSString* numofPhotos =[ NSString stringWithFormat:@"(%ld)", (long)groupObj.groupAssets.numberOfAssets];
    cell.count.text = numofPhotos;
    
    if( groupObj.assets.count > 0 ){
        ALAsset* asset = groupObj.assets[0];
        UIImage* image = [UIImage imageWithCGImage:[asset thumbnail]];
        cell.imageView3.image = image;
        //cell.baseImageView3.frame = CGRectMake(cell.imageView3.frame.origin.x-2, cell.imageView3.frame.origin.y-2, cell.imageView3.frame.size.width+2, cell.imageView3.frame.size.height+2);
        //cell.baseImageView3.backgroundColor = [UIColor whiteColor];
        if( [groupObj.groupAssets numberOfAssets] > 1 )
        {
            asset = groupObj.assets[1];
            image = [UIImage imageWithCGImage:[asset thumbnail]];
            cell.imageView2.image = image;
            CGFloat angle = 10.0 * M_PI / 180.0;
            cell.imageView2.transform = CGAffineTransformMakeRotation(angle);
        
            if( [groupObj.groupAssets numberOfAssets] > 2 )
            {
                asset = groupObj.assets[2];
                image = [UIImage imageWithCGImage:[asset thumbnail]];
                cell.imageView1.image = image;
                CGFloat angle = 20.0 * M_PI / 180.0;
                cell.imageView1.transform = CGAffineTransformMakeRotation(angle);
            }
        }
    }
    return cell;
}

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupObject* groupObj = self.group[indexPath.row]
    CGSize retval = photo.thumbnail.size.width > 0 ? CGSizeMake(photo.thumbnail.size.width/2, photo.thumbnail.size.height/2): CGSizeMake(100, 100);
    retval.height += 15; retval.width += 15;
    return retval;
}
*/

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 5, 50, 5);
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupObject* groupObj = self.group[indexPath.row];
    PhotosViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotosViewController"];
    
    viewController.title = [groupObj.groupAssets valueForProperty:ALAssetsGroupPropertyName ];
    viewController.assetLibrary = self.assetLibrary;
    //viewController.group = self.group;
    viewController.groupName = [groupObj.groupAssets valueForProperty:ALAssetsGroupPropertyName ];
    viewController.targetGroupObj = groupObj;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //self.groupCollectionView.backgroundColor = self.groupCellDefaultColor;
    //UICollectionViewCell* cell = [self.groupCollectionView cellForItemAtIndexPath:indexPath];
    //cell.backgroundColor = self.groupCellDefaultColor;
   
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [self.groupCollectionView cellForItemAtIndexPath:indexPath];
    self.groupCellDefaultColor = cell.backgroundColor;
    cell.backgroundColor = [UIColor brownColor];
 
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [self.groupCollectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
}


@end
