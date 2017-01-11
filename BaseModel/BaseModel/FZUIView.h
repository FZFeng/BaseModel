//
//  CustomCommonUIView.h
//  testDemo
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 Fabius's Studio. All rights reserved.
//  Info:服务于CustomCommonUIView的数据集

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FZUIViewUIEelmentType) {
    FZUIViewUIEelmentTypeUILabel,
    FZUIViewUIEelmentTypeUIButton,
    FZUIViewUIEelmentTypeUITextField,
    FZUIViewUIEelmentTypeUIView,
    FZUIViewUIEelmentTypeUIImageView
};


@interface FZUIViewElementData : NSObject

//控件的类型 UILabel,UIButton
@property (nonatomic)FZUIViewUIEelmentType fzUIViewElementDataType;
//控件的宽度 0 为自由宽度 非0 为固定宽度
@property (nonatomic)CGFloat fzUIViewElementDataWidth;
//控件的高度 默认为0
@property (nonatomic)CGFloat fzUIViewElementDataHeight;
//控件的text
@property (nonatomic,strong)NSString *fzUIViewElementDataText;
//控件的bg ImageName
@property (nonatomic,strong)NSString *fzUIViewElementDataImageName;
//控件字体大小
@property (nonatomic)UIFont *fzUIViewElementDataFont;
//控件字体颜色
@property (nonatomic)UIColor *fzUIViewElementDataTextColor;
//控件背景颜色
@property (nonatomic)UIColor *fzUIViewElementDataBgColor;
//是否密码显示
@property (nonatomic)BOOL fzUIViewElementDataSecureTextEntry;
//UITextField 是否执行 passConTextChange 事件
@property (nonatomic)BOOL fzUIViewElementDataUseTextFieldPassEvent;
//placeholder值
@property (nonatomic,strong)NSString *fzUIViewElementDataPlaceholder;
//控件字体对齐方式
@property (nonatomic)NSTextAlignment fzUIViewElementDataTextAlignment;
//button 的accessibilityIdentifier属性 可用于保存一临时数据
@property (nonatomic,strong)NSString *fzUIViewElementDataAccessibilityIdentifier;
//button 的accessibilityLabel属性 可用于保存一临时数据
@property (nonatomic,strong)NSString *fzUIViewElementDatAaccessibilityLabel;


//初始化对象
- (id)initWithUIEelementDataType:(FZUIViewUIEelmentType)uiElementDataType;

- (id)initWithUIEelementDataType:(FZUIViewUIEelmentType)uiElementDataType uiElementDataWidth:(float)uiElementDataWidth;

- (id)initWithUIEelementDataType:(FZUIViewUIEelmentType)uiElementDataType uiElementDataWidth:(float)uiElementDataWidth uiElementDataHeight:(CGFloat)uiElementDataHeight;

@end

//
//  CustomCommonUIView.h
//  testDemo
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 Fabius's Studio. All rights reserved.
//  Info:自定义UIView 用于构建UI

@protocol FZUIViewDelegate

- (void)FZUIViewDelegateUIButtonTouchUpInsideEvent:(id)sender buttonObject:(UIButton*)buttonObject;

@optional
//UITextfield的 passConTextChange(在textfiled 输入或删除字符触发 ) delegate
- (void)FZUIViewDelegateUITextfieldPassConTextChangeEvent:(id)sender currentTextField:(UITextField*)currentTextField;

@end

@interface FZUIView : UIView<UITextFieldDelegate>{
    UIViewController *_effectViewController;
}


#pragma mark 属性
//leading    左边距 默认0.0
@property (nonatomic) CGFloat leading;
//Trailing   右边距 默认0.0
@property (nonatomic) CGFloat trailing;
//viewTag    默认0 view 中控件的定位 都以此viewTag 为起点 
@property (nonatomic) NSInteger viewTag;
//delegate
@property (nonatomic,weak) id<FZUIViewDelegate>delegate;
#pragma mark 方法
//初始化
- (id)initWithFrame:(CGRect)frame effectObject:(id)effectObject;
//构建UI
- (void)buildViewUIElement:(NSArray*)elementArray;
//构建UI 平均控件的width 和 间距
- (void)buildViewAverageUIElement:(NSArray*)elementArray  uiElementWidth:(CGFloat)uiElementWidth;

@end
