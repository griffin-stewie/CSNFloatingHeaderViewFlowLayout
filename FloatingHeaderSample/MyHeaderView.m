//
//  MyHeaderView.m
//  FloatingHeaderSample
//
//  Created by griffin_stewie on 2013/10/14.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.541 green:0.729 blue:0.337 alpha:1.000];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.backgroundColor = self.backgroundColor;
        _titleLabel.opaque = YES;
    }
    return _titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
@end
