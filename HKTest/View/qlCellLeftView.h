//
//  qlCellLeftView.h
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface qlCellLeftView : UIView


@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


+(instancetype)leftView;
+(instancetype)leftNoImgView;

@end
