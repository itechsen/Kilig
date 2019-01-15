//
//  KLGTableViewItemProtocol.h
//  Pods
//
//  Created by chenyusen on 2018/5/17.
//

#ifndef KLGTableViewItemProtocol_h
#define KLGTableViewItemProtocol_h

NS_ASSUME_NONNULL_BEGIN

@protocol KLGTableViewCellItem;

/**
 用于绑定cell点击事件的处理回调
 
 @param cellItem cell所绑定的cellItem
 @param indexPath cell所在的indexPath
 @return 点击完后,是否取消点击高亮状态
 */
typedef BOOL(^KLGTableViewCellActionHandler)(id<KLGTableViewCellItem> cellItem, NSIndexPath *indexPath);

#pragma mark - 用于驱动UITableViewHeaderFooterView展示的协议
@protocol KLGTableViewHeaderFooterViewItem <NSObject>
/** 当前协议对象所绑定的UITableViewHeaderFooterView实例 */
@property (nonatomic, weak, nullable) __kindof UITableViewHeaderFooterView *currentView;

/** 指定所需绑定的UITableViewHeaderFooterView的类型 */
- (Class)viewClass;

@optional
/** 静态绑定时用的View */
- (nullable __kindof UITableViewHeaderFooterView *)staticView;

/** 用于绑定在UITableViewHeaderFooterView的数据 */
- (nullable id)model;

/** 指定所绑定的UITableViewHeaderFooterView显示的高度 */
- (CGFloat)viewHeight;

@end



#pragma mark - 用于驱动UITableViewCell展示的协议
@protocol KLGTableViewCellItem <NSObject>

@optional
/** 当前协议对象所绑定的UITableViewCell实例 */
@property (nonatomic, weak, nullable) __kindof UITableViewCell *currentCell;

/**
 创建cell时的样式
 */
- (UITableViewCellStyle)cellStyle;

/** 指定所绑定的UITableViewCell显示的高度 */
- (CGFloat)cellHeight;

/** 指定所需绑定的UITableViewCell的类型 cellClass 和 cellNib 必须至少实现一个 */
- (nullable Class)cellClass;

/** 静态绑定时用的Cell */
- (nullable __kindof UITableViewCell *)staticCell;

/** 指定所需绑定的UITableViewCell的类型的xib cellClass 和 cellNib 必须至少实现一个 */
- (nullable UINib *)cellNib;

/** 用于绑定在UITableViewCell的数据 */
- (nullable id)model;

/** 高亮状态下的Cell背景色 */
- (nullable UIColor *)highlightColor;

/** 侧滑手势 */
- (nullable NSArray<UITableViewRowAction *> *)rowActions;

/**
 指定当前cellItem实例所绑定的cell被点击时的回调, 优先级最高
 */
@property (nonatomic, copy, nullable) KLGTableViewCellActionHandler tapCellAction;

@end

#pragma mark - 用于驱动一个UITableView分组展示的协议
@protocol KLGTableViewSectionItem <NSObject>
@optional
/** 当前分组所持有的KLGTableViewCellItem */
@property (nonatomic, strong) NSMutableArray<id<KLGTableViewCellItem>> *cellItems;

/** 分组头标题 */
- (nullable NSString *)headerTitle;

/** 分组尾标题 */
- (nullable NSString *)footerTitle;

/** 分组头高度 */
- (CGFloat)headerHeight;

/** 分组尾高度 */
- (CGFloat)footerHeight;

/** 当分组头用UITableViewHeaderFooterView展示时,用于驱动UITableViewHeaderFooterView的KLGTableViewHeaderFooterViewItem */
- (nullable id<KLGTableViewHeaderFooterViewItem>)headerViewItem;
/** 当分组尾用UITableViewHeaderFooterView展示时,用于驱动UITableViewHeaderFooterView的KLGTableViewHeaderFooterViewItem */
- (nullable id<KLGTableViewHeaderFooterViewItem>)footerViewItem;
@end

NS_ASSUME_NONNULL_END

#endif /* KLGTableViewItemProtocol_h */
