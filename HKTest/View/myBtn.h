//
//  myBtn.h
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myBtn;
typedef void(^T)(myBtn *btn);
typedef NS_ENUM(NSUInteger, BTNTYPE) {
    BTNTYPELR,
    BTNTYPEUD,
    BTNTYPETEXT,
    BTNTYPEIMG,
    BTNTYPEOTHER //这是为二级菜单btn样式
};

@interface myBtn : UIView
//
@property(nonatomic,strong) T touchEvent;
//
@property(nonatomic,strong) UIImageView *imgv;
//
@property(nonatomic,strong) UILabel *lab;
-(instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img title:(NSString*)title touchEvent:(T)event andbtnType:(BTNTYPE)type;

@end
