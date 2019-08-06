//
//  ZPBarrier.m
//  读写安全
//
//  Created by 赵鹏 on 2019/8/6.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ZPBarrier.h"

@interface ZPBarrier ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation ZPBarrier

- (instancetype)init
{
    if (self = [super init])
    {
        //初始化并发队列
        self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

#pragma mark ————— 读文件 —————
- (void)read
{
    dispatch_async(self.queue, ^{
        sleep(1);
        NSLog(@"%s", __func__);
    });
}

#pragma mark ————— 读文件 —————
- (void)write
{
    /**
     函数中传入的并发队列必须是自己通过dispatch_queue_cretate创建的；
     如果传入的是一个串行或是一个全局的并发队列，那这个函数便等同于dispatch_async函数的效果；
     栅栏函数的特性就是等上述子线程中的任务都执行完了以后才会执行栅栏函数内的任务了。
     */
    dispatch_barrier_async(self.queue, ^{
        sleep(1);
        NSLog(@"%s", __func__);
    });
}

@end
