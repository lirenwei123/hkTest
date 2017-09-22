//
//  ZiChanView.m
//  HKTest
//
//  Created by QianLong on 2017/9/19.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "ZiChanView.h"

@interface ZiChanView ()
//
@property(nonatomic,strong) void(^myTouchClick)(UIButton *btn) ;
//
@property(nonatomic,strong) UIImage *img;
//
@property(nonatomic,copy)NSAttributedString *title;
//
@property(nonatomic,strong) NSArray *dataArray;
//
@property(nonatomic,assign)int displayNum;
//
@property(nonatomic,assign) int startNum;

@end

@implementation ZiChanView


-(instancetype)initWithFrame:(CGRect)frame currencyImage:(UIImage *)img title:(NSAttributedString *)title andData:(NSArray*)dataArray displayDataCount:(int)count upDownBlock:(void(^)(UIButton *btn))upDownBlock{
    if (self == [super initWithFrame:frame]) {
        _myTouchClick = upDownBlock;
        _img = img;
        _title = title;
        _dataArray = dataArray;
        _displayNum = count;
        _startNum = count;
        [self setUIWithDispayDataCount:count];
          }
    return self;
}

-(void)upDownClick:(UIButton *)sender{
    
    if (_myTouchClick) {
        _myTouchClick(sender);
    }
}

-(void)setUIWithDispayDataCount:(int)count{

    UIImageView *imgv =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imgv.image = _img;
    [self addSubview:imgv];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, self.frame.size.width-35, 20)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.attributedText = _title;
    [self addSubview:titleLab];
    
    NSArray *nameArray = @[@"市值",@"现金",@"可用",@"可取",@"冻结",@"欠款"];
    if (_dataArray) {
        NSInteger num = _dataArray.count;
        CGFloat H = 20;
        CGFloat leftW = 50 ;
        CGFloat edege = 10;
        CGFloat rightW = self.frame.size.width - leftW-edege*3;
        CGFloat origeY = CGRectGetMaxY(titleLab.frame)+10;
        if (num>=0 && count<=num) {
            for (NSInteger i=0; i<count; i++) {
                UILabel *leftLab =[[UILabel alloc]initWithFrame:CGRectMake(edege, origeY , leftW, H)];
                leftLab.textAlignment = NSTextAlignmentLeft;
                leftLab.textColor =  [UIColor grayColor];
                [self addSubview:leftLab];
                
                UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLab.frame)+edege, origeY, rightW, H)];
                rightLab.textColor = [UIColor blackColor];
                rightLab.textAlignment = NSTextAlignmentRight;
                [self addSubview:rightLab];
                
                leftLab.text = nameArray[i];
                rightLab.text = [NSString stringWithFormat:@"%@",_dataArray[i]];
                rightLab.adjustsFontSizeToFitWidth = YES;
                
                origeY = CGRectGetMaxY(leftLab.frame)+edege;
            }
        }
        
        NSString *btnTitle = count<num?@"More":@"收起";
        UIButton *upDownBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        upDownBtn.frame = CGRectMake((self.frame.size.width-50)*0.5, origeY, 50, 20);
        [upDownBtn setTitle:btnTitle forState:UIControlStateNormal];
        [upDownBtn addTarget:self action:@selector(upDownClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:upDownBtn];
        
    }
    _seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-1, 10, 1, self.frame.size.height-20)];
    _seperateLine.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_seperateLine];

}

@end
