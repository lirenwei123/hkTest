//
//  section02.m
//  HKTest
//
//  Created by QianLong on 2017/9/14.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "section02.h"
#import "myBtn.h"


@interface section02    ()

//
@property(nonatomic,strong) NSMutableArray *imgs;
//
@property(nonatomic,strong) NSMutableArray *titles;
//
@property(nonatomic,strong) NSArray *erjiMenuIcons;

//
@property(nonatomic,strong)  UIScrollView *bgsc ;

//
@property(nonatomic,strong) myBtn *currentBtn;
@end

@implementation section02



-(instancetype)initWithFrame:(CGRect)frame  andMarketType:(MARKETTYPE)marketType buttonClick:(BTNClick)btnClick{
    if (self == [super initWithFrame:frame]) {
        _moreClick = btnClick;
        _imgs = @[].mutableCopy;
        _titles = @[].mutableCopy;
        if (marketType & MARKETTYPEHK) {
            [_imgs addObject:[UIImage imageNamed:@"hk.png"]];
            [_titles addObject:@"港股"];
        }
        if (marketType & MARKETTYPEUSA){
            [_imgs addObject:[UIImage imageNamed:@"American.png"]];
            [_titles addObject:@"美股"];
        }
        if (marketType & MARKETTYPEHGT){
            [_imgs addObject:[UIImage imageNamed:@"China.png"]];
            [_titles addObject:@"沪股通"];
        }
        if (marketType & MARKETTYPESGT){
            [_imgs addObject:[UIImage imageNamed:@"China.png"]];
            [_titles addObject:@"深股通"];
        }
        if (marketType & MARKETTYPEOTHER){
            [_imgs addObject:[UIImage imageNamed:@"China.png"]];
            [_titles addObject:@"深股通"];
        }

        
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    __weak typeof(self) weakSelf = self;
   CGFloat edge = 10;
    NSInteger marketCount =_titles.count;
    CGFloat w = 0;
    if (marketCount<5) {
        w =(self.frame.size.width-edge*(marketCount+1))/marketCount;
    }else{
        w =(self.frame.size.width-5*edge)*0.25;
    }
   
    if (marketCount>=5) {
        _bgsc =[[UIScrollView alloc]initWithFrame:self.bounds];
        _bgsc.scrollEnabled = NO;
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        moreBtn.frame =CGRectMake(self.frame.size.width-10, 20, 10, 10);
        [moreBtn setTitle:@"more" forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [_bgsc addSubview:moreBtn];
        UIButton *shouBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shouBtn.frame =CGRectMake(self.frame.size.width, 20, 10, 10);
        [shouBtn setTitle:@"收" forState:UIControlStateNormal];
        [shouBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [_bgsc addSubview:shouBtn];

        [self addSubview:_bgsc];
    }
    
    for (int i=0; i<marketCount; i++) {
        
        myBtn *btn =[[myBtn alloc]initWithFrame:CGRectMake(edge+i*(w+edge), 10, w, 30) img:_imgs[i] title:_titles[i] touchEvent:^(myBtn *btn) {
            if (_moreClick) {
                weakSelf.currentBtn.backgroundColor = [UIColor lightGrayColor];
                btn.backgroundColor = [UIColor whiteColor];
                _currentBtn = btn;
                _moreClick(btn);
            }
        } andbtnType:BTNTYPELR];
        btn.backgroundColor = i==0 ? [UIColor whiteColor] : [UIColor lightGrayColor];
        if (i == 0) {
            _currentBtn = btn;
        }
        btn.tag = 100+i;
        if (i>3) {
            CGRect rect = btn.frame;
            rect.origin.x +=10;
            btn.frame = rect;
        }
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.borderWidth = 1;
        if (marketCount>4 && _bgsc) {
            [_bgsc addSubview:btn];
        }else{
            [self addSubview:btn];
        }
    }

NSArray  *ErJititles =@[@"买入",@"卖出",@"委托明细",@"资金流水",@"更多"];
w = (self.frame.size.width-edge*8)*0.2;
UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(10, 50, self.frame.size.width-2*edge, 69)];
for (int i=0; i<5; i++) {
    myBtn *btn = [[myBtn alloc]initWithFrame:CGRectMake(edge+i*(w+edge), 0, w, 69) img:self.erjiMenuIcons[i] title:ErJititles[i] touchEvent:^(myBtn *btn) {
        if (_moreClick) {
            _moreClick(btn);
        }
           } andbtnType:BTNTYPEUD];
    btn.tag = 200+i;
    [bg addSubview:btn];
}
bg.layer.borderWidth = 1;
bg.layer.borderColor = [UIColor grayColor].CGColor;
[self addSubview:bg];

}


-(void)more{
    if (_bgsc) {
        if (_bgsc.contentOffset.x == 0) {
            [_bgsc setContentOffset:CGPointMake(_bgsc.bounds.size.width, 0)];
        }else{
            [_bgsc setContentOffset:CGPointMake(0, 0)];

        }
    }
}

-(NSArray *)erjiMenuIcons{
    if (!_erjiMenuIcons) {
        NSMutableArray *muarray = @[].mutableCopy;
        NSArray*icons = @[@"1.jpg",@"1.jpg",@"1.jpg",@"1.jpg",@"1.jpg"];
        for (int i=0; i<icons.count; i++) {
            UIImage *img = [UIImage imageNamed:icons[i]];
            if (img) {
                [muarray addObject:img];
            }
        }
        _erjiMenuIcons = muarray;
    }
    return _erjiMenuIcons;
}

@end
