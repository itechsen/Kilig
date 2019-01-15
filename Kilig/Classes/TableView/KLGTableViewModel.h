//
//  KLGTableViewModel.h
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import <Foundation/Foundation.h>
#import "KLGTableViewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface KLGTableViewModel : NSObject <UITableViewDataSource>
/**
 如果可以是否需要展示索引
 */
- (void)showSectionIndexTitlesIfNeeded;
@end

@interface KLGTableViewModel (CRUD)
#pragma mark - Add
/**
 添加一个cellItem, 会追加到最后一个section的最后一个位置
 
 @param cellItem 添加的KLGTableViewCellItem实例
 */
- (void)addCellItem:(id<KLGTableViewCellItem>)cellItem;


/**
 添加一组cellItem, 会追加到最后一个section的最后一个位置
 
 @param cellItems 添加的KLGTableViewCellItem实例数组
 */
- (void)addCellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems;


/**
 添加一个sectionItem,会追加到最后一个section的最后一个位置
 
 @param sectionItem 添加的KLGTableViewSectionItem实例
 */
- (void)addSectionItem:(id<KLGTableViewSectionItem>)sectionItem;


/**
 添加一组sectionItem,会追加到最后一个section的最后一个位置
 
 @param sectionItems 添加的KLGTableViewSectionItem实例数组
 */
- (void)addSectionItems:(NSArray<id<KLGTableViewSectionItem>> *)sectionItems;


#pragma mark - Remove
/**
 删除指定位置的cellItem
 
 @param indexPath 指定的indexPath位置
 @return 是否成功删除, 若指定indexPath不存在,则返回false
 */
- (BOOL)removeCellItemWithIndexPath:(NSIndexPath *)indexPath;


/**
 删除指定的cellItem
 
 @param cellItem 指定的KLGTableViewSectionItem实例
 @return 是否成功删除, 若不存在指定KLGTableViewSectionItem实例,则返回false
 */
- (BOOL)removeCellItem:(id<KLGTableViewCellItem>)cellItem;


/**
 删除指定的索引的sectionItem
 
 @param index 指定索引
 @return 是否成功删除, 若index不存在, 则return false
 */
- (BOOL)removeSectionItemWithIndex:(NSInteger)index;


/**
 清空所有sectionItems
 */
- (void)removeAll;


#pragma mark - Insert
/**
 插入一个cellItem到最后一组section的指定行
 
 @param cellItem KLGTableViewCellItem实例
 @param row 指定行
 @return 是否插入成功,若row越界,则插入失败
 */
- (BOOL)insertCellItem:(id<KLGTableViewCellItem>)cellItem atRow:(NSInteger)row;


/**
 插入一个cellItem到指定indexPath位置
 
 @param cellItem KLGTableViewCellItem实例
 @param indexPath 指定indexPath
 @return 是否插入成功,若indexPath越界, 则插入失败
 */
- (BOOL)insertCellItem:(id<KLGTableViewCellItem>)cellItem atIndexPath:(NSIndexPath *)indexPath;


/**
 插入一组cellItem到于最后一组section的指定row位置
 
 @param cellItems 待插入的cellItem数组
 @param row 指定位置
 @return 是否插入成功, 若row越界, 则插入失败
 */
- (BOOL)insertCellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems fromRow:(NSInteger)row;


/**
 插入一组cellItem到于指定indexPath位置
 
 @param cellItems 待插入的cellItem数组
 @param indexPath 指定的indexPath
 @return 是否插入成功, 若indexPath越界, 则插入失败
 */
- (BOOL)insertCellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems fromIndexPath:(NSIndexPath *)indexPath;


/**
 插入一个sectionItem到指定索引位置
 
 @param sectionItem 待插入的sectionItem
 @param index 指定索引位置
 @return 是否插入成功, 若index越界, 则插入失败
 */
- (BOOL)insertSectionItem:(id<KLGTableViewSectionItem>)sectionItem atIndex:(NSInteger)index;


/**
 插入一个sectionItems到指定索引位置
 
 @param sectionItems 待插入的sectionItem数组
 @param index 指定索引位置
 @return 是否插入成功, 若index越界, 则插入失败
 */
- (BOOL)insertSectionItems:(NSArray<id<KLGTableViewSectionItem>> *)sectionItems atIndex:(NSInteger)index;


#pragma mark - Search
/**
 获取指定indexPath的cellItem
 
 @param indexPath 指定indexPath
 @return KLGTableViewCellItem实例
 */
- (nullable id<KLGTableViewCellItem>)cellItemWithIndexPath:(NSIndexPath *)indexPath;


/**
 获取某一组的cellItem数组
 
 @param index section索引
 @return KLGTableViewCellItem实例数组
 */
- (nullable NSArray<id<KLGTableViewCellItem>> *)cellItemsAtSection:(NSInteger)index;


/**
 获取所有cellItem
 
 @return 所有cellItem
 */
- (nullable NSArray<id<KLGTableViewCellItem>> *)allCellItems;


/**
 获取某一个位置的sectionItem
 
 @param index 指定位置索引
 @return KLGTableViewSectionItem实例
 */
- (nullable id<KLGTableViewSectionItem>)sectionItemWithIndex:(NSInteger)index;


/**
 获取所有分组
 
 @return 所有分组
 */
- (nullable NSArray<id<KLGTableViewSectionItem>> *)allSectionItems;
@end
NS_ASSUME_NONNULL_END
