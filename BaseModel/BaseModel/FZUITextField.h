//
//  FZCommonUITextField.h
//  testDemo
//
//  Created by apple on 2017/1/9.
//  Copyright © 2017年 Fabius's Studio. All rights reserved.
//  Info:设置常用属性 自带 键盘显示,隐藏处理 自适应键盘高度

#import <UIKit/UIKit.h>

@interface FZUITextField : UITextField<UITextFieldDelegate>{
     UIViewController *_effectViewController;
}


#pragma mark 方法
//初始化
- (id)initWithFrame:(CGRect)frame effectObject:(id)effectObject;

@end
