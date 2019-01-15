//
//  FDEDemo05CellItem.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/17.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "FDEDemo05CellItem.h"

@implementation FDEDemo05CellItem

- (NSArray<UITableViewRowAction *> *)rowActions {
    UITableViewRowAction *tipAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"提示" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"哈哈");
    }];
    
    return @[tipAction];
    
}

- (UIColor *)highlightColor {
    return [UIColor blackColor];
}
@end
