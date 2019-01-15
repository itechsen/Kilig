//
//  UITableViewCell+KLG.m
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import "UITableViewCell+KLG.h"
#import <objc/runtime.h>
#import "KLGMethodSwizzleTool.h"

static char tableViewCellItemKey;
static char tableViewCellContentBackgroundColorKey;

@implementation UITableViewCell (KLG)

+ (void)load {
    KLGSwizzleInstanceMethod([NSClassFromString(@"UITableViewCell") class],
                             @selector(prepareForReuse),
                             @selector(klg_prepareForReuse));
    
    KLGSwizzleInstanceMethod([NSClassFromString(@"UITableViewCell") class],
                             @selector(setSelected:animated:),
                             @selector(klg_setSelected:animated:));
}

+ (BOOL)klg_shouldAppendCellItemToReuseIdentifier {
    return NO;
}

- (BOOL)klg_updateCellItem:(id<KLGTableViewCellItem>)cellItem {
    if (!self.klg_cellItem || ![[self class] klg_shouldAppendCellItemToReuseIdentifier]) {
        self.klg_cellItem = cellItem;
        if ([cellItem respondsToSelector:@selector(setCurrentCell:)]) {
            cellItem.currentCell = self;
        }
        return YES;
    } else {
        return NO;
    }
}

- (void)klg_prepareForReuse {
    if (![[self class] klg_shouldAppendCellItemToReuseIdentifier]) {
        if ([self.klg_cellItem respondsToSelector:@selector(currentCell)] && self.klg_cellItem.currentCell == self) {
            if ([self.klg_cellItem respondsToSelector:@selector(setCurrentCell:)]) {
                self.klg_cellItem.currentCell = nil;
            }
        }
        self.klg_cellItem = nil;
    }
    [self klg_prepareForReuse];
}

- (void)klg_setSelected:(BOOL)selected animated:(BOOL)animated {
    [self klg_setSelected:selected animated:animated];
    if ([self.klg_cellItem respondsToSelector:@selector(highlightColor)] && !![self.klg_cellItem highlightColor]) {
        if (!self.selectedBackgroundView ||
            [self.selectedBackgroundView isKindOfClass:NSClassFromString(@"UITableViewCellSelectedBackground")]) {
            
            
            self.selectedBackgroundView = [[UIView alloc] init];
        }
        self.selectedBackgroundView.backgroundColor = [self.klg_cellItem highlightColor];
    }
}

#pragma mark - getter && setter
- (UIColor *)klg_contentBackgroundColor {
    return objc_getAssociatedObject(self, &tableViewCellContentBackgroundColorKey);
}

- (void)setKlg_contentBackgroundColor:(UIColor *)contentBackgroundColor {
    
    UIColor *color = contentBackgroundColor;
    if (!color) {
        color = [UIColor whiteColor];
    }
    objc_setAssociatedObject(self, &tableViewCellContentBackgroundColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<KLGTableViewCellItem>)klg_cellItem {
    return objc_getAssociatedObject(self, &tableViewCellItemKey);
}

- (void)setKlg_cellItem:(id<KLGTableViewCellItem>)klg_cellItem {
    if ([klg_cellItem respondsToSelector:@selector(staticCell)] && !!klg_cellItem.staticCell) { // 防止循环引用
        objc_setAssociatedObject(self, &tableViewCellItemKey, klg_cellItem, OBJC_ASSOCIATION_ASSIGN);
    } else {
        objc_setAssociatedObject(self, &tableViewCellItemKey, klg_cellItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

@end
