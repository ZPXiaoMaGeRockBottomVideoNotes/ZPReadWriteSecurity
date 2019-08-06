//
//  ViewController.m
//  读写安全
//
//  Created by 赵鹏 on 2019/8/6.
//  Copyright © 2019 赵鹏. All rights reserved.
//

/**
 在程序运行的过程中，不允许同一时刻有既有线程读文件，又有线程写文件，这就牵扯到了读写安全的问题了；
 为了提高程序的执行效率，可以允许多条线程同时读一个文件，因为读文件不会改变文件的内容；
 同一时间只能有一条线程来写文件，因为写文件会改变文件的内容；
 
 基于上述的几点，iOS中的读写安全原则如下：
 1、同一时间，只能有1个线程进行写的操作；
 2、同一时间，允许有多个线程进行读的操作；
 3、同一时间，不允许既有写的操作，又有读的操作。
 上面的场景就是典型的“多读单写”，经常用于文件等数据的读写操作，iOS中的实现方案有：
 1、pthread_rwlock：读写锁；
 2、dispatch_barrier_async：异步栅栏调用。
 */

#import "ViewController.h"
#import "ZPRWlock.h"

@interface ViewController ()

@property (nonatomic, assign) pthread_rwlock_t lock;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //读写锁
//    [self rwlockTest];
    
    //异步栅栏调用
    [self barrierTest];
}

#pragma mark ————— 读写锁 —————
- (void)rwlockTest
{
    ZPRWlock *rwlock = [[ZPRWlock alloc] init];
    
    //获取全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(queue, ^{
            [rwlock read];
        });
        
        dispatch_async(queue, ^{
            [rwlock write];
        });
    }
}

#pragma mark ————— 异步栅栏调用 —————
- (void)barrierTest
{
    ZPRWlock *rwlock = [[ZPRWlock alloc] init];
    
    for (int i = 0; i < 10; i++)
    {
        [rwlock read];
        [rwlock write];
    }
}

@end
