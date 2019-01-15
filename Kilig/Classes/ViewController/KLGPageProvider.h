//
//  KLGPageProvider.h
//  Kilig
//
//  Created by chenyusen on 2018/7/2.
//

#import <Foundation/Foundation.h>

@interface KLGPageProvider : NSObject

@property (nonatomic, assign) NSInteger startPage;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *pageName;
@property (nonatomic, copy) NSString *pageSizeName;

@end
