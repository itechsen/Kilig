//
//  KLGViewViewModel.h
//  Kilig
//
//  Created by chenyusen on 2018/7/2.
//

#import <Foundation/Foundation.h>
#import "KLGViewViewModelProtocol.h"


@interface KLGViewViewModel : NSObject<KLGViewViewModelProtocol>

@property (nonatomic, assign) BOOL needCahce;

- (instancetype)initWithRequests:(NSArray<id<KLGViewModelRequestProtocol>> *)requests
                        delegate:(id<KLGViewViewModelDelegateProtocol>)delegate;
@end

//@interface KLGPagedViewViewModel: KLGViewViewModel<KLGPagedViewViewModelProtocol>
//
//@end
//
//
//@interface KLGTableViewViewModel: KLGPagedViewViewModel<KLGTableViewViewModelProtocol>
//
//@end
