//
//  KLGTableViewCellItem.h
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import <Foundation/Foundation.h>
#import "KLGTableViewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *KLGTableViewCellItemKey NS_EXTENSIBLE_STRING_ENUM;

extern KLGTableViewCellItemKey const KLGTableViewCellModelAttribute; // KLGTableViewCellItem的model的key
extern KLGTableViewCellItemKey const KLGTableViewCellHeightAttribute; // KLGTableViewCellItem的cellHeight或则KLGCellHeightBlock的key
extern KLGTableViewCellItemKey const KLGTableViewCellClassAttribute; // KLGTableViewCellItem的cellClass的key
extern KLGTableViewCellItemKey const KLGTableViewCellNibAttribute; // KLGTableViewCellItem的cellNib的key
extern KLGTableViewCellItemKey const KLGTableViewCellRowActionsAttribute; // KLGTableViewCellItem的rowActions的key
extern KLGTableViewCellItemKey const KLGTableViewCellStyleAttribute; // KLGTableViewCellItem的cellStyle的key
extern KLGTableViewCellItemKey const KLGTableViewCellTapCellActionAttribute; // KLGTableViewCellItem的tapCellAction的key
extern KLGTableViewCellItemKey const KLGTableViewCellHighlightColorAttribute; // KLGTableViewCellItem的highlightColor的key
extern KLGTableViewCellItemKey const KLGTableViewCellStaticCellAttribute; // KLGTableViewCellItem的staticCell的key

typedef CGFloat (^KLGCellHeightBlock) (_Nullable id);

/**
 提供一个实现KLGTableViewCellItem协议的类,可以直接用或则继承自它
 */
@interface KLGTableViewCellItem: NSObject <KLGTableViewCellItem>

@property (nonatomic, strong, nullable) id model;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong, nullable) Class cellClass;

@property (nonatomic, strong, nullable) UINib *cellNib;

@property (nonatomic, weak, nullable) __kindof UITableViewCell *currentCell;

@property (nonatomic, strong) __kindof UITableViewCell *staticCell;

@property (nonatomic, assign) UITableViewCellStyle cellStyle;

@property (nonatomic, strong, nullable) UIColor *highlightColor;

@property (nonatomic, strong, nullable) NSArray<UITableViewRowAction *> *rowActions;

@property (nonatomic, copy, nullable) KLGTableViewCellActionHandler tapCellAction;


#pragma mark - Initializer

/**
 默认构造器
 
 @param attributes KLGTableViewCellItemKey的枚举值
 @return KLGTableViewCellItem实例
 */
- (instancetype)initWithAttributes:(nullable NSDictionary *)attributes;


/**
 便捷构造器, 内部实现initWithAttributes:方法
 
 @param model cell绑定数据
 @param cellClass 指定cell类型
 @param cellHeight 指定cell高度
 @return KLGTableViewCellItem实例
 */
- (instancetype)initWithModel:(nullable id)model
                    cellClass:(nullable Class)cellClass
                   cellHeight:(CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
