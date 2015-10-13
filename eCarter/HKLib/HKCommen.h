//
//  HKCommen.h
//  GSAPP
//
//  Created by kinsuft173 on 15/6/6.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "global.h"

#define SERVER    @"http://api.kswiki.net/kswiki/api/v2"     //@"http://192.168.1.23/kswiki/api"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@interface HKCommen : NSObject


//正则验证
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validatePassword:(NSString *)passWord;
+ (BOOL)validateNickname:(NSString *)nickname;
+ (BOOL)validateMobileWithPhoneNumber:(NSString*)strPhoneNumber;
+ (BOOL)validateCarNo:(NSString*)carNo;
+ (BOOL)validateSixNumber:(NSString*)carNo;

//隐藏多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView;
//控制器的标题
+ (void)addHeadTitle: (NSString*)string whichNavigation:(UINavigationItem*)item;

//简易的颜色获取
+ (UIColor*)getColor:(NSString *)hexColor;
+ (UIColor*)getColor:(NSString *)hexColor WithAlpha:(CGFloat)alpha;

//json转成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//提醒
+ (void)addAlertViewWithTitel:(NSString*)titel;

+ (BOOL)isTime1:(NSString*)time1 BigThanTime2:(NSString*)time2;

+ (CGFloat)compulateTheHightOfLabelWithWidth:(CGFloat)width WithContent:(NSString*)string WithFontSize:(NSInteger)size;

@end
