//
//  KLGTableViewAction.h
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import <Foundation/Foundation.h>
#import "KLGTableViewItemProtocol.h"
#import "KLGTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface KLGTableViewAction : NSObject <UITableViewDelegate>
/**
 用于控制当前UITableView上Cell的selectionStyle
 */
@property (nonatomic, assign) UITableViewCellSelectionStyle tableViewCellSelectionStyle;

@property (nonatomic, weak) KLGTableViewModel *tableViewModel;

@property (nonatomic, weak) UITableView *tableView;

#pragma mark - Initializer

- (instancetype)initWithTableViewModel:(KLGTableViewModel *)tableViewModel;

/**
 KLGTableViewAction无法处理的方法, 将转发给forwardTarget处理
 
 @param forwardTarget 订阅的转发回调对象
 */
- (void)addTarget:(id<UITableViewDelegate>)forwardTarget;

/**
 绑定指定KLGTableViewCellItem实例所绑定cell的点击事件
 
 @param cellItem 指定KLGTableViewCellItem实例
 @param actionHandler 点击事件处理
 @return 返回指定KLGTableViewCellItem实例
 */
- (id<KLGTableViewCellItem>)tapWithCellItem:(id<KLGTableViewCellItem>)cellItem
                              actionHandler:(nullable KLGTableViewCellActionHandler)actionHandler;


/**
 绑定指定KLGTableViewCellItem一类实例所绑定cell的点击事件
 
 @param cellItemClass 指定KLGTableViewCellItem类型
 @param actionHandler 点击事件处理
 */
- (void)tapWithCellItemClass:(Class)cellItemClass
               actionHandler:(nullable KLGTableViewCellActionHandler)actionHandler;


@end
NS_ASSUME_NONNULL_END
