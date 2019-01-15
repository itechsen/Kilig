//
//  UITableView+KLGRefresh.m
//  Kilig
//
//  Created by chenyusen on 2018/7/2.
//

#import "UITableView+KLGRefresh.h"
#import <MJRefresh/MJRefresh.h>

static char canDragRefreshKey;
static char canDragLoadMoreKey;
static char refreshHeaderClassKey;
static char refreshFooterClassKey;
static char dragActionKey;

static Class defaultRefreshHeaderClass;
static Class defaultRefreshFooterClass;

@implementation UITableView (KLGRefresh)

#pragma mark - Getter && Setter

+ (Class)klg_defaultRefreshHeaderClass {
    return defaultRefreshHeaderClass;
}

+ (void)setKlg_defaultRefreshHeaderClass:(Class)klg_defaultRefreshHeaderClass {
    defaultRefreshFooterClass = klg_defaultRefreshHeaderClass;
}

+ (Class)klg_defaultRefreshFooterClass {
    return defaultRefreshFooterClass;
}

+ (void)setKlg_defaultRefreshFooterClass:(Class)klg_defaultRefreshFooterClass {
    defaultRefreshFooterClass = klg_defaultRefreshFooterClass;
}


- (BOOL)klg_canDragRefresh {
    id result = objc_getAssociatedObject(self, &canDragRefreshKey);
    if (result) {
        return [result boolValue];
    } else {
        objc_setAssociatedObject(self, &canDragRefreshKey, @(NO), OBJC_ASSOCIATION_ASSIGN);
        return NO;
    }
}

- (void)setKlg_canDragRefresh:(BOOL)klg_canDragRefresh {
    if (self.klg_canDragRefresh != klg_canDragRefresh) {
        objc_setAssociatedObject(self, &canDragRefreshKey, @(klg_canDragRefresh), OBJC_ASSOCIATION_ASSIGN);
        if (klg_canDragRefresh) {
            Class headerClass = [self klg_refreshHeaderClass] ?: [[self class] klg_defaultRefreshHeaderClass];
            __weak __typeof(self) wSelf = self;
            self.mj_header = [headerClass headerWithRefreshingBlock:^{
                __strong __typeof(wSelf) sSelf = wSelf;
                if (!sSelf) return;
                if (sSelf.mj_footer && sSelf.mj_footer.isRefreshing) {
                    [sSelf.mj_footer endRefreshing];
                }
                if (sSelf.klg_dragAction) {
                    sSelf.klg_dragAction(NO);
                }
            }];
        } else {
            self.mj_header = nil;
        }
    }
}

- (BOOL)klg_canDragLoadMore {
    id result = objc_getAssociatedObject(self, &canDragLoadMoreKey);
    if (result) {
        return [result boolValue];
    } else {
        objc_setAssociatedObject(self, &canDragLoadMoreKey, @(NO), OBJC_ASSOCIATION_ASSIGN);
        return NO;
    }
}

- (void)setKlg_canDragLoadMore:(BOOL)klg_canDragLoadMore {
    if (self.klg_canDragLoadMore == klg_canDragLoadMore) {
        objc_setAssociatedObject(self, &canDragLoadMoreKey, @(klg_canDragLoadMore), OBJC_ASSOCIATION_ASSIGN);
        if (klg_canDragLoadMore) {
            Class footerClass = [self klg_refreshFooterClass] ?: [[self class] klg_defaultRefreshFooterClass];
            __weak __typeof(self) wSelf = self;
            self.mj_footer = [footerClass footerWithRefreshingBlock:^{
                __strong __typeof(wSelf) sSelf = wSelf;
                if (!sSelf) return;
                if (sSelf.mj_header && sSelf.mj_header.isRefreshing) {
                    [sSelf.mj_header endRefreshing];
                }
                if (sSelf.klg_dragAction) {
                    sSelf.klg_dragAction(YES);
                }
            }];
        } else {
            self.mj_footer = nil;
        }
    }
}

- (KLGDragAction)klg_dragAction {
    return objc_getAssociatedObject(self, &dragActionKey);
}

- (void)setKlg_dragAction:(KLGDragAction)klg_dragAction {
    objc_setAssociatedObject(self, &dragActionKey, klg_dragAction, OBJC_ASSOCIATION_COPY);
}

- (Class)klg_refreshHeaderClass {
    return objc_getAssociatedObject(self, &refreshHeaderClassKey);
}

- (void)setKlg_refreshHeaderClass:(Class)klg_refreshHeaderClass {
    objc_setAssociatedObject(self, &refreshHeaderClassKey, klg_refreshHeaderClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)klg_refreshFooterClass {
    return objc_getAssociatedObject(self, &refreshFooterClassKey);
}

- (void)setKlg_refreshFooterClass:(Class)klg_refreshFooterClass {
    objc_setAssociatedObject(self, &refreshFooterClassKey, klg_refreshFooterClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
