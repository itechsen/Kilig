//
//  UITableViewCell+KLG.h
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import <UIKit/UIKit.h>
#import "KLGTableViewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (KLG)

/**
 当前Cell所绑定的数据模型
 */
@property (nonatomic, strong, nullable) id<KLGTableViewCellItem> klg_cellItem;


/**
 在创建此类UITablViewCell时,是否需要拼接其绑定的KLGTableViewCellItem的信息,用于不复用的静态绑定
 
 @return 是否拼接, 默认不拼接
 */
+ (BOOL)klg_shouldAppendCellItemToReuseIdentifier;

/**
 更新当前TableViewCell的数据, 需要在方法中先调用父类方法
 
 @param cellItem 数据模型
 @return 是否需要更新
 */

- (BOOL)klg_updateCellItem:(nullable id<KLGTableViewCellItem>)cellItem NS_REQUIRES_SUPER;

@end
NS_ASSUME_NONNULL_END
