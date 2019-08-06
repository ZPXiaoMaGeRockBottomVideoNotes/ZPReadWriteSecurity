//
//  ZPBarrier.h
//  读写安全
//
//  Created by 赵鹏 on 2019/8/6.
//  Copyright © 2019 赵鹏. All rights reserved.
//

//本类主要介绍如何使用dispatch_barrier_async（异步栅栏调用）。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBarrier : NSObject

- (void)read;
- (void)write;

@end

NS_ASSUME_NONNULL_END
