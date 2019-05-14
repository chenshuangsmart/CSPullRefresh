//
//  CSRefreshStateHeader.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/14.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshStateHeader.h"

@interface CSRefreshStateHeader()

/** state title */
@property(nonatomic, strong)NSMutableDictionary *stateTitleJson;

@end

@implementation CSRefreshStateHeader {
    /** 显示上一次刷新时间的lbe */
    __weak UILabel *_lastUpdatedTimeLbe;
    /** 显示刷新状态的lbe */
    __weak UILabel *_stateLbe;
}

#pragma mark - 状态相关

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck
    
    // 设置状态颜色
    self.stateLbe.text = self.stateTitleJson[@(state)];
    
    // 重新设置 key 重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}

- (void)setTitle:(NSString *)title forState:(CSRefreshState)state {
    if (title == nil || title.length == 0) {
        return;
    }
    self.stateTitleJson[@(state)] = title;
    self.stateLbe.text = self.stateTitleJson[@(self.state)];
}

#pragma mark - key 的处理

- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey {
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLbe.isHidden) {
        return;
    }
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有 block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLbe.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        // 获取年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @"HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) {    // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 显示日期
        self.lastUpdatedTimeLbe.text = [NSString stringWithFormat:@"%@%@%@",@"Last updated:",isToday ? @"Today" : @"",time];
    } else {
        self.lastUpdatedTimeLbe.text = [NSString stringWithFormat:@"%@%@",@"Last updated:",@"No record"];
    }
}

#pragma mark - private

///日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark - lazy

- (NSMutableDictionary *)stateTitleJson {
    if (_stateTitleJson == nil) {
        _stateTitleJson = [NSMutableDictionary dictionary];
    }
    return _stateTitleJson;
}

- (UILabel *)stateLbe {
    if (_stateLbe == nil) {
        UILabel *stateLbe = [[UILabel alloc] init];
        stateLbe.font = CSRefreshLabelFont;
        stateLbe.textColor = CSRefreshLabelTextColor;
        stateLbe.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        stateLbe.textAlignment = NSTextAlignmentCenter;
        stateLbe.backgroundColor = [UIColor clearColor];
        [self addSubview:_stateLbe = stateLbe];
    }
    return _stateLbe;
}

- (UILabel *)lastUpdatedTimeLbe {
    if (_lastUpdatedTimeLbe == nil) {
        UILabel *stateLbe = [[UILabel alloc] init];
        stateLbe.font = CSRefreshLabelFont;
        stateLbe.textColor = CSRefreshLabelTextColor;
        stateLbe.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        stateLbe.textAlignment = NSTextAlignmentCenter;
        stateLbe.backgroundColor = [UIColor clearColor];
        [self addSubview:_lastUpdatedTimeLbe = stateLbe];
    }
    return _lastUpdatedTimeLbe;
}

@end
