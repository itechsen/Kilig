//
//  KLGViewController.m
//  Kilig
//
//  Created by TechSen on 05/17/2018.
//  Copyright (c) 2018 TechSen. All rights reserved.
//

#import "KLGDemoViewController.h"
#import <Kilig/Kilig.h>

@interface KLGDemoViewController ()<UITableViewDelegate>

@end

@implementation KLGDemoViewController {
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
    _tableView.rowHeight = 40;
    [self.view addSubview:_tableView];
    [_tableView.klg_tableViewAction addTarget:self];
    UINib *cellNib = [UINib nibWithNibName:@"KLGTableViewCell" bundle:[NSBundle mainBundle]];
    
    __weak typeof(self) weakSelf = self;
    NSArray *cellItems = [demoes klg_mapBlock:^id _Nonnull(NSDictionary *dict) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        KLGCellHeightBlock cellHeight = ^(id model) {
            return 200.0;
        };
        NSDictionary *attributes = @{
                                     KLGTableViewCellModelAttribute : @{@"title" : dict[@"title"]},
                                     KLGTableViewCellNibAttribute : cellNib,
                                     KLGTableViewCellHeightAttribute : cellHeight,
                                     KLGTableViewCellHighlightColorAttribute : [UIColor yellowColor]
                                     };
        return [strongSelf->_tableView.klg_tableViewAction tapWithCellItem:[[KLGTableViewCellItem alloc] initWithAttributes:attributes]
                                                 actionHandler:^BOOL(id<KLGTableViewCellItem>  _Nonnull cellItem, NSIndexPath * _Nonnull indexPath) {
                                                     
                                                     Class vcClass = NSClassFromString(dict[@"vc"]);
                                                     [weakSelf.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
                                                     
                                                     return YES;
                                                 }];
    }];
    [_tableView.klg_tableViewModel addCellItems:cellItems];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
