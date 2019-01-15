//
//  UITableView+KLG.m
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import "UITableView+KLG.h"
#import <objc/runtime.h>
#import "KLGTableViewModel.h"
#import "KLGTableViewAction.h"

static char tableViewModelKey;
static char tableViewActionKey;
static char tableViewEditTypeKey;


@implementation UITableView (KLG)

#pragma mark - Setter && Getter


- (KLGTableViewModel *)klg_tableViewModel {
    KLGTableViewModel *model = objc_getAssociatedObject(self, &tableViewModelKey);
    if (!self.dataSource && !model) {
        model = [[KLGTableViewModel alloc] init];
        objc_setAssociatedObject(self, &tableViewModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (!self.dataSource) {
            self.dataSource = model;
            if (!objc_getAssociatedObject(self, &tableViewActionKey)) {
                KLGTableViewAction *action = [[KLGTableViewAction alloc] initWithTableViewModel:model];
                action.tableView = self;
                objc_setAssociatedObject(self, &tableViewActionKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                if (!self.delegate) {
                    self.delegate = action;
                }
            }
        }
    }
    return model;
}

- (void)setKlg_tableViewModel:(KLGTableViewModel *)klg_tableViewModel {
    if (objc_getAssociatedObject(self, &tableViewModelKey) != klg_tableViewModel) {
        objc_setAssociatedObject(self, &tableViewModelKey, klg_tableViewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self klg_tableViewAction].tableViewModel = klg_tableViewModel;
        self.dataSource = klg_tableViewModel;
    }
}

- (KLGTableViewAction *)klg_tableViewAction {
    KLGTableViewAction *action = objc_getAssociatedObject(self, &tableViewActionKey);
    if (!self.delegate && !action) {
        KLGTableViewModel *model = objc_getAssociatedObject(self, &tableViewModelKey);
        if (!model) { // 发现model还没创建， 先去创建
            model = [[KLGTableViewModel alloc] init];
            objc_setAssociatedObject(self, &tableViewModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            if (!self.dataSource) {
                self.dataSource = model;
            }
        }
        action = [[KLGTableViewAction alloc] initWithTableViewModel:model];
        action.tableView = self;
        objc_setAssociatedObject(self, &tableViewActionKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = action;
    }
    return action;
}

- (KLGTableViewEditType)klg_editType {
    return [objc_getAssociatedObject(self, &tableViewEditTypeKey) integerValue];
}

- (void)setKlg_editType:(KLGTableViewEditType)klg_editType {
    objc_setAssociatedObject(self, &tableViewEditTypeKey, @(klg_editType), OBJC_ASSOCIATION_ASSIGN);
}

@end
