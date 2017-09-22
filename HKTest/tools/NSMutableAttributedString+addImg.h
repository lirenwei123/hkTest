//
//  NSMutableAttributedString+addImg.h
//  HKTest
//
//  Created by QianLong on 2017/9/22.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (addImg)
-(instancetype)addImgWithName:(NSString *)imgName  andImgBounds:(CGRect)bounds;
@end
