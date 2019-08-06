//
//  ZPRWlock.m
//  读写安全
//
//  Created by 赵鹏 on 2019/8/6.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ZPRWlock.h"
#import <pthread.h>

@interface ZPRWlock ()

@property (nonatomic, assign) pthread_rwlock_t lock;

@end

@implementation ZPRWlock

- (instancetype)init
{
    if (self = [super init])
    {
        //初始化锁
        pthread_rwlock_init(&_lock, NULL);
    }
    
    return self;
}

#pragma mark ————— 读文件 —————
- (void)read
{
    /**
     加锁：
     "pthread_rwlock_rdlock"函数专门用于读操作。
     */
    pthread_rwlock_rdlock(&_lock);
    
    sleep(1);
    NSLog(@"%s", __func__);
    
    //解锁
    pthread_rwlock_unlock(&_lock);
}

#pragma mark ————— 写文件 —————
- (void)write
{
    /**
     加锁：
     "pthread_rwlock_wrlock"函数专门用于写操作。
     */
    pthread_rwlock_wrlock(&_lock);
    
    sleep(1);
    NSLog(@"%s", __func__);
    
    //解锁
    pthread_rwlock_unlock(&_lock);
}

- (void)dealloc
{
    //销毁锁
    pthread_rwlock_destroy(&_lock);
}

@end
