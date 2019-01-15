//
//  UITableView+KLGRefresh.h
//  Kilig
//
//  Created by chenyusen on 2018/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^KLGDragAction)(BOOL forMore);


/**
 基于MJRefresh的封装
 */
@interface UITableView (KLGRefresh)

/**
 是否支持下拉刷新 默认NO
 */
@property (nonatomic, assign)  BOOL klg_canDragRefresh;

/**
 是否支持上拉加载更多 默认NO
 */
@property (nonatomic, assign)  BOOL klg_canDragLoadMore;

/**
 刷新控件回调
 */
@property (nonatomic, copy) KLGDragAction klg_dragAction;

/**
 当前tableView下拉刷新控件类型, 如果不传,默认取全局默认值
 */
@property (nonatomic, strong) Class klg_refreshHeaderClass;

/**
 当前tableView上拉加载更多控件类型, 如果不传,默认取全局默认值
 */
@property (nonatomic, strong) Class klg_refreshFooterClass;

/**
 全局默认下拉刷新控件类型
 */
@property (nonatomic, strong, class) Class klg_defaultRefreshHeaderClass;

/**
 全局默认上拉加载更多控件类型
 */
@property (nonatomic, strong, class) Class klg_defaultRefreshFooterClass;

@end

NS_ASSUME_NONNULL_END
