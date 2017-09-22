//
//  MyExtendView.m
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "MyExtendView.h"
#import "myBtn.h"
#define btnW  40
#define btnH   60
#define MARGIN  (self.frame.size.width-3*btnW)*0.25

@implementation MyExtendView


-(void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    if (hidden) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }else{
        if (_extenViewType == 1 || _extenViewType == 2) {
            if (_extenViewType == 1) {
                [self addJRDDExtendView];
            }else{
                [self addCCExtendView];
            }
        }
    }
}

-(void)addCCExtendView {
        for (int i=0; i<3; i++) {
            NSString *title = @"";
            switch (i) {
                case 0:
                    title = @"行情";
                    break;
                case 1:
                    title = @"买入";
                    break;
                case 2:
                    title = @"卖出";
                    break;
                default:
                    break;
            }
            
            __weak  typeof(self)  weakSelf = self;
            myBtn *btn =[[myBtn alloc]initWithFrame:CGRectMake(MARGIN+(MARGIN +btnW)*(i%3), (10+btnH)*(i/3), btnW, btnH) img:[UIImage imageNamed:@"1.jpg"] title:title touchEvent:^(myBtn *mybtn) {
                NSLog(@"----------%@:%@---%@",mybtn.lab.text,self.path,self.model);
                if (weakSelf.TouchBlock) {
                    weakSelf.TouchBlock(mybtn,weakSelf.model,weakSelf.path);
                }
                
            }andbtnType:1];
            
            [self addSubview:btn];
            
            
        }
}

-(void)addJRDDExtendView  {
        for (int i=0; i<3; i++) {
            NSString *title = @"";
            switch (i) {
                case 0:
                    title = @"行情";
                    break;
                case 1:
                    title = @"改单";
                    break;
                case 2:
                    title = @"撤单";
                    break;
                default:
                    break;
            }
             __weak  typeof(self)  weakSelf = self;
            myBtn *btn =[[myBtn alloc]initWithFrame:CGRectMake(MARGIN+(MARGIN +btnW)*(i%3), (10+btnH)*(i/3), btnW, btnH) img:[UIImage imageNamed:@"1.jpg"] title:title touchEvent:^(myBtn *mybtn) {
                NSLog(@"----------%@:%@---%@",mybtn.lab.text,self.path,self.model);
                if (weakSelf.TouchBlock) {
                    weakSelf.TouchBlock(mybtn,weakSelf.model,weakSelf.path);
                }
                
            }andbtnType:1];
            
            [self addSubview:btn];
        }
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, btnH+5, self.bounds.size.width, 2)];
    line.backgroundColor =  [UIColor lightGrayColor];
    [self addSubview:line];
    if (_jrddModels.count>0 ) {
        for (int i=0; i<_jrddModels.count; i++) {
            JRDDealdDetailView *v =[JRDDealdDetailView dealdDetailView];
            [v setFrame:CGRectMake(0,CGRectGetMaxY(line.frame)+5 +i*20, self.bounds.size.width, 20)];
            [v loadDataQWithModel:_jrddModels[i]];
            [self addSubview:v];
        }
    }
    
}



@end
