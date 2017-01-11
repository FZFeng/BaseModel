#import "FZUIView.h"

#define KKeyBoardShow             @"keyBoardShow"
#define KSwitchKeyBoard           @"switchKeyBoard"
#define KMaxTextFieldOriginY      @"maxTextFieldOriginY"
#define KGapDistance              5.0

@implementation FZUIViewElementData

#pragma mark 初始化默认属性值
- (id)initWithUIEelementDataType:(FZUIViewUIEelmentType)uiElementDataType{
    self=[super init];
    if (self) {
        [self initDefaultValue];
        self.fzUIViewElementDataType=uiElementDataType;
    }
    return self;
}

- (id)initWithUIEelementDataType:(FZUIViewUIEelmentType)uiElementDataType uiElementDataWidth:(float)uiElementDataWidth{
    self=[super init];
    if (self) {
        [self initDefaultValue];
        self.fzUIViewElementDataType=uiElementDataType;
        self.fzUIViewElementDataWidth=uiElementDataWidth;
    }
    return self;
}


- (id)initWithUIEelementDataType:(FZUIViewUIEelmentType)uiElementDataType uiElementDataWidth:(float)uiElementDataWidth uiElementDataHeight:(CGFloat)uiElementDataHeight{
    if (self) {
        [self initDefaultValue];
        self.fzUIViewElementDataType=uiElementDataType;
        self.fzUIViewElementDataWidth=uiElementDataWidth;
        self.fzUIViewElementDataHeight=uiElementDataHeight;
    }
    return self;
}

- (void)initDefaultValue{
    self.fzUIViewElementDataWidth=0.0;
    self.fzUIViewElementDataImageName=@"";
    self.fzUIViewElementDataHeight=0.0;
    self.fzUIViewElementDataText=@"";
    self.fzUIViewElementDataFont=[UIFont systemFontOfSize:16.0];
    self.fzUIViewElementDataTextColor=[UIColor darkGrayColor];
    self.fzUIViewElementDataBgColor=[UIColor clearColor];
    self.fzUIViewElementDataSecureTextEntry=NO;
    self.fzUIViewElementDataUseTextFieldPassEvent=NO;
    self.fzUIViewElementDataPlaceholder=@"";
    self.fzUIViewElementDataTextAlignment=NSTextAlignmentCenter;
    self.fzUIViewElementDataAccessibilityIdentifier=@"";
    self.fzUIViewElementDatAaccessibilityLabel=@"";
}


@end

@implementation FZUIView

#pragma mark 初始化默认值
- (id)initWithFrame:(CGRect)frame effectObject:(id)effectObject{
    self = [super initWithFrame:frame];
    if (self) {
        self.leading=0.0;
        self.trailing=0.0;
        self.viewTag=0;
        self.delegate=effectObject;
        _effectViewController=(UIViewController*)effectObject;
        
        //标记键盘处于关闭状态
        NSUserDefaults *currentUserDefaults=[[NSUserDefaults alloc] init];
        [currentUserDefaults setBool:NO forKey:KKeyBoardShow];
        [currentUserDefaults setBool:NO forKey:KSwitchKeyBoard];
    }
    return self;
}

#pragma mark 构建UI
//初始化UI
- (void)buildViewUIElement:(NSArray*)elementArray{
    
    if (!elementArray || elementArray.count==0) {
        return;
    }
    
    float selfWidth=CGRectGetWidth(self.frame);  //view的宽度
    float selfHeight=CGRectGetHeight(self.frame);//view的高度
    float unFixUIWidth=0.0;                      //非固定ui的宽度
    float fixUITotalWidth=0.0;                   //固定ui的总宽度
    float currentOriginX=self.leading;
    float currentOriginY=0.0;
    
    
    for (FZUIViewElementData *currentData in elementArray) {
        fixUITotalWidth=fixUITotalWidth+currentData.fzUIViewElementDataWidth;
    }
    unFixUIWidth=selfWidth-fixUITotalWidth-self.leading-self.trailing;
    
    for (int i=0; i<=elementArray.count-1; i++) {
        FZUIViewElementData *currentElementData=[elementArray objectAtIndex:i];
        float currentUIWidth=currentElementData.fzUIViewElementDataWidth;
        float currentUIHeight=currentElementData.fzUIViewElementDataHeight;
        
        if (currentUIWidth==0.0) {
            currentUIWidth=unFixUIWidth;
        }
        
        if (currentUIHeight==0.0) {
            currentUIHeight=selfHeight;
        }
        currentOriginY=(selfHeight-currentUIHeight)/2.0;
        
        
        switch (currentElementData.fzUIViewElementDataType) {
            case FZUIViewUIEelmentTypeUILabel:{
                //UILabel
                UILabel *objectUI=[[UILabel alloc] init];

                objectUI.frame=CGRectMake(currentOriginX, currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.text=currentElementData.fzUIViewElementDataText;
                objectUI.font=currentElementData.fzUIViewElementDataFont;
                objectUI.textColor=currentElementData.fzUIViewElementDataTextColor;
                objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;
                objectUI.textAlignment=currentElementData.fzUIViewElementDataTextAlignment;
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }
                [self addSubview:objectUI];
                break;
            }case FZUIViewUIEelmentTypeUITextField:{
                //UITextField
                UITextField *objectUI=[[UITextField alloc] init];
                
                objectUI.frame=CGRectMake(currentOriginX, currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.text=currentElementData.fzUIViewElementDataText;
                objectUI.textColor=currentElementData.fzUIViewElementDataTextColor;
                objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;;
                objectUI.font=currentElementData.fzUIViewElementDataFont;
                objectUI.secureTextEntry=currentElementData.fzUIViewElementDataSecureTextEntry;
                objectUI.placeholder=currentElementData.fzUIViewElementDataPlaceholder;
                objectUI.clearButtonMode=UITextFieldViewModeWhileEditing;
                objectUI.accessibilityLabel=@"";//默认设置已属性,因为键盘的显示与隐藏会用到此属性
                if (currentElementData.fzUIViewElementDataUseTextFieldPassEvent) {
                    [objectUI addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
                }
                objectUI.delegate=self;
                [self addSubview:objectUI];
                
                break;
            }case FZUIViewUIEelmentTypeUIButton:{
                //UIButton
                UIButton *objectUI=[[UIButton alloc] init];
                NSString *imageNameString=currentElementData.fzUIViewElementDataImageName;
                
                objectUI.frame=CGRectMake(currentOriginX,currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.titleLabel.font=currentElementData.fzUIViewElementDataFont;
                objectUI.accessibilityIdentifier=currentElementData.fzUIViewElementDataAccessibilityIdentifier;
                objectUI.accessibilityLabel=currentElementData.fzUIViewElementDatAaccessibilityLabel;
                [objectUI setTitle:currentElementData.fzUIViewElementDataText forState:UIControlStateNormal];
                [objectUI setTitleColor:currentElementData.fzUIViewElementDataTextColor forState:UIControlStateNormal];
                //bg
                if (![imageNameString isEqualToString:@""]) {
                    [objectUI setImage:[UIImage imageNamed:imageNameString] forState:UIControlStateNormal];
                }else{
                    objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;
                }
                //event
                [objectUI addTarget:self action:@selector(didUIButtonTouchUpInsideEvent:) forControlEvents:UIControlEventTouchUpInside];
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }

                [self addSubview:objectUI];
                
                break;
            }case FZUIViewUIEelmentTypeUIView:{
                //UIView
                UIView *objectUI=[[UIView alloc] init];
                
                objectUI.frame=CGRectMake(currentOriginX,currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }

                [self addSubview:objectUI];

                break;
            }case FZUIViewUIEelmentTypeUIImageView:{
                //UIImageView
                UIImageView *objectUI=[[UIImageView alloc] init];
                NSString *imageNameString=currentElementData.fzUIViewElementDataImageName;
                
                objectUI.frame=CGRectMake(currentOriginX,currentOriginY, currentUIWidth, currentUIHeight);
                if (![imageNameString isEqualToString:@""]) {
                    objectUI.image=[UIImage imageNamed:imageNameString];
                }
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }
               
                [self addSubview:objectUI];

                break;
            }
        }
        currentOriginX=currentOriginX+currentUIWidth;
    }
}

//初始化UI 是否平均控件的width 和 间距
- (void)buildViewAverageUIElement:(NSArray*)elementArray  uiElementWidth:(CGFloat)uiElementWidth{
    
    if (!elementArray || elementArray.count==0) {
        return;
    }
    
    float selfWidth=CGRectGetWidth(self.frame);  //view的宽度
    float selfHeight=CGRectGetHeight(self.frame);//view的高度
    //控件的间距
    float uiDistance=(selfWidth-uiElementWidth*elementArray.count)/(elementArray.count+1);
    float currentOriginX=0.0;
    float currentOriginY=0.0;
    float currentUIWidth=uiElementWidth;
    
    for (int i=0; i<=elementArray.count-1; i++) {
        FZUIViewElementData *currentElementData=[elementArray objectAtIndex:i];
        float currentUIHeight=currentElementData.fzUIViewElementDataHeight;
        
        currentOriginX=uiDistance*(i+1)+currentUIWidth*i;
        
        if (currentUIHeight==0.0) {
            currentUIHeight=selfHeight;
        }
        currentOriginY=(selfHeight-currentUIHeight)/2.0;
        
        switch (currentElementData.fzUIViewElementDataType) {
            case FZUIViewUIEelmentTypeUILabel:{
                //UILabel
                UILabel *objectUI=[[UILabel alloc] init];
                
                objectUI.frame=CGRectMake(currentOriginX, currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.text=currentElementData.fzUIViewElementDataText;
                objectUI.font=currentElementData.fzUIViewElementDataFont;
                objectUI.textColor=currentElementData.fzUIViewElementDataTextColor;
                objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;
                objectUI.textAlignment=currentElementData.fzUIViewElementDataTextAlignment;
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }
                [self addSubview:objectUI];
                break;
            }case FZUIViewUIEelmentTypeUITextField:{
                //UITextField
                UITextField *objectUI=[[UITextField alloc] init];
                
                objectUI.frame=CGRectMake(currentOriginX, currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.text=currentElementData.fzUIViewElementDataText;
                objectUI.textColor=currentElementData.fzUIViewElementDataTextColor;
                objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;;
                objectUI.font=currentElementData.fzUIViewElementDataFont;
                objectUI.secureTextEntry=currentElementData.fzUIViewElementDataSecureTextEntry;
                objectUI.placeholder=currentElementData.fzUIViewElementDataPlaceholder;
                objectUI.clearButtonMode=UITextFieldViewModeWhileEditing;
                objectUI.accessibilityLabel=@"";//默认设置已属性,因为键盘的显示与隐藏会用到此属性
                if (currentElementData.fzUIViewElementDataUseTextFieldPassEvent) {
                    [objectUI addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
                }
                objectUI.delegate=self;
                [self addSubview:objectUI];
                
                break;
            }case FZUIViewUIEelmentTypeUIButton:{
                //UIButton
                UIButton *objectUI=[[UIButton alloc] init];
                NSString *imageNameString=currentElementData.fzUIViewElementDataImageName;
                
                objectUI.frame=CGRectMake(currentOriginX,currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.titleLabel.font=currentElementData.fzUIViewElementDataFont;
                objectUI.accessibilityIdentifier=currentElementData.fzUIViewElementDataAccessibilityIdentifier;
                objectUI.accessibilityLabel=currentElementData.fzUIViewElementDatAaccessibilityLabel;
                [objectUI setTitle:currentElementData.fzUIViewElementDataText forState:UIControlStateNormal];
                [objectUI setTitleColor:currentElementData.fzUIViewElementDataTextColor forState:UIControlStateNormal];
                //bg
                if (![imageNameString isEqualToString:@""]) {
                    [objectUI setImage:[UIImage imageNamed:imageNameString] forState:UIControlStateNormal];
                }else{
                    objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;
                }
                //event
                [objectUI addTarget:self action:@selector(didUIButtonTouchUpInsideEvent:) forControlEvents:UIControlEventTouchUpInside];
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }
                [self addSubview:objectUI];
                
                break;
            }case FZUIViewUIEelmentTypeUIView:{
                //UIView
                UIView *objectUI=[[UIView alloc] init];
                
                objectUI.frame=CGRectMake(currentOriginX,currentOriginY, currentUIWidth, currentUIHeight);
                objectUI.backgroundColor=currentElementData.fzUIViewElementDataBgColor;
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }
                
                [self addSubview:objectUI];
                
                break;
            }case FZUIViewUIEelmentTypeUIImageView:{
                //UIImageView
                UIImageView *objectUI=[[UIImageView alloc] init];
                NSString *imageNameString=currentElementData.fzUIViewElementDataImageName;
                
                objectUI.frame=CGRectMake(currentOriginX,currentOriginY, currentUIWidth, currentUIHeight);
                if (![imageNameString isEqualToString:@""]) {
                    objectUI.image=[UIImage imageNamed:imageNameString];
                }
                if (self.viewTag>0) {
                    objectUI.tag=self.viewTag+i;
                }
                
                [self addSubview:objectUI];
                
                break;
            }
        }
        
    }

}

#pragma mark 处理delegate
//处理UIButton 事件
- (void)didUIButtonTouchUpInsideEvent:(id)sender{
    [self.delegate FZUIViewDelegateUIButtonTouchUpInsideEvent:self buttonObject:(UIButton*)sender ];
}
//处理UITextfiled 事件
- (void)passConTextChange:(id)sender{
    [self.delegate FZUIViewDelegateUITextfieldPassConTextChangeEvent:self currentTextField:sender];
}

#pragma mark UITextfield delegate
//textField 开始编辑时触发
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSUserDefaults *currentUserDefaults=[[NSUserDefaults alloc] init];
    BOOL keyBoardShow=[currentUserDefaults boolForKey:KKeyBoardShow];
    

    if (keyBoardShow) {
        [currentUserDefaults setBool:YES forKey:KSwitchKeyBoard];
        CGFloat maxTextFieldOriginY=[currentUserDefaults floatForKey:KMaxTextFieldOriginY];
        CGFloat currentTextFieldOriginY=self.superview.frame.origin.y+self.frame.origin.y+CGRectGetHeight(self.frame)+KGapDistance;
        
        if (currentTextFieldOriginY<=maxTextFieldOriginY) {
            return YES;
        }else{
            [currentUserDefaults setFloat:currentTextFieldOriginY forKey:KMaxTextFieldOriginY];
        }
    }

    // 如果是因为 结束输入操作,在失去焦点时触发 textFieldDidEndEditing 的 直接 隐藏键盘 并退出
    if ([textField.accessibilityLabel isEqualToString:@"textFieldDidEndEditing"] ) {
        textField.accessibilityLabel=@"";
        return [textField resignFirstResponder];
    }
    
    //显示键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:textFieldObject:) name:UIKeyboardWillShowNotification object:nil];
    return YES;
}

//按弹出键盘中的return时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //隐藏键盘
    [self keyBoardHide];
    
    textField.accessibilityLabel=@"textFieldShouldReturn";
    return textField.resignFirstResponder;
}

//结束输入操作(在失去焦点时会触发) 调用 textFieldShouldReturn方法后会调用; 切换到另一个 uitextfield时 也会调用
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSUserDefaults *currentUserDefaults=[[NSUserDefaults alloc] init];
    BOOL keyBoardShow=[currentUserDefaults boolForKey:KKeyBoardShow];
    BOOL switchKeyBoard=[currentUserDefaults boolForKey:KSwitchKeyBoard];

    
    //切换到另一个 uitextfield时
    if (keyBoardShow && switchKeyBoard) {
        [currentUserDefaults setBool:NO forKey:KSwitchKeyBoard];;
        return ;
    }
    
    //调用 textFieldShouldReturn 方法后再调用的就直接退出 因为 textFieldShouldReturn 方法已经处理了 隐藏键盘的功能
    if ([textField.accessibilityLabel isEqualToString:@"textFieldShouldReturn"]) {
        textField.accessibilityLabel=@"";
        return;
    }
   
    //隐藏键盘
    [self keyBoardHide];
    
    textField.accessibilityLabel=@"textFieldDidEndEditing";
    [textField resignFirstResponder];
}

//显示键盘
- (void)keyBoardWillShow:(NSNotification *)note textFieldObject:(UITextField*)textFieldObject{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KKeyBoardShow];
    
    NSDictionary *userInfo = [note userInfo];
    NSValue *value = [userInfo objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    //键盘高度
    CGFloat keyboardHeight = value.CGRectValue.size.height;
    //键盘显示动画时长
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //键盘显示动画方式
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        
        CGFloat width =CGRectGetWidth(_effectViewController.view.frame);
        CGFloat height =CGRectGetHeight(_effectViewController.view.frame);
        
        CGFloat currentTextFieldOriginY=self.superview.frame.origin.y+self.frame.origin.y+CGRectGetHeight(self.frame)+KGapDistance;
        [[NSUserDefaults standardUserDefaults] setFloat:currentTextFieldOriginY  forKey:KMaxTextFieldOriginY];
        
        //提升的高度 多加KGapDistance 的距离
        CGFloat liftingDistance=(height-keyboardHeight)-currentTextFieldOriginY;
        
        if (liftingDistance>0.0) {
            liftingDistance=0.0;
        }
        
        CGRect rect=CGRectMake(0.0,liftingDistance,width,height);
        _effectViewController.view.frame=rect;
        
        [self layoutIfNeeded];
        
        //去除Observ功能
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }];
}


//隐藏键盘
- (void)keyBoardHide{
    
    NSUserDefaults *currentUserDefaults=[[NSUserDefaults alloc] init];
    [currentUserDefaults removeObjectForKey:KKeyBoardShow];
    [currentUserDefaults removeObjectForKey:KSwitchKeyBoard];
    [currentUserDefaults removeObjectForKey:KMaxTextFieldOriginY];
    
    CGFloat width =CGRectGetWidth(_effectViewController.view.frame);
    CGFloat height =CGRectGetHeight(_effectViewController.view.frame);
    
    CGRect rect=CGRectMake(0.0,0.0,width,height);
    _effectViewController.view.frame=rect;
    
    [self layoutIfNeeded];
}

@end
