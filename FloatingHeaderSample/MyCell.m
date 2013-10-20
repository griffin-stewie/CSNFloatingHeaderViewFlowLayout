//
//  MyCell.m
//  FloatingHeaderSample
//
//  Created by griffin_stewie on 2013/10/14.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.918 green:0.298 blue:0.537 alpha:1.000];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.backgroundColor = self.contentView.backgroundColor;
        _titleLabel.opaque = YES;
    }
    return _titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}
@end
