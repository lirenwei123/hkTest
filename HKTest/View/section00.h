//
//  section00.h
//  HKTest
//
//  Created by QianLong on 2017/9/14.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClick)();
@interface section00 : UIView
//
@property(nonatomic,strong)btnClick ZQ;
//
@property(nonatomic,strong) btnClick moreZQ;
+(instancetype)section00;
//-(void)reloadWithData

@end
