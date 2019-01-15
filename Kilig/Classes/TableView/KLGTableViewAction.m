//
//  KLGTableViewAction.m
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import "KLGTableViewAction.h"
#import <objc/runtime.h>
#import "UITableView+KLG.h"
#import "UITableViewHeaderFooterView+KLG.h"
#import "KLGTableViewModel.h"

@implementation KLGTableViewAction {
    NSMutableSet *_forwardDelegates;
    NSMutableDictionary<NSNumber *, KLGTableViewCellActionHandler> *_instanceActions;
    NSMutableDictionary<NSNumber *, KLGTableViewCellActionHandler> *_classActions;
    __weak KLGTableViewModel *_tableViewModel;
}

- (KLGTableViewModel *)tableViewModel {
    assert(_tableViewModel);
    return _tableViewModel;
}

- (instancetype)initWithTableViewModel:(KLGTableViewModel *)tableViewModel {
    self = [super init];
    if (self) {
        _tableViewModel = tableViewModel;
        _instanceActions = [NSMutableDictionary dictionary];
        _classActions = [NSMutableDictionary dictionary];
        _tableViewCellSelectionStyle = UITableViewCellSelectionStyleDefault;
        _forwardDelegates = (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil); // 创建一个弱引用set容器
    }
    return self;
}

- (void)addTarget:(id<UITableViewDelegate>)forwardTarget {
    [_forwardDelegates addObject:forwardTarget];
    // 坑逼的苹果,在Xcode10里把 scrollViewDidScroll:做了优化,在绑定上delegate时,立刻监测delegate是否有实现该方法, 如果没实现, 则不再回调
    if ([forwardTarget respondsToSelector:@selector(scrollViewDidScroll:)]) {
        id delegate = self.tableView.delegate;
        self.tableView.delegate = nil;
        self.tableView.delegate = delegate;
    }
}


#pragma mark - Public

- (id<KLGTableViewCellItem>)tapWithCellItem:(id<KLGTableViewCellItem>)cellItem actionHandler:(KLGTableViewCellActionHandler)actionHandler {
    _instanceActions[@(cellItem.hash)] = actionHandler;
    return cellItem;
}

- (void)tapWithCellItemClass:(Class)cellItemClass actionHandler:(KLGTableViewCellActionHandler)actionHandler {
    _classActions[@(cellItemClass.hash)] = actionHandler;
}

#pragma mark - 消息转发
/**
 判断当前选择子是否在UITableViewDelegate中定义
 
 @param aSelector 选择子
 @return 是否有包含
 */
- (BOOL)shouldForwardSelector:(SEL)aSelector {
    struct objc_method_description description;
    description = protocol_getMethodDescription(@protocol(UITableViewDelegate), aSelector, NO, YES);
    return (description.name != NULL && description.types != NULL);
}


/**
 重写respondsToSelector:方法, 对外隐藏内部转发实现
 
 @param aSelector 选择子
 @return 是否能响应
 */
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    } else if ([self shouldForwardSelector:aSelector]) {
        for (id delegate in _forwardDelegates) {
            if ([delegate respondsToSelector:aSelector]) {
                return YES;
            }
        }
    }
    return NO;
}


/**
 找一个能转发目标选择子的对象,让他干这活
 
 @param aSelector 选择子
 @return 转发对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    for (id delegate in _forwardDelegates) {
        if ([delegate respondsToSelector:aSelector]) {
            return delegate;
        }
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<KLGTableViewCellItem> cellItem = [self.tableViewModel cellItemWithIndexPath:indexPath];
    KLGTableViewCellActionHandler actionHandler = [self actionHandlerWithCellItem:cellItem];
    if (!tableView.isEditing && actionHandler) {
        if (actionHandler(cellItem, indexPath)) {
            [tableView deselectRowAtIndexPath:indexPath animated:true];
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<KLGTableViewCellItem> cellItem = [self.tableViewModel cellItemWithIndexPath:indexPath];
    if (cellItem && [cellItem respondsToSelector:@selector(cellHeight)] && cellItem.cellHeight > 0) {
        return cellItem.cellHeight;
    } else {
        return tableView.rowHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<KLGTableViewSectionItem> sectionItem = [self.tableViewModel sectionItemWithIndex:section];
    id<KLGTableViewHeaderFooterViewItem> headerViewItem;
    if ([sectionItem respondsToSelector:@selector(headerViewItem)]) {
        headerViewItem = sectionItem.headerViewItem;
    }
    if (headerViewItem && [headerViewItem respondsToSelector:@selector(viewHeight)] && headerViewItem.viewHeight > 0) {
        return headerViewItem.viewHeight;
    } else if (sectionItem && [sectionItem respondsToSelector:@selector(headerHeight)] && sectionItem.headerHeight > 0) {
        return sectionItem.headerHeight;
    } else if (sectionItem && [sectionItem respondsToSelector:@selector(headerTitle)] && sectionItem.headerTitle.length > 0) {
        return tableView.sectionHeaderHeight;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<KLGTableViewSectionItem> sectionItem = [self.tableViewModel sectionItemWithIndex:section];
    
    id<KLGTableViewHeaderFooterViewItem> footerViewItem;
    if ([sectionItem respondsToSelector:@selector(footerViewItem)]) {
        footerViewItem = sectionItem.footerViewItem;
    }
    if (footerViewItem && [footerViewItem respondsToSelector:@selector(viewHeight)] && footerViewItem.viewHeight > 0) {
        return footerViewItem.viewHeight;
    } else if (sectionItem && [sectionItem respondsToSelector:@selector(footerHeight)] && sectionItem.footerHeight > 0) {
        return sectionItem.footerHeight;
    } else if (sectionItem && [sectionItem respondsToSelector:@selector(footerTitle)] && sectionItem.footerTitle.length > 0) {
        return tableView.sectionFooterHeight;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<KLGTableViewSectionItem> sectionItem = [self.tableViewModel sectionItemWithIndex:section];
    if ([sectionItem respondsToSelector:@selector(headerViewItem)] && sectionItem.headerViewItem.viewClass) {
        id<KLGTableViewHeaderFooterViewItem> headerViewItem = sectionItem.headerViewItem;
        UITableViewHeaderFooterView *headerView = [self headerFooterViewWithHeaderFooterViewClass:headerViewItem.viewClass
                                                                             headerFooterViewItem:headerViewItem
                                                                                        tableView:tableView];
        [headerView klg_updateHeaderFooterViewItem:headerViewItem];
        return headerView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<KLGTableViewSectionItem> sectionItem = [self.tableViewModel sectionItemWithIndex:section];
    if ([sectionItem respondsToSelector:@selector(footerViewItem)] && sectionItem.footerViewItem.viewClass) {
        id<KLGTableViewHeaderFooterViewItem> footerViewItem = sectionItem.footerViewItem;
        UITableViewHeaderFooterView *footerView = [self headerFooterViewWithHeaderFooterViewClass:footerViewItem.viewClass
                                                                             headerFooterViewItem:footerViewItem
                                                                                        tableView:tableView];
        [footerView klg_updateHeaderFooterViewItem:footerViewItem];
        return footerView;
    } else {
        return nil;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<KLGTableViewCellItem> cellItem = [self.tableViewModel cellItemWithIndexPath:indexPath];
    UITableViewCellSelectionStyle selectionStyle;
    // 判断是否处理了cellItem的点击事件，如果有，根据cellItem的cellStyle或则全局的cellStyle来判断
    if (cellItem && [self actionHandlerWithCellItem:cellItem]) {
        selectionStyle = self.tableViewCellSelectionStyle;
    } else {
        selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = selectionStyle;
    
    for (id<UITableViewDelegate> forwardTarget in _forwardDelegates) {
        if ([forwardTarget respondsToSelector:_cmd]) {
            [forwardTarget tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
            return;
        }
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<KLGTableViewCellItem> cellItem = [self.tableViewModel cellItemWithIndexPath:indexPath];
    if (cellItem && [cellItem respondsToSelector:@selector(rowActions)]) {
        return cellItem.rowActions;
    }
    for (id<UITableViewDelegate> forwardTarget in _forwardDelegates) {
        if ([forwardTarget respondsToSelector:_cmd]) {
            return [forwardTarget tableView:tableView editActionsForRowAtIndexPath:indexPath];
        }
    }
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.klg_editType == KLGTableViewEditTypeMultiSelection) {
        // iOS11以下, 这里不返回UITableViewCellEditingStyleDelete, 触发不了侧滑???
        if (!tableView.isEditing && [UIDevice currentDevice].systemVersion.doubleValue <= 11.0) {
            return UITableViewCellEditingStyleDelete;
        }
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
        
    } else {
        id<KLGTableViewCellItem> cellItem = [[self tableViewModel] cellItemWithIndexPath:indexPath];
        if (cellItem && [cellItem respondsToSelector:@selector(rowActions)] && cellItem.rowActions > 0) {
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - Tool
- (KLGTableViewCellActionHandler)actionHandlerWithCellItem:(id<KLGTableViewCellItem>)cellItem {
    
    KLGTableViewCellActionHandler tapCellAction;
    if ([cellItem respondsToSelector:@selector(tapCellAction)]) {
        tapCellAction = cellItem.tapCellAction;
    }
    KLGTableViewCellActionHandler actionHandler = tapCellAction ?: _classActions[@([cellItem class].hash)];
    if (actionHandler) {
        return actionHandler;
    } else {
        return _instanceActions[@(cellItem.hash)];
    }
}


- (UITableViewHeaderFooterView *)headerFooterViewWithHeaderFooterViewClass:(Class)headerFooterViewClass
                                                      headerFooterViewItem:(id<KLGTableViewHeaderFooterViewItem>)headerFooterViewItem
                                                                 tableView:(UITableView *)tableView {
    
    NSString *identifier = NSStringFromClass([headerFooterViewClass class]);
    if (([headerFooterViewClass respondsToSelector:@selector(klg_shouldAppendHeaderFooterViewItemToReuseIdentifier)] &&
        [headerFooterViewClass klg_shouldAppendHeaderFooterViewItemToReuseIdentifier]) || ([headerFooterViewItem respondsToSelector:@selector(staticView)] && headerFooterViewItem.staticView)) {
        identifier = [identifier stringByAppendingFormat:@".%@", NSStringFromClass([headerFooterViewItem class])];
    }
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerFooterView) {
        if ([headerFooterViewItem respondsToSelector:@selector(staticView)] && !!headerFooterViewItem.staticView) {
            headerFooterView = headerFooterViewItem.staticView;
        } else {
            headerFooterView = [[headerFooterViewClass alloc] initWithReuseIdentifier:identifier];
        }
    }
    return headerFooterView;
}

@end
