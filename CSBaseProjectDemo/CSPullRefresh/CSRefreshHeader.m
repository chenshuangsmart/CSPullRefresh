//
//  CSRefreshHeader.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/13.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshHeader.h"

@interface CSRefreshHeader()

/** insert delta */
@property(nonatomic, assign)CGFloat insetTDelta;

@end

@implementation CSRefreshHeader

#pragma mark - 初始化构造方法

+ (instancetype)headerWithRefreshingBlock:(CSRefreshComponentRefreshingBlock)refreshingBlock {
    CSRefreshHeader *header = [[self alloc] initWithhRefreshingBlock:refreshingBlock];
    return header;
}

+ (instancetype)headerWithRefreshingTarget:(id)target action:(SEL)action {
    CSRefreshHeader *header = [[self alloc] initWithTarget:target action:action];
    return header;
}

@end
