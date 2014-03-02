//
//  PhotosViewController.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/02.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
