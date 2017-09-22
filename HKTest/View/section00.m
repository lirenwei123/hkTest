//
//  section00.m
//  HKTest
//
//  Created by QianLong on 2017/9/14.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "section00.h"
#import "qlAlertView.h"

@interface section00 ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *ZQNameLable;
@property (weak, nonatomic) IBOutlet UILabel *totalZiChanLable;
@property (weak, nonatomic) IBOutlet UILabel *totalFDYK;
@property (weak, nonatomic) IBOutlet UILabel *totalFDYKrate;

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation section00

+(instancetype)section00{
    return [[NSBundle mainBundle]loadNibNamed:@"section0" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selcetZQ)];
    [_topView addGestureRecognizer:tap];
}

-(void)selcetZQ{
    if (_ZQ) {
        _ZQ();
    }
}

@end
