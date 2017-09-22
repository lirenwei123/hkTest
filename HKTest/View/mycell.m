//
//  mycell.m
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//

#import "mycell.h"
#import "myCocell.h"
#import "qlCoellRightView.h"
#import "NSMutableAttributedString+addImg.h"



@interface mycell ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
//
@property(nonatomic,assign)BOOL drag;
//
@property(nonatomic,assign)NSIndexPath *selectPath;

@property (weak, nonatomic) IBOutlet UIView *leftView;

@end

@implementation mycell


+(instancetype)creatCell{
    return  [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self ) owner:nil options:nil].firstObject;
    //    UINib *nib =[UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
    //    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout1 =[[UICollectionViewFlowLayout alloc]init];
    
    layout1.itemSize=CGSizeMake(100, 50);
    
    layout1.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    layout1.minimumLineSpacing=0;
    layout1.minimumInteritemSpacing = 0;
    self.rightV.collectionViewLayout=layout1;
    self.rightV.showsVerticalScrollIndicator = NO;
    self.rightV.showsHorizontalScrollIndicator = NO;
    self.rightV.delegate=self;
    self.rightV.dataSource=self;
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftViewTouch)];
    [_leftView addGestureRecognizer:tap];
   //默认隐藏
    CGRect frame = self.extendV.frame;
    frame.size.height = 0;
    self.extendV.frame = frame;
    self.extendV.hidden = YES;
    _drag = NO;
    _cellType = CELLTYPE_JRDD;
   
    
    [self.rightV registerNib:[UINib nibWithNibName:NSStringFromClass([qlCoellRightView class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"co"];
    _leftSubView = [qlCellLeftView leftView];
    _leftSubView.frame = _leftView.bounds;
    [_leftView addSubview:_leftSubView];
  
    
    
}

-(void)setCellType:(CELLTYPE)cellType{
    _cellType = cellType;
    _extendV.extenViewType = cellType;
    if (_cellType == CELLTYPE_TITLEBAR) {
        
            [self.rightV registerNib:[UINib nibWithNibName:NSStringFromClass([myCocell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"co"];
        [_leftSubView removeFromSuperview];
        _leftSubView = nil;
        _leftLable = [[UILabel alloc]initWithFrame:_leftView.bounds];
        _leftLable.textAlignment = NSTextAlignmentCenter;
        _leftLable.font = [UIFont systemFontOfSize:13];
        [_leftView addSubview:_leftLable];
       

    }else if (_cellType == CELLTYPE_CC){
        [_leftSubView removeFromSuperview];
        _leftSubView = nil;
        _leftSubView = [qlCellLeftView leftNoImgView];
        _leftSubView.frame = _leftView.bounds;
        [_leftView addSubview:_leftSubView];

    }else if (_cellType == CELLTYPE_JRDD){
        [_leftSubView removeFromSuperview];
        _leftSubView = nil;
        _leftSubView = [qlCellLeftView leftNoImgView];
        _leftSubView.frame = _leftView.bounds;
        [_leftView addSubview:_leftSubView];
        
    }
}
-(void)leftViewTouch{
    if (_cellType != CELLTYPE_TITLEBAR) {
        if (_PDStruct.mycellDelegatePerform2) {
            [_delegate mycell:self DidSelectItemAtIndexPath:self.indexPath rightVindexPath:nil];
        }
    }else{
        if (_PDStruct.mycellDelegatePerform6) {
            [_delegate didSelectLeftitleBar:self];
        }
    }
}





#pragma mark --collection view代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_PDStruct.mycellDelegatePerform1) {
        return [_delegate rowsCountWithmycell:self];
    }else{
    return 10;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_cellType == CELLTYPE_TITLEBAR) {
        myCocell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"co" forIndexPath:indexPath];
        if (_PDStruct.mycellDelegatePerform) {
            NSMutableAttributedString *text =  [[NSMutableAttributedString alloc]initWithString: [_delegate titleWithmycell:self  rightVindexpath:indexPath]];
            cell.coLab.attributedText = [text addImgWithName:@"trangle2" andImgBounds:CGRectMake(0, 0, 5, 8)];
        }
        if (_PDStruct.mycellDelegatePerform4) {
            cell.coLab.backgroundColor = [_delegate mycellWithSetColabColr:self andCellIndexpath:self.indexPath];
            
        }
        if (indexPath.row == 0) {
            cell.coLab.textAlignment = NSTextAlignmentLeft;
        }
        return cell;
        
    }else{
        
        qlCoellRightView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"co" forIndexPath:indexPath];
        if (_PDStruct.mycellDelegatePerform) {
            cell.titleLab.text = [_delegate titleWithmycell:self  rightVindexpath:indexPath];
        }
        if (_PDStruct.mycellDelegatePerform5) {
            cell.subTitleLab.text = [_delegate subTitleWithmycell:self rightVindexpath:indexPath];
        }
        if (_PDStruct.mycellDelegatePerform4) {
            cell.titleLab.backgroundColor = [_delegate mycellWithSetColabColr:self andCellIndexpath:self.indexPath];
            cell.subTitleLab.backgroundColor = [_delegate mycellWithSetColabColr:self andCellIndexpath:self.indexPath];
        }
        if (indexPath.row == 0) {
            cell.titleLab.textAlignment = NSTextAlignmentLeft;
            cell.subTitleLab.textAlignment = NSTextAlignmentLeft;
        }
        return cell;
        
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_PDStruct.mycellDelegatePerform2) {
        [_delegate mycell:self DidSelectItemAtIndexPath:self.indexPath rightVindexPath:indexPath];
    }
    if (_selectPath == indexPath) {
       
    }else{
     
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _drag = YES;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _drag = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if (_PDStruct.mycellDelegatePerform3 && _drag ==YES ) {
            [_delegate mycellDidScrollWithContentOffsetX:scrollView.contentOffset.x];
        }
}

-(void)setDelegate:(id<mycellDelegate>)delegate{
    _delegate = delegate;
    if (_delegate) {
        _PDStruct.mycellDelegate = true;
        if ([_delegate respondsToSelector:@selector(titleWithmycell:rightVindexpath:)]) {
            _PDStruct.mycellDelegatePerform = true;
        }
        if ([_delegate respondsToSelector:@selector(rowsCountWithmycell:)]) {
            _PDStruct.mycellDelegatePerform1 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycell: DidSelectItemAtIndexPath: rightVindexPath:)]) {
            _PDStruct.mycellDelegatePerform2 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycellDidScrollWithContentOffsetX:)]) {
            _PDStruct.mycellDelegatePerform3 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycellWithSetColabColr: andCellIndexpath:)]) {
            _PDStruct.mycellDelegatePerform4 = true;
        }
        if ([_delegate respondsToSelector:@selector(subTitleWithmycell:rightVindexpath:)]) {
            _PDStruct.mycellDelegatePerform5 = true;
        }
        if ([_delegate respondsToSelector:@selector(didSelectLeftitleBar:)]) {
            _PDStruct.mycellDelegatePerform6 = true;
        }
             
    }
}



-(void)setTopHeight:(CGFloat)height{
    _leftView.frame = CGRectMake(0, 0, _leftView.bounds.size.width, height);
    if (_leftSubView) {
        _leftSubView.frame =  CGRectMake(0, 0, _leftView.bounds.size.width, height);
    }
    if (_leftLable) {
        _leftLable.frame = CGRectMake(0, 0, _leftView.bounds.size.width, height);
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
