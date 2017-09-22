//
//  mycell.h
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MyExtendView.h"
#import "qlCellLeftView.h"


typedef NS_ENUM(NSUInteger, CELLTYPE) {
    CELLTYPE_TITLEBAR,  //头部title样式
    CELLTYPE_JRDD,  //今日订单表格样式
    CELLTYPE_CC, //持仓样式
};


//typedef void (^cellBlock)(NSIndexPath* path);
@class mycell;
@protocol mycellDelegate <NSObject>
@required
-(NSString *)titleWithmycell:(mycell*)cell rightVindexpath:(NSIndexPath*)indexPath;
-(NSString *)subTitleWithmycell:(mycell*)cell rightVindexpath:(NSIndexPath*)indexPath;
-(NSInteger)rowsCountWithmycell:(mycell*)cell;
-(void)mycell:(mycell*)cell DidSelectItemAtIndexPath:(NSIndexPath*)indexPath  rightVindexPath:(NSIndexPath*)Rindexpath;
-(void)mycellDidScrollWithContentOffsetX:(CGFloat)Offsetx;
-(UIColor *)mycellWithSetColabColr:(mycell*)cell andCellIndexpath:(NSIndexPath*)path;
-(void)didSelectLeftitleBar:(mycell*)mycell ;

@end

typedef  struct delegateSelector{
    BOOL mycellDelegate;
    BOOL mycellDelegatePerform;
    BOOL mycellDelegatePerform1;
    BOOL mycellDelegatePerform2;
    BOOL mycellDelegatePerform3;
    BOOL mycellDelegatePerform4;
    BOOL mycellDelegatePerform5;
    BOOL mycellDelegatePerform6;
    
}delePD ;

@interface mycell : UITableViewCell





@property (weak, nonatomic) IBOutlet UICollectionView *rightV;
@property (weak, nonatomic) IBOutlet MyExtendView *extendV;



//
//
@property(nonatomic,assign)delePD PDStruct;
//
@property(nonatomic,weak) id <mycellDelegate>delegate;
//
@property(nonatomic,assign)NSIndexPath* indexPath;

//
@property(nonatomic,strong) qlCellLeftView *leftSubView ;
//
@property(nonatomic,strong) UILabel *leftLable;
//
@property(nonatomic,assign)CELLTYPE cellType;


+(instancetype)creatCell;

-(void)setTopHeight:(CGFloat)height;

    @end


