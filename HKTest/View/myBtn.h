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
    BTNTYPHQ,
    BTNTYPEOTHER //这是为二级菜单btn样式
};

typedef NS_ENUM(NSUInteger, BTNCONTOLSTATE) {
    BTNCONTOLNORMAL,
    BTNCONTOLDISABLE,
    BTNCONTOLOTHER,
};



 //代理定义。  处理点击行情上方^v按钮展示行情趋势的事件
@protocol updownDelegate <NSObject>
@optional
-(void)doSomethingWithHQup; //需要传cellmodel;
-(void)doSomethingWithHQdown;

@end

@interface myBtn : UIView
//
@property(nonatomic,strong) T touchEvent;

//
@property(nonatomic,strong) UIImageView *imgv;
//
@property(nonatomic,strong) UILabel *lab;


-(instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img title:(NSString*)title touchEvent:(T)event andbtnType:(BTNTYPE)type;

-(instancetype)initWithFrame:(CGRect)frame normalImg:(UIImage *)img1 disableImg:(UIImage *)img2 title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type;

@property(nonatomic,assign)BTNCONTOLSTATE btnState;
@end
