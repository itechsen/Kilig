//
//  DemoCollectionViewCell.m
//  Kilig_Example
//
//  Created by chenyusen on 2018/5/19.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "DemoCollectionViewCell.h"

@implementation DemoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.frame = self.contentView.bounds;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

@end
