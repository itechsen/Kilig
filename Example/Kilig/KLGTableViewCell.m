//
//  KLGTableViewCell.m
//  Kilig_Example
//
//  Created by chenyusen on 2018/5/17.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "KLGTableViewCell.h"
@import Kilig;

@implementation KLGTableViewCell

- (BOOL)klg_updateCellItem:(id<KLGTableViewCellItem>)cellItem {
    if ([super klg_updateCellItem:cellItem]) {
        self.titleLabel.text = ((NSDictionary *)cellItem.model)[@"title"];
        return YES;
    }
    return NO;
}

@end
