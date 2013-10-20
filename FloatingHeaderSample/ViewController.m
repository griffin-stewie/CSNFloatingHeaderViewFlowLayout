//
//  ViewController.m
//  FloatingHeaderSample
//
//  Created by griffin_stewie on 2013/10/14.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "MyHeaderView.h"
#import "CSNFloatingHeaderViewFlowLayout.h"

static NSString * const kHeaderTitleKey = @"HeaderTitleKey";
static NSString * const kItemsKey = @"ItemsKey";

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *source;
@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationItem.title = @"Floating Header";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self.collectionView
                                                                                           action:@selector(reloadData)];
    
    [self.collectionView registerClass:[MyCell class]
            forCellWithReuseIdentifier:@"MyCell"];
    [self.collectionView registerClass:[MyHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"MyHeaderView"];

    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.35 alpha:1.0];
    ((CSNFloatingHeaderViewFlowLayout *)self.collectionView.collectionViewLayout).headerViewZIndex = NSIntegerMax;
    
    self.source = [NSMutableArray array];
    for (NSInteger i = 1; i < 20; i++) {
        [self.source addObject:@{
                                 kHeaderTitleKey : [NSString stringWithFormat:@"Header Title %ld", (long)i],
                                 kItemsKey : @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"]
                                 }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[self.source objectAtIndex:section] objectForKey:kItemsKey] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.source count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyHeaderView *headerView = (MyHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyHeaderView" forIndexPath:indexPath];
    headerView.titleLabel.text = [[self.source objectAtIndex:indexPath.section] objectForKey:kHeaderTitleKey];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    NSArray *rowsInSection = [[self.source objectAtIndex:indexPath.section] objectForKey:kItemsKey];
    cell.titleLabel.text = [rowsInSection objectAtIndex:indexPath.item];
    return cell;
}
@end
