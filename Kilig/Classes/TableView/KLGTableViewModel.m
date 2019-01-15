//
//  KLGTableViewModel.m
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import "KLGTableViewModel.h"
#import "UITableViewCell+KLG.h"
#import "KLGTableViewSectionItem.h"


@implementation KLGTableViewModel {
    NSMutableArray<id<KLGTableViewSectionItem>> *_sectionItems;
    BOOL _showSectionIndexTitlesIfNeeded;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sectionItems = [NSMutableArray array];
        _showSectionIndexTitlesIfNeeded = NO;
    }
    return self;
}

- (void)showSectionIndexTitlesIfNeeded {
    _showSectionIndexTitlesIfNeeded = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    assert(_sectionItems.count > section || _sectionItems.count == 0);
    if (section < _sectionItems.count) {
        return _sectionItems[section].cellItems.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<KLGTableViewCellItem> cellItem = [self cellItemWithIndexPath:indexPath];
    assert(cellItem);
    Class cellClass;
    if ([cellItem respondsToSelector:@selector(cellClass)]) {
        cellClass = [cellItem cellClass];
    }
    UITableViewCell *cell;
    if (cellClass) {
        cell = [self cellWithCellClass:cellClass tableView:tableView cellItem:cellItem];
    } else if ([cellItem respondsToSelector:@selector(cellNib)] && [cellItem cellNib]) {
        cell = [self cellWithCellNib:[cellItem cellNib] tableView:tableView indexPath:indexPath];
    } else {
        NSAssert(NO, @"mmp, the cellItem you provided must implement either cellNib or cellClass method");
    }
    [cell klg_updateCellItem:cellItem];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<KLGTableViewSectionItem> sectionItem = _sectionItems[section];
    if ([sectionItem respondsToSelector:@selector(headerTitle)]) {
        return sectionItem.headerTitle;
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    id<KLGTableViewSectionItem> sectionItem = _sectionItems[section];
    if ([sectionItem respondsToSelector:@selector(footerTitle)]) {
        return sectionItem.footerTitle;
    } else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        return YES;
    } else {
        id<KLGTableViewCellItem> cellItem = [self cellItemWithIndexPath:indexPath];
        if ([cellItem respondsToSelector:@selector(rowActions)]) {
            return cellItem.rowActions.count > 0;
        }
        return NO;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_showSectionIndexTitlesIfNeeded) {
        NSMutableArray *titles = [NSMutableArray arrayWithCapacity:_sectionItems.count];
        for (id<KLGTableViewSectionItem> sectionItem in _sectionItems) {
            NSString *title;
            
            if ([sectionItem respondsToSelector:@selector(headerTitle)]) {
                title = [sectionItem headerTitle];
                if (title.length > 0) {
                    [titles addObject:title];
                }
            }
        }
        return titles;
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    if (_sectionItems.count > index) {
        [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    return index;
}

#pragma mark - Tool
- (UITableViewCell *)cellWithCellClass:(Class)cellClass
                             tableView:(UITableView *)tableView
                              cellItem:(id<KLGTableViewCellItem>)cellItem {
    
    NSString *identifier = NSStringFromClass(cellClass);
    if (([cellClass respondsToSelector:@selector(klg_shouldAppendCellItemToReuseIdentifier)] &&
        [cellClass klg_shouldAppendCellItemToReuseIdentifier]) || ([cellItem respondsToSelector:@selector(staticCell)] && cellItem.staticCell)) {
        identifier = [identifier stringByAppendingFormat:@".%@", NSStringFromClass([cellItem class])];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if ([cellItem respondsToSelector:@selector(staticCell)] && !!cellItem.staticCell) {
            cell = cellItem.staticCell;
        } else {
            UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
            if ([cellItem respondsToSelector:@selector(cellStyle)]) {
                cellStyle = [cellItem cellStyle];
            }
            cell = [[cellClass alloc] initWithStyle:cellStyle reuseIdentifier:identifier];
        }
    }
    return cell;
}

- (UITableViewCell *)cellWithCellNib:(UINib *)cellNib
                           tableView:(UITableView *)tableView
                           indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([cellNib class]);
    [tableView registerNib:cellNib forCellReuseIdentifier:identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}
@end

@implementation KLGTableViewModel (CRUD)
#pragma mark - Add
- (void)addCellItem:(id<KLGTableViewCellItem>)cellItem {
    assert(cellItem);
    [self addCellItems:@[cellItem]];
}

- (void)addCellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems {
    assert(cellItems);
    if (_sectionItems.count == 0) {
        id<KLGTableViewSectionItem> sectionItem = [KLGTableViewSectionItem sectionItemWithHeaderViewItem:nil
                                                                                          footerViewItem:nil
                                                                                               cellItems:nil];
        [_sectionItems addObject:sectionItem];
    }
    id<KLGTableViewSectionItem> lastSectionItem = _sectionItems.lastObject;
    if (!lastSectionItem.cellItems) {
        NSMutableArray <id<KLGTableViewCellItem>> *cellItems = [NSMutableArray array];
        lastSectionItem.cellItems = cellItems;
    }
    [lastSectionItem.cellItems addObjectsFromArray:cellItems];
}

- (void)addSectionItem:(id<KLGTableViewSectionItem>)sectionItem {
    assert(sectionItem);
    [self addSectionItems:@[sectionItem]];
}

- (void)addSectionItems:(NSArray<id<KLGTableViewSectionItem>> *)sectionItems {
    assert(sectionItems);
    [_sectionItems addObjectsFromArray:sectionItems];
}


#pragma mark - Remove
- (BOOL)removeCellItemWithIndexPath:(NSIndexPath *)indexPath {
    assert(indexPath.section < _sectionItems.count);
    assert(indexPath.row < _sectionItems.firstObject.cellItems.count);
    
    if (indexPath.section < _sectionItems.count) {
        NSInteger row = indexPath.row;
        NSMutableArray <id<KLGTableViewCellItem>> *cellItems = _sectionItems[indexPath.row].cellItems;
        if (indexPath.row < cellItems.count) {
            [cellItems removeObjectAtIndex:row];
            return YES;
        }
        return NO;
    }
    return NO;
}

- (BOOL)removeCellItem:(id<KLGTableViewCellItem>)cellItem {
    
    for (id<KLGTableViewSectionItem> sectionItem in _sectionItems) {
        for (id<KLGTableViewCellItem> aCellItem in sectionItem.cellItems.mutableCopy) {
            if (aCellItem == cellItem) {
                [sectionItem.cellItems removeObject:cellItem];
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)removeSectionItemWithIndex:(NSInteger)index {
    assert(_sectionItems.count > index);
    if (_sectionItems.count > index) {
        [_sectionItems removeObjectAtIndex:index];
        return YES;
    } else {
        return NO;
    }
}

- (void)removeAll {
    [_sectionItems removeAllObjects];
}

#pragma mark - Insert
- (BOOL)insertCellItem:(id<KLGTableViewCellItem>)cellItem atRow:(NSInteger)row {
    return [self insertCellItems:@[cellItem] fromIndexPath:[NSIndexPath indexPathForRow:row inSection:_sectionItems.count - 1]];
}

- (BOOL)insertCellItem:(id<KLGTableViewCellItem>)cellItem atIndexPath:(NSIndexPath *)indexPath {
    return [self insertCellItems:@[cellItem] fromIndexPath:indexPath];
}

- (BOOL)insertCellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems fromRow:(NSInteger)row {
    return [self insertCellItems:cellItems fromIndexPath:[NSIndexPath indexPathForRow:row inSection:_sectionItems.count - 1]];
}

- (BOOL)insertCellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems fromIndexPath:(NSIndexPath *)indexPath {
    if (_sectionItems.count == 0) {
        id<KLGTableViewSectionItem> sectionItem = [KLGTableViewSectionItem sectionItemWithHeaderViewItem:nil
                                                                                          footerViewItem:nil
                                                                                               cellItems:nil];
        [_sectionItems addObject:sectionItem];
    }
    if (indexPath.section < _sectionItems.count) {
        NSInteger row = indexPath.row;
        NSMutableArray <id<KLGTableViewCellItem>> *cellItems = _sectionItems[indexPath.row].cellItems;
        if (row < cellItems.count) {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row, cellItems.count)];
            [cellItems insertObjects:cellItems atIndexes:indexSet];
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (BOOL)insertSectionItem:(id<KLGTableViewSectionItem>)sectionItem atIndex:(NSInteger)index {
    assert(index < _sectionItems.count);
    if (index < _sectionItems.count) {
        [_sectionItems insertObject:sectionItem atIndex:index];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)insertSectionItems:(NSArray<id<KLGTableViewSectionItem>> *)sectionItems atIndex:(NSInteger)index {
    assert(index < _sectionItems.count);
    if (index < _sectionItems.count) {
        NSRange indexesRange = NSMakeRange(index, sectionItems.count);
        [_sectionItems insertObjects:sectionItems
                           atIndexes:[NSIndexSet indexSetWithIndexesInRange:indexesRange]];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Search
- (id<KLGTableViewCellItem>)cellItemWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sectionItems.count) {
        NSInteger row = indexPath.row;
        NSMutableArray <id<KLGTableViewCellItem>> *cellItems = _sectionItems[indexPath.section].cellItems;
        if (row < cellItems.count) {
            return cellItems[row];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSArray<id<KLGTableViewCellItem>> *)cellItemsAtSection:(NSInteger)index {
    if (index < _sectionItems.count) {
        return _sectionItems[index].cellItems;
    } else {
        return nil;
    }
}

- (NSArray<id<KLGTableViewCellItem>> *)allCellItems {
    NSMutableArray *allCellItems = [NSMutableArray array];
    for (id<KLGTableViewSectionItem> sectionItem in _sectionItems) {
        [allCellItems addObjectsFromArray:sectionItem.cellItems];
    }
    return allCellItems;
}

- (id<KLGTableViewSectionItem>)sectionItemWithIndex:(NSInteger)index {
    if (index < _sectionItems.count) {
        return _sectionItems[index];
    } else {
        return nil;
    }
}

- (NSArray<id<KLGTableViewSectionItem>> *)allSectionItems {
    return _sectionItems;
}
@end
