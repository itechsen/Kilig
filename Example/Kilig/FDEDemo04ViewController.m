//
//  FDEDemo04ViewController.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/17.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "FDEDemo04ViewController.h"
@import Kilig;
#import "Demo01TableViewCell.h"

@interface FDEDemo04ViewController ()

@end

@implementation FDEDemo04ViewController  {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"indexTitles";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray *sectionItems = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        
        NSMutableArray *cellItems = [NSMutableArray array];
        for (NSInteger j = 0; j < 20; j++) {
            NSString *title = [NSString stringWithFormat:@"Cell%ld %ld",i, j];
            NSDictionary *attribute = @{
                                        KLGTableViewCellModelAttribute : @{@"title" : title},
                                        KLGTableViewCellClassAttribute : [Demo01TableViewCell class]
                                        };
            KLGTableViewCellItem *cellItem = [[KLGTableViewCellItem alloc] initWithAttributes:attribute];
            [cellItems addObject:cellItem];
        }
        
        
        KLGTableViewSectionItem *sectionItem = [KLGTableViewSectionItem sectionItemWithHeaderTitle:[NSString stringWithFormat:@"S %ld", i]
                                                                                       footerTitle:nil
                                                                                      headerHeight:30
                                                                                      footerHeight:0
                                                                                         cellItems:cellItems];
        [sectionItems addObject:sectionItem];
    }
    [_tableView.klg_tableViewModel addSectionItems:sectionItems];
    [_tableView.klg_tableViewModel showSectionIndexTitlesIfNeeded];
}
@end
