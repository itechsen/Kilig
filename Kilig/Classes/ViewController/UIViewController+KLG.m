//
//  UIViewController+KLG.m
//  Kilig
//
//  Created by chenyusen on 2018/6/12.
//

#import "UIViewController+KLG.h"
#import <KLGTableView.h>
#import <objc/runtime.h>
#import "KLGMethodSwizzleTool.h"
#import "KLGTableViewControllerProtocol.h"
#import "KLGViewControllerProtocol.h"
#import <MJRefresh/MJRefresh.h>
#import "KLGUIConfig.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UITableView+KLGRefresh.h"
#import "KLGViewViewModelProtocol.h"

static char isViewAppearingKey;
static char hasViewAppeardKey;
static char viewModelKey;

static char tableViewKey;
static char loadingViewKey;



@interface UIViewController()

@property (nonatomic, strong) UITableView *klg_tableView;

@property (nonatomic, assign) UITableViewStyle klg_tableViewStyle;

@end


@implementation UIViewController (KLG)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        KLGSwizzleInstanceMethod([NSClassFromString(@"UIViewController") class],
                                 @selector(viewDidLoad),
                                 @selector(klg_viewDidLoad));
        
        KLGSwizzleInstanceMethod([NSClassFromString(@"UIViewController") class],
                                 @selector(viewWillAppear:),
                                 @selector(klg_viewWillAppear:));
        
        KLGSwizzleInstanceMethod([NSClassFromString(@"UIViewController") class],
                                 @selector(viewWillAppear:),
                                 @selector(klg_viewWillAppear:));
        
        KLGSwizzleInstanceMethod([NSClassFromString(@"UIViewController") class],
                                 @selector(viewWillDisappear:),
                                 @selector(klg_viewWillDisappear:));
        
        KLGSwizzleInstanceMethod([NSClassFromString(@"UIViewController") class],
                                 @selector(didReceiveMemoryWarning),
                                 @selector(klg_didReceiveMemoryWarning));
    });
}


#pragma mark - Swizzle

- (void)klg_viewDidLoad {
    [self klg_viewDidLoad];
    
    
    if ([self conformsToProtocol:@protocol(KLGTableViewControllerProtocol)]) {
        __weak __typeof(self) wSelf = self;
        self.klg_tableView.klg_dragAction = ^(BOOL forMore) {
            __strong __typeof(wSelf) sSelf = wSelf;
            if (!sSelf) return;
            if ([wSelf.klg_viewModel conformsToProtocol:@protocol(KLGViewViewModelProtocol)] &&
                [sSelf.klg_viewModel respondsToSelector:@selector(updateDataForMore:)]) {
//                [(id<KLGTableViewModelProtocol>)sSelf.klg_viewModel updateDataForMore:forMore];
            }
        };
    }
}

- (void)klg_viewWillAppear:(BOOL)animated {
    [self klg_viewWillAppear:animated];
    self.klg_isViewAppearing = YES;
    self.klg_hasViewAppeard = YES;
    if (!self.klg_viewModel) { // 如果当前视图控制器的viewModel为空, 则认为此视图控制器不是由kilig驱动
        [self klg_updateView];
    }
}

- (void)klg_viewWillDisappear:(BOOL)animated {
    [self klg_viewWillDisappear:animated];
    self.klg_hasViewAppeard = NO;
}

- (void)klg_didReceiveMemoryWarning {
    if (self.klg_hasViewAppeard && !self.klg_isViewAppearing) {
        [self klg_didReceiveMemoryWarning];
        self.klg_hasViewAppeard = NO;
    } else {
        [self klg_didReceiveMemoryWarning];
    }
}

#pragma mark - Private Methods

- (void)klg_updateView {
    
}

#pragma mark - KLGTableViewModelDelegateProtocol



#pragma mark - KLGViewControllerProtocol

- (void)klg_showLoading:(BOOL)show {
    [self _klg_showLoading:show];
}

#pragma mark - KLGPrivate
- (void)_klg_showLoading:(BOOL)show {
    if (show) {
        if (!self.klg_loadingView) {
            UIView *loadingView;
            if (KLGUIConfig.loadingViewClass) { // 判断是否已经设置了全局LoadingView类，如果有则采用
                loadingView = [[KLGUIConfig.loadingViewClass alloc] init];
                loadingView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
                loadingView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            } else {
                loadingView = [[MBProgressHUD alloc] initWithView:self.view];
                loadingView.userInteractionEnabled = YES;
            }
            self.klg_loadingView = loadingView;
            [self.view addSubview:loadingView];
        }
        
        [self.view bringSubviewToFront:self.klg_loadingView];
        if ([self.klg_loadingView isKindOfClass:[MBProgressHUD class]]) {
            [((MBProgressHUD *)self.klg_loadingView) showAnimated:YES];
        }
    } else {
        if ([self.klg_loadingView isKindOfClass:[MBProgressHUD class]]) {
            [((MBProgressHUD *)self.klg_loadingView) hideAnimated:NO];
        } else {
            [self.klg_loadingView removeFromSuperview];
//            self.klg_loadingView = nil;
        }
    }
}


#pragma mark - Getter && Setter
- (BOOL)klg_isViewAppearing {
    id result = objc_getAssociatedObject(self, &isViewAppearingKey);
    if (result) {
        return [result boolValue];
    } else {
        objc_setAssociatedObject(self, &isViewAppearingKey, @(NO), OBJC_ASSOCIATION_ASSIGN);
        return NO;
    }
}

- (void)setKlg_isViewAppearing:(BOOL)klg_isViewAppearing {
    objc_setAssociatedObject(self, &isViewAppearingKey, @(klg_isViewAppearing), OBJC_ASSOCIATION_ASSIGN);
}


- (BOOL)klg_hasViewAppeard {
    id result = objc_getAssociatedObject(self, &hasViewAppeardKey);
    if (result) {
        return [result boolValue];
    } else {
        objc_setAssociatedObject(self, &hasViewAppeardKey, @(NO), OBJC_ASSOCIATION_ASSIGN);
        return NO;
    }
}

- (void)setKlg_hasViewAppeard:(BOOL)klg_hasViewAppeard {
    objc_setAssociatedObject(self, &hasViewAppeardKey, @(klg_hasViewAppeard), OBJC_ASSOCIATION_ASSIGN);
}


- (id<KLGViewViewModelProtocol>)klg_viewModel {
    return objc_getAssociatedObject(self, &viewModelKey);
}

- (void)setKlg_viewModel:(id<KLGViewViewModelProtocol>)klg_viewModel {
    objc_setAssociatedObject(self, &viewModelKey, klg_viewModel, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)klg_loadingView {
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)setKlg_loadingView:(UIView *)klg_loadingView {
    objc_setAssociatedObject(self, &loadingViewKey, klg_loadingView, OBJC_ASSOCIATION_RETAIN);
}


@end


@implementation UIViewController (KLG_TableView)

- (UITableView *)klg_tableView {
    UITableView *tableView = objc_getAssociatedObject(self, &tableViewKey);
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.klg_tableViewStyle];
        objc_setAssociatedObject(self, &tableViewKey, tableView, OBJC_ASSOCIATION_RETAIN);
    }
    return tableView;
}

- (void)setKlg_tableView:(UITableView *)klg_tableView {
    objc_setAssociatedObject(self, &tableViewKey, klg_tableView, OBJC_ASSOCIATION_RETAIN);
}
@end
