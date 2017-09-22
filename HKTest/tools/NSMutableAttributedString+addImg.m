//
//  NSMutableAttributedString+addImg.m
//  HKTest
//
//  Created by QianLong on 2017/9/22.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "NSMutableAttributedString+addImg.h"

@implementation NSMutableAttributedString (addImg)
-(instancetype)addImgWithName:(NSString *)imgName  andImgBounds:(CGRect)bounds{
    UIImage *img =  [UIImage imageNamed:imgName];
    if (!img) {
        return self;
    }
    NSTextAttachment *imgTach =  [[NSTextAttachment alloc]init];
    imgTach.image = img;
    imgTach.bounds = bounds;
    NSAttributedString *str =  [NSAttributedString attributedStringWithAttachment:imgTach];
     [self appendAttributedString:str];
    return self;
}



@end
