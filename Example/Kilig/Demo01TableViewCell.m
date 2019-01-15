//
//  TestTableViewCell.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/15.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "Demo01TableViewCell.h"
@import Kilig;

@implementation Demo01TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (BOOL)klg_updateCellItem:(id<KLGTableViewCellItem>)cellItem {
    if ([super klg_updateCellItem:cellItem]) {
        NSDictionary *model = cellItem.model;
        self.textLabel.text = model[@"title"];
        NSLog(@"%@", model[@"title"]);
        return YES;
    }
    return NO;
}
@end
