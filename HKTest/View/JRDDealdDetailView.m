//
//  JRDDealdDetailView.m
//  HKTest
//
//  Created by QianLong on 2017/9/22.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "JRDDealdDetailView.h"
@interface JRDDealdDetailView()

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *rateLable;

@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *coubtLable;

@end


@implementation JRDDealdDetailView

+(instancetype)dealdDetailView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

-(void)loadDataQWithModel:(JRDDModel *)data{
    _timeLable.text =  data.timeString;
    _rateLable.text = [NSString stringWithFormat:@"部分成交%@",data.rateString];
    _priceLable.text = [NSString stringWithFormat:@"成交价：%@",data.priceString];
    _coubtLable.text = [NSString stringWithFormat:@"量：%@",data.countString];
    
}

@end
