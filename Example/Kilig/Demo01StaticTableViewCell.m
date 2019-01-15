//
//  Demo01StaticTableViewCell.m
//  Kilig_Example
//
//  Created by chenyusen on 2018/7/30.
//  Copyright © 2018 TechSen. All rights reserved.
//

#import "Demo01StaticTableViewCell.h"

@implementation Demo01StaticTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
