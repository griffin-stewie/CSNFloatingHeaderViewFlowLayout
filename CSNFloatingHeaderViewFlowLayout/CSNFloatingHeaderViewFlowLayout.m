//
//  CSNFloatingHeaderViewFlowLayout.m
//
//  Created by griffin_stewie on 2013/10/14. Based on https://gist.github.com/toblerpwn/5393460
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "CSNFloatingHeaderViewFlowLayout.h"

@implementation CSNFloatingHeaderViewFlowLayout

- (void)commonInit;
{
    _headerViewZIndex = 1024;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)layout
{
    self = [self init];
    if (self) {
        self.minimumLineSpacing = layout.minimumLineSpacing;
        self.minimumInteritemSpacing = layout.minimumInteritemSpacing;
        self.itemSize = layout.itemSize;
        self.scrollDirection = layout.scrollDirection;
        self.headerReferenceSize = layout.headerReferenceSize;
        self.footerReferenceSize = layout.footerReferenceSize;
        self.sectionInset = layout.sectionInset;
    }
    
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    UICollectionView * const collectionView = self.collectionView;
    CGPoint const contentOffset = collectionView.contentOffset;
    
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            [missingSections addIndex:layoutAttributes.indexPath.section];
        }
    }
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [missingSections removeIndex:layoutAttributes.indexPath.section];
        }
    }
    
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        [answer addObject:layoutAttributes];
        
    }];
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            NSInteger section = layoutAttributes.indexPath.section;
            NSInteger numberOfItemsInSection = [collectionView numberOfItemsInSection:section];
            
            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
            
            BOOL cellsExist;
            UICollectionViewLayoutAttributes *firstObjectAttrs;
            UICollectionViewLayoutAttributes *lastObjectAttrs;
            
            if (numberOfItemsInSection > 0) { // use cell data if items exist
                cellsExist = YES;
                firstObjectAttrs = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
                lastObjectAttrs = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];
            } else { // else use the header and footer
                cellsExist = NO;
                firstObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                        atIndexPath:firstObjectIndexPath];
                lastObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                       atIndexPath:lastObjectIndexPath];
                
            }
            
            CGFloat topHeaderHeight = (cellsExist) ? CGRectGetHeight(layoutAttributes.frame) : 0;
            CGFloat bottomHeaderHeight = CGRectGetHeight(layoutAttributes.frame);
            CGRect frameWithEdgeInsets = UIEdgeInsetsInsetRect(layoutAttributes.frame,
                                                               collectionView.contentInset);
            
            CGPoint origin = frameWithEdgeInsets.origin;
            UIEdgeInsets sectionInset = self.sectionInset;
            
            origin.y = MIN(
                           MAX(
                               contentOffset.y + collectionView.contentInset.top,
                               (CGRectGetMinY(firstObjectAttrs.frame) - topHeaderHeight - sectionInset.top)
                               ),
                           (CGRectGetMaxY(lastObjectAttrs.frame) - bottomHeaderHeight + sectionInset.bottom)
                           );

            
            layoutAttributes.zIndex = self.headerViewZIndex;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = layoutAttributes.frame.size
            };
            
        }
        
    }
    
    return answer;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}
@end
