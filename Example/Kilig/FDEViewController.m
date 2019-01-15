//
//  FDEViewController.m
//  FDEExt
//
//  Created by TechSen on 05/15/2018.
//  Copyright (c) 2018 TechSen. All rights reserved.
//

#import "FDEViewController.h"
@import Kilig;


@interface FDEViewController ()
@end

@implementation FDEViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FDEExtDemo";
    
    NSArray *demoes = @[
                        @{@"title" : @"单组多行", @"vc" : @"FDEDemo01ViewController"},
                        @{@"title" : @"多组默认title多行", @"vc" : @"FDEDemo02ViewController"},
                        @{@"title" : @"多组自定义Header多行", @"vc" : @"FDEDemo03ViewController"},
                        @{@"title" : @"索引模式", @"vc" : @"FDEDemo04ViewController"},
                        @{@"title" : @"多行编辑选择模式", @"vc" : @"FDEDemo05ViewController"}
                        
                        ];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    UINib *cellNib = [UINib nibWithNibName:@"FDETableViewCell" bundle:[NSBundle mainBundle]];
    
    NSMutableArray *cellItems = [NSMutableArray array];

    for (NSDictionary *dict in demoes) {
        
        __weak typeof(self) weakSelf = self;
        NSDictionary *attrubutes = @{
                                     KLGTableViewCellModelAttribute : @{@"title" : dict[@"title"]},
                                     KLGTableViewCellNibAttribute : cellNib
                                     };
        KLGTableViewCellItem *cellItem = [_tableView.klg_tableViewAction tapWithCellItem:[[KLGTableViewCellItem alloc] initWithAttributes:attrubutes]
                                                                           actionHandler:^BOOL(id<KLGTableViewCellItem>  _Nonnull cellItem, NSIndexPath * _Nonnull indexPath) {
                                                                               
                                                                               Class vcClass = NSClassFromString(dict[@"vc"]);
                                                                               [weakSelf.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
                                                                               
            return YES;
        }];
        [cellItems addObject:cellItem];
    }
    
    [_tableView.klg_tableViewModel addCellItems:cellItems];
}
@end
