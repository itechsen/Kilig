//
//  TestTableViewHeaderView.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/16.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "Demo03TableViewHeaderView.h"
@import Kilig;

@implementation Demo03TableViewHeaderView {
    UILabel *_titleLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (BOOL)klg_updateHeaderFooterViewItem:(id<KLGTableViewHeaderFooterViewItem>)headerFooterViewItem {
    if ([super klg_updateHeaderFooterViewItem:headerFooterViewItem]) {
        _titleLabel.text = ((NSDictionary *)headerFooterViewItem.model)[@"title"];
        return YES;
    }
    return NO;
    
}

@end
