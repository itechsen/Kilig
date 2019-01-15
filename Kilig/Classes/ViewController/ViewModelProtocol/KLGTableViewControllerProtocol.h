//
//  KLGTableViewControllerProtocol.h
//  Pods
//
//  Created by chenyusen on 2018/6/20.
//

#ifndef KLGTableViewControllerProtocol_h
#define KLGTableViewControllerProtocol_h

#import "KLGViewViewModelProtocol.h"

@protocol KLGTableViewControllerProtocol<KLGViewViewModelProtocol>

/**
 控制器持有的tableView
 */
@property (nonatomic, strong) UITableView *klg_tableView;


/**
 klg_tableView的类型
 */
@property (nonatomic, assign) UITableViewStyle klg_tableViewStyle;

/**
 是否支持下拉刷新
 */
@property (nonatomic, assign)  BOOL klg_canDragRefresh;

/**
 是否支持上拉加载更多
 */
@property (nonatomic, assign)  BOOL klg_canDragLoadMore;


@end


#endif /* KLGTableViewControllerProtocol_h */
