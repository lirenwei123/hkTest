//
//  ViewController.m
//  HKTest
//
//  Created by QianLong on 2017/9/6.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//
#define WHTIETHEME @"white"
#define BLACKTHEME @"black"

#import "HKTraderHomePageViewController.h"
#import "NSObject+YYBTheme.h"
#import "YYBThemeManager.h"
#import "section00.h"
#import "section01.h"
#import "section02.h"
#import "mycell.h"
#import "myCellModle.h"
#import "qlAlertView.h"
#import "myBtn.h"
#import "ZQsSelectMenu.h"
#import "JYSelectMedu.h"
#import "JRDDCountDetailView.h"
#import "NSMutableAttributedString+addImg.h"
#import <objc/runtime.h>
#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height

@interface HKTraderHomePageViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,mycellDelegate>
//总体表格
@property(nonatomic,strong) UITableView  *mainTab;
//表格头部视图上面的持仓/今日成交
@property(nonatomic,strong) UIView  *head;
//表格头部视图里下面的列表名称
@property(nonatomic,strong)mycell *headerV;
//持仓/今日持仓底部下划线
@property(nonatomic,strong) UIView *myLine;
//持仓表格内容模型
@property(nonatomic,strong) NSMutableArray <myCellModle*>*cellItemsCC;
//今日订单表格内容模型
@property(nonatomic,strong) NSMutableArray <myCellModle*>*cellItemsJRDD;
//表格头部模型
@property(nonatomic,strong) myCellModle * titleItemCC;
@property(nonatomic,strong) myCellModle * titleItemJRDD;
//当前选择的行
@property(nonatomic,assign)NSInteger currentSelectRow_CC;
@property(nonatomic,assign)NSInteger currentSelectRow_JRDD;
//记录上一次选择的行
@property(nonatomic,assign) NSInteger previosSelectRow_CC;
@property(nonatomic,assign) NSInteger previosSelectRow_JRDD;
//记录选中的状态
@property(nonatomic,assign)BOOL isSelected_CC;
@property(nonatomic,assign)BOOL isSelected_JRDD;
//数据表格右边的滚动视图偏移量
@property(nonatomic,assign)CGPoint initOffset;
//headerView
@property(nonatomic,strong) UIView * hv;
//
@property(nonatomic,strong) section00 *mySection00;
//
@property(nonatomic,strong) section01 *mySection01;
//
@property(nonatomic,strong) section02 *mySection02;
//
@property(nonatomic,assign)BOOL isTouch;

//
@property(nonatomic,strong) NSArray *zichanIcons;
//
@property(nonatomic,strong) NSArray *zichanTitles;
//

@property(nonatomic,strong) NSArray *zichanDatas;

//
@property(nonatomic,strong) NSMutableArray *zqModels;

//
@property(nonatomic,assign)CELLTYPE tableType;

@end

@implementation HKTraderHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _mainTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SW , SH-20) style:UITableViewStylePlain];
    _mainTab.delegate = self;
    _mainTab.dataSource =  self;
    _mainTab.bounces  = NO;
    _mainTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTab.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainTab];
    _previosSelectRow_CC = -1;
    _currentSelectRow_CC = -1;
    _previosSelectRow_JRDD = -1;
    _currentSelectRow_JRDD = -1;
    _tableType = CELLTYPE_CC;
    
}

-(void)aletWithtype:(NSInteger)type{
    __weak typeof(self) weakSelf = self;
    if (type == 0) {
     //顶部TITLE点击alert
        ZQsSelectMenu *v = [[ZQsSelectMenu alloc]initWithFrame:CGRectMake(0, 0, 300, 320)];
        [v addZqModels:self.zqModels selectEvent:^(ZQModel *model) {
            
        } addNewZQClick:^{
            
        }];
        
        qlAlertView *alert = [[qlAlertView alloc]initWithView:v andDefultButtonBlock:nil DefultButtontitle:nil andOtherButtonBlock:nil OtherButtontitle:nil];
        [self.view addSubview:alert];

    }else if (type == 1){
       //二级菜单更多按钮点击ALERT
        JYSelectMedu *v = [[JYSelectMedu alloc]initWithFrame:CGRectMake(0, 0, 300, 270) btnClick:^(myBtn *btn) {
            [weakSelf doSomeThingWithBtnClick:btn];
        }];
        qlAlertView *alert = [[qlAlertView alloc]initWithView:v andDefultButtonBlock:nil DefultButtontitle:nil andOtherButtonBlock:nil OtherButtontitle:nil];
        [self.view addSubview:alert];
    }else if (type == 2){
        
    }
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        if (_tableType == CELLTYPE_CC) {
            
            return self.cellItemsCC.count;
        }else if(_tableType == CELLTYPE_JRDD){
            return self.cellItemsJRDD.count;
        }
    }
    return 0;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 89;
                break;
            case 1:
                if (_isTouch ) {
                    return 260;
                }
                return 140;
                break;
            case 2:
                return 119;
                break;
                
            default:
                return 0;
                break;
        }
        
        
    }else{
        if (_tableType == CELLTYPE_CC) {
            if (indexPath.row == _currentSelectRow_CC &&_isSelected_CC ==YES) {
                return 120;
            }
        }else if (_tableType == CELLTYPE_JRDD){
            if (indexPath.row == _currentSelectRow_JRDD &&_isSelected_JRDD ==YES) {
                return 170;
            }
        }
        return 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        switch (indexPath.row) {
            case 0:
                if (!_mySection00) {
                    section00  *v = [section00 section00];
                    v.frame = CGRectMake(0, 0, SW, 89);
                    v.ZQ = ^{
                        [weakSelf aletWithtype:0];
                    };
                    v.moreZQ = ^{
                        [weakSelf aletWithtype:1];
                    };
                    _mySection00 = v;
                }
                [cell.contentView addSubview:_mySection00];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
                break;
            case 1:
                if (!_mySection01) {
                    section01 *v  = [[section01 alloc]initWithFrame:CGRectMake(0, 0, SW, 140) Icons:self.zichanIcons titles:self.zichanTitles andDatas:self.zichanDatas dispalyDataCount:2 andUpDownBtnClick:^{
                        weakSelf.isTouch = !weakSelf.isTouch;
                        [weakSelf.mainTab reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }];
                   _mySection01 = v;
                }
                if (_isTouch) {
                    _mySection01.frame = CGRectMake(0, 0, SW, 260);
                    [_mySection01  reloadDatasWithdisPlayDataCount:6];
                    
                }else{
                    _mySection01.frame = CGRectMake(0, 0, SW, 140);
                    [_mySection01  reloadDatasWithdisPlayDataCount:2];
                }
                [cell.contentView addSubview:_mySection01];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
                break;
            case 2:
                if (!_mySection02) {
                    section02  *v = [[section02 alloc]initWithFrame:CGRectMake(0, 0, SW, 119) andMarketType:MARKETTYPEHK|MARKETTYPEUSA|MARKETTYPEHGT|MARKETTYPESGT|MARKETTYPEOTHER buttonClick:^(myBtn *btn) {
                        [weakSelf doSomeThingWithBtnClick:btn];
                    }];
                _mySection02 = v;
                }
                [cell.contentView addSubview:_mySection02];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                break;
                
            default:
                return cell;
                break;
        }
    }else{
        mycell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell =[mycell creatCell];
            cell.cellType = self.tableType;
            [cell setTopHeight:48];
            
        }
        
        if (cell.cellType == CELLTYPE_CC) {
            myCellModle *cellItem = self.cellItemsCC[indexPath.row];
            cell.leftSubView.titleLable.text = cellItem.leftTitle;
            cell.leftSubView.subTitleLab.text = @"0539 HKD";
           

        }else if (cell.cellType == CELLTYPE_JRDD){
            myCellModle *cellItem = self.cellItemsJRDD[indexPath.row];
            cell.leftSubView.titleLable.text = cellItem.leftTitle;
            cell.leftSubView.subTitleLab.text = cellItem.leftSubTitle;
             cell.leftSubView.titleLable.textColor = [UIColor redColor];
             cell.leftSubView.subTitleLab.textColor = [UIColor redColor];
            cell.leftSubView.imgView.image = [UIImage imageNamed:@"hk"];
        }


        if ((indexPath.row == _currentSelectRow_CC&& _isSelected_CC == YES && _tableType == CELLTYPE_CC)||
            (indexPath.row == _currentSelectRow_JRDD&& _isSelected_JRDD == YES && _tableType == CELLTYPE_JRDD)) {
            //        cell.leftSubView.backgroundColor = [UIColor lightGrayColor];
            CGRect frame = cell.extendV.frame;
            frame.size.height = 70;
            cell.extendV.frame = frame;
            cell.extendV.path = indexPath;
            cell.extendV.model = _tableType== CELLTYPE_CC ? self.cellItemsCC[indexPath.row] : self.cellItemsJRDD[indexPath.row];
            [cell.extendV setTouchBlock:^(myBtn*btn,myCellModle*model,NSIndexPath*path){
                NSLog(@"----%@",btn.lab.text);
            }];
            if (_tableType == CELLTYPE_JRDD) {
                NSMutableArray *modelArray = @[].mutableCopy;
                for (int i=0; i<2; i++) {
                    JRDDModel *model = [[JRDDModel alloc]init];
                    model.timeString = @"14:15:59";
                    model.rateString = @"68%";
                    model.priceString = @"16.8";
                    model.countString =@"999";
                    [modelArray addObject:model];
                }
                cell.extendV.jrddModels = modelArray;
                CGRect frame = cell.extendV.frame;
                frame.size.height = 120;
                cell.extendV.frame = frame;
            }
            cell.extendV.hidden = NO;
            objc_setAssociatedObject(cell.extendV.hqUpDownBtn, @"key", self, OBJC_ASSOCIATION_RETAIN);
        }else{
            
            CGRect frame = cell.extendV.frame;
            frame.size.height = 0;
            cell.extendV.hidden = YES;
            cell.extendV.frame = frame;
            
    }
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.rightV.contentOffset = _initOffset;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
}
-(UIView *)tabvHeader{
    if (_hv) {
        return _hv;
    }
    _hv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 55)];
    _hv.backgroundColor = [UIColor whiteColor];
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 30)];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.tag = 100;
    btn1.frame = CGRectMake(0, 0, header.bounds.size.width*0.5, 30);
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 setTitle:@"持仓" forState:UIControlStateNormal];
    [header addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(header.bounds.size.width*0.5, 0, header.bounds.size.width*0.5, 30);
    [btn2 setTitle:@"今日订单" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    [header addSubview:btn2];
    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, header.bounds.size.height-2, header.bounds.size.width, 2)];
    line0.backgroundColor = [UIColor grayColor];
    [header addSubview:line0];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, header.bounds.size.height-3, header.bounds.size.width*0.5-40, 3)];
    line.backgroundColor = [UIColor redColor];
    [header addSubview:line];
    _myLine = line;
    [btn1 addTarget:self action:@selector(DoForLine:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(DoForLine:) forControlEvents:UIControlEventTouchUpInside];
    _head = header;
    [_hv addSubview:_head];
    
    _headerV = [mycell creatCell];
    _headerV.frame = CGRectMake(0, 30, SW, 25);
    _headerV.cellType = CELLTYPE_TITLEBAR;
    [_headerV setTopHeight:23];
    _headerV.delegate = self;
    if (_tableType == CELLTYPE_CC) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.titleItemCC.leftTitle];
        _headerV.leftLable.attributedText = [str addImgWithName:@"trangle2" andImgBounds:CGRectMake(0, 0, 5, 8)];
    }else if (_tableType == CELLTYPE_JRDD){
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.titleItemJRDD.leftTitle];
        _headerV.leftLable.attributedText = [str addImgWithName:@"trange" andImgBounds:CGRectMake(0, -5, 5, 5)];
    }
    [_hv addSubview:_headerV];
    
    return _hv;
}
-(void)reloadHeaderView{
    if (_tableType == CELLTYPE_CC) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.titleItemCC.leftTitle];
        _headerV.leftLable.attributedText = [str addImgWithName:@"trangle2" andImgBounds:CGRectMake(0, 0, 5, 8)];
    }else if (_tableType == CELLTYPE_JRDD){
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.titleItemJRDD.leftTitle];
        _headerV.leftLable.attributedText = [str addImgWithName:@"trange" andImgBounds:CGRectMake(0, -5, 5, 5)];
    }
    [_headerV.rightV reloadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return [self tabvHeader];
    }
    return nil;
}
-(void)DoForLine:(UIButton *)sender{
    if (sender.tag == 100) {
        [UIView animateWithDuration:0.1 animations:^{
            _myLine.frame = CGRectMake(20, _head.frame.size.height-3, _head.frame.size.width*0.5-40, 3);
        }];
        _tableType = CELLTYPE_CC;
        [_mainTab reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            _myLine.frame = CGRectMake(_head.frame.size.width*0.5+20, _head.frame.size.height-3, _head.frame.size.width*0.5-40, 3);
        }];
        _tableType = CELLTYPE_JRDD;
        [_mainTab reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self reloadHeaderView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 55;
    }else{
        return 0;
    }
}


#pragma mark-- mycellDelegate
-(NSString *)titleWithmycell:(mycell *)cell rightVindexpath:(NSIndexPath *)indexPath {
    if (cell== _headerV) {
        return   _tableType == CELLTYPE_CC ? self.titleItemCC.rightTitles[indexPath.row]:self.titleItemJRDD.rightTitles[indexPath.row] ;
    }else{
        if (cell.cellType == CELLTYPE_CC) {
            myCellModle *cellItem = self.cellItemsCC[cell.indexPath.row];
            return  cellItem.rightTitles[indexPath.row];
        }else if (cell.cellType == CELLTYPE_JRDD){
            myCellModle *cellItem = self.cellItemsJRDD[cell.indexPath.row];
            return  cellItem.rightTitles[indexPath.row];

        }
    }
    return @" ";
}
-(NSString *)subTitleWithmycell:(mycell *)cell rightVindexpath:(NSIndexPath *)indexPath{
    
    if (cell.cellType == CELLTYPE_CC) {
        myCellModle *cellItem = self.cellItemsCC[cell.indexPath.row];
        return  cellItem.subRightTitles[indexPath.row];
    }else if (cell.cellType == CELLTYPE_JRDD){
        myCellModle *cellItem = self.cellItemsJRDD[cell.indexPath.row];
        return  cellItem.subRightTitles[indexPath.row];
        
    }
    return @"";
}
-(NSInteger)rowsCountWithmycell:(mycell *)cell{
    myCellModle *m = nil;
    if (cell == _headerV) {
        m = _tableType == CELLTYPE_CC ? _titleItemCC : _titleItemJRDD;
    }else if(cell.cellType == CELLTYPE_CC){
        m = self.cellItemsCC[cell.indexPath.row];
    }else if (cell.cellType == CELLTYPE_JRDD){
        m = self.cellItemsJRDD[cell.indexPath.row];
    }
    return m.rightTitles.count;
}
-(void)mycell:(mycell*)cell DidSelectItemAtIndexPath:(NSIndexPath *)indexPath rightVindexPath:(NSIndexPath *)Rindexpath{
    //如果Rindexpath为nil，可可能是点击的cell最左边视图
    
    if (cell == _headerV) {
        //做排序处理
        if (_tableType== CELLTYPE_CC) {
            _isSelected_CC = NO;
        }else if (_tableType == CELLTYPE_JRDD){
            _isSelected_JRDD = NO;
        }
        // 这时indexPath为nil，但是Rindexpath知道是点击的哪个列，就可以根据列点击响应事件
        NSLog(@"你当前点击的是第----列%ld",Rindexpath.row+1);
        [self setTabOffset:_initOffset];
    }else{
        
        [self setViewModelWithIndexPath:indexPath andRindexPath:Rindexpath];
    }
    
}

-(void)didSelectLeftitleBar:(mycell *)mycell{
    if (_tableType == CELLTYPE_JRDD) {
        JRDDCountDetailView * countView = [JRDDCountDetailView creatView];
        [countView setFrame:CGRectMake(10, CGRectGetMaxY(_hv.frame)+10, 100, 150)];
        [countView setALLcount:4 ALLclick:^{
            NSLog(@"显示全部订单");
        } YCJcount:3 YCJclick:^{
              NSLog(@"显示已成交订单");
        } DCJcount:2 DCJclick:^{
              NSLog(@"显示待成交订单");
        } YCDcount:1 YCDclick:^{
              NSLog(@"显示已撤单订单");
        }];
        [self .view addSubview:countView];
    }
}

-(void)setViewModelWithIndexPath:(NSIndexPath*)indexpath  andRindexPath:( NSIndexPath* _Nullable )RindexPath{
    if (_tableType == CELLTYPE_CC) {
        if (_currentSelectRow_CC !=indexpath.row ) {
            _previosSelectRow_CC = _currentSelectRow_CC;
            _currentSelectRow_CC  = indexpath.row;
            _isSelected_CC = YES;
        }else{
            _isSelected_CC = !_isSelected_CC;
        }
        if (_previosSelectRow_CC>-1) {
            NSIndexPath *p = [NSIndexPath indexPathForRow:_previosSelectRow_CC inSection:1];
            [self.mainTab reloadRowsAtIndexPaths:@[p] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }else if (_tableType == CELLTYPE_JRDD){
        if (_currentSelectRow_JRDD !=indexpath.row ) {
            _previosSelectRow_JRDD = _currentSelectRow_JRDD;
            _currentSelectRow_JRDD  = indexpath.row;
            _isSelected_JRDD = YES;
        }else{
            _isSelected_JRDD = !_isSelected_JRDD;
        }
        if (_previosSelectRow_JRDD>-1) {
            NSIndexPath *p = [NSIndexPath indexPathForRow:_previosSelectRow_CC inSection:1];
            [self.mainTab reloadRowsAtIndexPaths:@[p] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
   
    [self.mainTab reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self setTabOffset:_initOffset];
}

-(void)mycellDidScrollWithContentOffsetX:(CGFloat)Offsetx{
    _initOffset = CGPointMake(Offsetx, 0);
    [self setTabOffset:_initOffset];
}
-(void)setTabOffset:(CGPoint)offset{
    for (mycell * cell in self.mainTab.visibleCells) {
        if ([cell isKindOfClass:[mycell class]]) {
            cell.rightV.contentOffset = offset;
        }
    }
    _headerV.rightV.contentOffset = offset;
}
-(UIColor *)mycellWithSetColabColr:(mycell *)cell andCellIndexpath:(NSIndexPath *)path{
//    if (cell == _headerV) {
//        return [UIColor whiteColor];
//    }
//    if (path.row == _currentSelectRow&&_isSelected == YES) {
//        return [UIColor lightGrayColor];
//    }
    return [UIColor whiteColor];
}
//-(void)labTouch:(mycell*)cell{
//    if (cell == _headerV) {
//        _isSelected = NO;
//        _titleItem.leftTitle = @"名称";
//        _cellItems = nil;
//        
//    }else{
//        [self setViewModelWithIndexPath:cell.indexPath andRindexPath:nil];
//    }
//}


#pragma mark --scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (mycell * cell in self.mainTab.visibleCells) {
        if ([cell isKindOfClass:[mycell class]]) {
            cell.rightV.contentOffset = _initOffset;
        }
    }
    
}


-(BOOL)prefersStatusBarHidden{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


#pragma mark -- datas/models

-(NSArray *)zichanIcons{
    if (!_zichanIcons) {
        NSArray *imgNames =@[@"hk.png",@"American.png",@"China.png"];
        NSMutableArray *imgs = @[].mutableCopy;
        for (int i=0; i<imgNames.count; i++) {
            UIImage *img = [UIImage imageNamed:imgNames[i]];
            if (img) {
                [imgs addObject:img];
            }
        }
        _zichanIcons = imgs;
        
        
    }
    return _zichanIcons;
}
-(NSArray *)zichanTitles{
    if (!_zichanTitles) {
        NSAttributedString *hk = [[NSAttributedString alloc]initWithString:@"港币资产HKD"];
        NSAttributedString *mg = [[NSAttributedString alloc]initWithString:@"美元资产USD"];
        NSAttributedString *zg = [[NSAttributedString alloc]initWithString:@"人民币资产RMB"];
        _zichanTitles = @[hk,mg,zg];
    }
    return _zichanTitles;
}

-(NSArray *)zichanDatas{
    if (!_zichanDatas) {
        _zichanDatas =@[ @[@17866778,@75866778,@25625760,@25612311,@464616,@43136513],@[@17866778,@75866778,@25625760,@25612311,@464616,@43136513],@[@17866778,@75866778,@25625760,@25612311,@464616,@43136513]];
        
        
    }
    return _zichanDatas;
}

-(NSMutableArray *)zqModels{
    if (!_zqModels) {
        NSMutableArray *models =@[].mutableCopy;
        for (int i=0; i<3; i++) {
            ZQModel *model = [[ZQModel alloc]init];
            switch (i) {
                case 0:
                    model.ZQIcon = [UIImage imageNamed:@"hk.png"];
                    model.ZQName =@"国元证券";
                    model.ZQAcount = @"1061121";
                    break;
                case 1:
                    model.ZQIcon = [UIImage imageNamed:@"American.png"];
                    model.ZQName =@"广发证券";
                    model.ZQAcount = @"1061121";
                    break;
                case 2:
                    model.ZQIcon = [UIImage imageNamed:@"China.png"];
                    model.ZQName =@"中信证券";
                    model.ZQAcount = @"1061121";
                    break;
                default:
                    break;
            }
            [models addObject:model];
        }
        _zqModels = models;
    }
    return _zqModels;
}
-(NSMutableArray<myCellModle *> *)cellItemsCC{
    if (!_cellItemsCC) {
        _cellItemsCC = @[].mutableCopy;
        for (int i=0; i<20; i++) {
            myCellModle *model = [[myCellModle alloc]init];
            model.leftTitle = [NSString stringWithFormat:@"腾讯控股"];
            model.leftSubTitle = @"0539 HKD";
            [model.rightTitles addObject:@"235,000"];
            [model.subRightTitles addObject:@"0001"];
            [model.rightTitles addObject:@"282.2"];
            [model.subRightTitles addObject:@"0002"];
            [model.rightTitles addObject:@"+352,000"];
            [model.subRightTitles addObject:@"0003"];
            [model.rightTitles addObject:@"+352,000"];
            [model.subRightTitles addObject:@"0004"];
            [model.rightTitles addObject:@"+352,000"];
            [model.subRightTitles addObject:@"0005"];
            [_cellItemsCC addObject:model];
        }
    }
    return _cellItemsCC;
}

-(NSMutableArray<myCellModle *> *)cellItemsJRDD{
    if (!_cellItemsJRDD) {
        _cellItemsJRDD = @[].mutableCopy;
        for (int i=0; i<20; i++) {
            myCellModle *model = [[myCellModle alloc]init];
            model.leftTitle = [NSString stringWithFormat:@"卖出"];
            model.leftSubTitle = @"部分成交";
            [model.rightTitles addObject:@"腾讯控股"];
            [model.subRightTitles addObject:@"0539 HKD"];
            [model.rightTitles addObject:@"腾讯控股"];
            [model.subRightTitles addObject:@"0539 HKD"];
            [model.rightTitles addObject:@"腾讯控股"];
            [model.subRightTitles addObject:@"0539 HKD"];
            [model.rightTitles addObject:@"腾讯控股"];
            [model.subRightTitles addObject:@"0539 HKD"];
            [model.rightTitles addObject:@"腾讯控股"];
            [model.subRightTitles addObject:@"0539 HKD"];
            [_cellItemsJRDD addObject:model];
        }
    }
    return _cellItemsJRDD;
}


-(myCellModle *)titleItemJRDD{
    if (!_titleItemJRDD) {
        _titleItemJRDD = [[myCellModle alloc]init];
        _titleItemJRDD.leftTitle =  @"全部(27)";
        [_titleItemJRDD.rightTitles addObject:@"名称代码"];
        [_titleItemJRDD.rightTitles addObject:@"委托价/现价"];
        [_titleItemJRDD.rightTitles addObject:@"数量/已成"];
        [_titleItemJRDD.rightTitles addObject:@"数量/已成"];
        [_titleItemJRDD.rightTitles addObject:@"数量/已成"];
    }
    return _titleItemJRDD;
}

-(myCellModle *)titleItemCC{
    if (!_titleItemCC) {
        _titleItemCC = [[myCellModle alloc]init];
        _titleItemCC.leftTitle =  @"持仓证券";
        [_titleItemCC.rightTitles addObject:@"市值/数量"];
        [_titleItemCC.rightTitles addObject:@"现价／成本"];
        [_titleItemCC.rightTitles addObject:@"持仓盈亏"];
        [_titleItemCC.rightTitles addObject:@"持仓盈亏"];
        [_titleItemCC.rightTitles addObject:@"持仓盈亏"];
    }
    return _titleItemCC;
}

#pragma mark-- 按钮点击事件

-(void)doSomeThingWithBtnClick:(myBtn*)btn{
    if (btn.tag == 100) {
        //港股市场切换
    }else if (btn.tag == 101){
        //美股市场切换
    }else if (btn.tag == 102){
        //沪股通市场切换
    }else if (btn.tag == 103){
         //深股通市场切换
    }else if (btn.tag == 104){
        //other
    }
    
    
    if (btn.tag == 200) {
        //买入
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 201){
        //卖出
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 202){
        //委托明细
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 203){
        //资金流水
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 204){
        //更多
        [self aletWithtype:1];
    }else if (btn.tag == 300){
        //撤单改单
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 301){
        //成交明细
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 302){
        //成交合并
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 303){
        //股票往来
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 304){
        //新股申购
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (btn.tag == 305){
        //银证转账
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor =
        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:vc animated:YES completion:nil];
    }
}
//点击行情按钮上的展开图标后展开行情走势
-(void)zhankaiHQ:(myBtn *)btn{
   CGPoint p = btn.frame.origin;
    CGPoint needPoint = [btn.superview convertPoint:p toView:_mainTab];
    UIView *hq = [[UIView alloc]initWithFrame:CGRectMake(0, needPoint.y-200, self.view.bounds.size.width, 200)];
    hq.backgroundColor = [UIColor grayColor];
    [_mainTab addSubview:hq];
    hq.tag = 99;
    
    //如果在顶部被遮住处理
    p = hq.frame.origin;
    needPoint = [_mainTab convertPoint:p toView:self.view];
    if (needPoint.y<20) {
        CGPoint curentoffset = _mainTab.contentOffset;
            [_mainTab setContentOffset:CGPointMake(0, curentoffset.y- 22+needPoint.y) animated:YES];
    }
    _mainTab.scrollEnabled = NO;
}
//点击行情按钮上的收起图标后收起行情走势
-(void)shouqiHQ{
    UIView *hq =[_mainTab viewWithTag:99];
    [hq removeFromSuperview];
    _mainTab.scrollEnabled = YES;
}

@end
