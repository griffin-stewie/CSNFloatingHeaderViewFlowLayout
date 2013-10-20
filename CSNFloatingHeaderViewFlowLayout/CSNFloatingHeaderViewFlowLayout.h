//
//  CSNFloatingHeaderViewFlowLayout.h
//
//  Created by griffin_stewie on 2013/10/14.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSNFloatingHeaderViewFlowLayout : UICollectionViewFlowLayout

/** zIndex for header
 default value is 1024
 */
@property (nonatomic, assign) NSInteger headerViewZIndex;

/** take over property values
 @return new instance
 */
- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)layout;

@end
