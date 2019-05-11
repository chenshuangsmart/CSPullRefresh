//
//  NewsHandler.h
//  MVC-Demo
//
//  Created by chenshuang on 2019/4/16.
//  Copyright © 2019年 cs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 数据工具类
@interface NewsHandler : NSObject

+ (instancetype)shareInstance;

/** icon */
@property(nonatomic, strong)NSArray *icons;
/** imgs */
@property(nonatomic, strong)NSArray *imgs;
/** title*/
@property(nonatomic,strong)NSArray *contents;
/** titles*/
@property(nonatomic,strong)NSArray *titles;
/** sub title*/
@property(nonatomic,strong)NSArray *subTitles;
/** links */
@property(nonatomic, strong)NSArray *links;
/** specials */
@property(nonatomic, strong)NSArray *specialWords;

@end

NS_ASSUME_NONNULL_END
