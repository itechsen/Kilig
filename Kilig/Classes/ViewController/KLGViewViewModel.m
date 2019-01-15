//
//  KLGViewViewModel.m
//  Kilig
//
//  Created by chenyusen on 2018/7/2.
//

#import "KLGViewViewModel.h"
#import "KLGPageProvider.h"

@interface KLGViewViewModel()
@property (nonatomic, assign, getter=isLoading) NSInteger loading;
@property (nonatomic, assign, getter=isLoaded) NSInteger loaded;
@property (nonatomic, strong) NSArray<id<KLGViewModelRequestProtocol>> *requests;
@property (nonatomic, weak) id<KLGViewViewModelDelegateProtocol> delegate;
@property (nonatomic, strong) KLGPageProvider *pageProvider;
@end

@implementation KLGViewViewModel {
    BOOL _isPaged;
}

- (instancetype)initWithRequests:(NSArray<id<KLGViewModelRequestProtocol>> *)requests
                        delegate:(id<KLGViewViewModelDelegateProtocol>)delegate {
    self = [super init];
    if (self) {
        _requests = requests;
        _delegate = delegate;
        _isPaged = NO;
        _loaded = NO;
        _loading = NO;
    }
    return self;
}


#pragma mark - KLGViewViewModelProtocol
- (void)updateDataForMore:(BOOL)forMore {
    if (_loading) {
        return;
    }
    _loading = YES;
    
    dispatch_group_t requestGroup = dispatch_group_create();
    
    for (id<KLGViewModelRequestProtocol> request in self.requests) {
        dispatch_group_enter(requestGroup);
        [request klg_asyncRequestWithSuccess:^(id data) {
            
            dispatch_group_enter(requestGroup);
        } failure:^(NSError *error) {
            
            dispatch_group_enter(requestGroup);
        }];
    }
    
    
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        
        
    });
}


#pragma mark - Getter && Setter

- (void)setIsPaged:(BOOL)isPaged {
    if (_isPaged != isPaged) {
        _isPaged = isPaged;
        if (isPaged) {
            _pageProvider = [[KLGPageProvider alloc] init];
        }
    }
}

- (BOOL)isPaged {
    return _isPaged;
}



@end

//
//@implementation KLGPagedViewViewModel
//
//
//@end
//
//@implementation KLGTableViewViewModel
//
//@end
