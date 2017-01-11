#import "FZUITextField.h"

#define KKeyBoardShow             @"keyBoardShow"
#define KSwitchKeyBoard           @"switchKeyBoard"
#define KMaxTextFieldOriginY      @"maxTextFieldOriginY"
#define KGapDistance              5.0


@implementation FZUITextField

#pragma mark 初始化默认值

- (id)initWithFrame:(CGRect)frame effectObject:(id)effectObject{
    self = [super initWithFrame:frame];
    if (self) {
        NSUserDefaults *currentUserDefaults=[[NSUserDefaults alloc] init];
        [currentUserDefaults setBool:NO forKey:KKeyBoardShow];
        [currentUserDefaults setBool:NO forKey:KSwitchKeyBoard];
        
        _effectViewController=effectObject;
        self.accessibilityLabel=@"";
        self.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.delegate=self;
    }
    return self;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
        [currentUserDefaults setBool:NO  forKey:KSwitchKeyBoard];
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
- (void)keyBoardWillShow:(NSNotification *)note{
    
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
