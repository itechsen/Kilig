//
//  FDEDemo01ViewController.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/16.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "FDEDemo01ViewController.h"
@import Kilig;
#import <Kilig/KLGTableViewCellItem+Chaining.h>
#import "Demo01TableViewCell.h"
#import "Demo01StaticTableViewCell.h"


@interface FDEDemo01ViewController ()

@end

@implementation FDEDemo01ViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"单组多行";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.rowHeight = 400;
    [self.view addSubview:_tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    NSMutableArray *cellItems = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        
        NSString *title = [NSString stringWithFormat:@"测试标题%ld",i];
//        NSDictionary *attrubutes = @{
//                                     KLGTableViewCellModelAttribute : @{@"title" : title},
//                                     KLGTableViewCellClassAttribute : [Demo01TableViewCell class]
//                                     };
        KLGTableViewCellItem *cellItem = [[KLGTableViewCellItem alloc] init];
        cellItem.maker.model(@{@"title" : title}).cellClass([Demo01TableViewCell class]).highlightColor([UIColor orangeColor]);
//        cellItem.tapCellAction = ^BOOL(id<KLGTableViewCellItem>  _Nonnull cellItem, NSIndexPath * _Nonnull indexPath) {
//            NSLog(@"mmp");
//            return YES;
//        };
        if (i == 0) {
            Demo01StaticTableViewCell *staticCell = [[Demo01StaticTableViewCell alloc] init];
            cellItem.maker.staticCell(staticCell);
        }
        [cellItems addObject:cellItem];

    }
    
    
    __weak typeof(self) weakSelf = self;
    
    [_tableView.klg_tableViewAction tapWithCellItemClass:[KLGTableViewCellItem class]
                                           actionHandler:^BOOL(id<KLGTableViewCellItem>  _Nonnull cellItem, NSIndexPath * _Nonnull indexPath) {
                                               
                                               UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"弹框" message:((NSDictionary *)cellItem.model)[@"title"] preferredStyle:UIAlertControllerStyleAlert];
                                               [weakSelf presentViewController:alertVC animated:YES completion:^{
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       if (weakSelf) {
                                                           [alertVC dismissViewControllerAnimated:YES completion:nil];
                                                       }
                                                   });
                                               }];
                                               return YES;
                                           }];
    [_tableView.klg_tableViewModel addCellItems:cellItems];
}

- (void)dealloc {
    
}

@end
