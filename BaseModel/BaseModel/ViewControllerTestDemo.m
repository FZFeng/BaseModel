//
//  ViewController.m
//  BaseModel
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 fabius's studio. All rights reserved.
//

#import "ViewControllerTestDemo.h"

#define KFZUIViewTag_ControlList         100
#define KFZUIViewTag_DetailControl       200

@interface ViewControllerTestDemo ()<FZUIViewDelegate>{
    UIView *_demoDetailContentView;
}

@end

@implementation ViewControllerTestDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //使用FZUIView 构建功能button
    CGFloat currentSelfViewY=50.0;
    CGFloat controlFZUIViewHeight=35.0;
    FZUIView *controlFZUIView=[[FZUIView alloc] initWithFrame:CGRectMake(0, currentSelfViewY,SCREEN_WIDTH, controlFZUIViewHeight) effectObject:self];
    controlFZUIView.viewTag=KFZUIViewTag_ControlList;
    
    //fzuitextfield demo
    FZUIViewElementData *fzUITextFieldButtonElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUIButton];
    fzUITextFieldButtonElementData.fzUIViewElementDataText=@"UITextField";
    fzUITextFieldButtonElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
    fzUITextFieldButtonElementData.fzUIViewElementDataBgColor=[UIColor orangeColor];
    
    //fzuiview demo
    FZUIViewElementData *fzUIViewButtonElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUIButton];
    fzUIViewButtonElementData.fzUIViewElementDataText=@"UIView";
    fzUIViewButtonElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
    fzUIViewButtonElementData.fzUIViewElementDataBgColor=[UIColor orangeColor];
    
    //clean all ui
    FZUIViewElementData *clearAllUIButtonElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUIButton];
    clearAllUIButtonElementData.fzUIViewElementDataText=@"clear All UI";
    clearAllUIButtonElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
    clearAllUIButtonElementData.fzUIViewElementDataBgColor=[UIColor orangeColor];
    
    
    NSArray *elementArray=[[NSArray alloc] initWithObjects:fzUITextFieldButtonElementData, fzUIViewButtonElementData,clearAllUIButtonElementData,nil];
    CGFloat demoUIWidth=95.0;
    
    [controlFZUIView buildViewAverageUIElement:elementArray  uiElementWidth:demoUIWidth];
    [self.view addSubview:controlFZUIView];
    currentSelfViewY=currentSelfViewY+controlFZUIViewHeight+10;
    
    
    //demo view
    _demoDetailContentView=[[UIView alloc] initWithFrame:CGRectMake(0, currentSelfViewY, SCREEN_WIDTH, SCREEN_HEIGHT-currentSelfViewY)];
    _demoDetailContentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_demoDetailContentView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark FZUIView 所有Button event 事件
- (void)FZUIViewDelegateUIButtonTouchUpInsideEvent:(id)sender buttonObject:(UIButton *)buttonObject{
    
    FZUIView *fzUIViewObject=sender;
    NSInteger fzUIViwObjectViewTag=fzUIViewObject.viewTag;
    
    UIButton *btnObject=buttonObject;
    NSInteger btnTag=btnObject.tag;
    
    
    if (fzUIViwObjectViewTag==KFZUIViewTag_ControlList) {
        switch (btnTag-KFZUIViewTag_ControlList) {
            case 0:{
                //uitextfield
                
                FZUITextField *textField1=[[FZUITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 35) effectObject:self];
                textField1.text=@"textField1";
                textField1.backgroundColor=[UIColor lightGrayColor];
                textField1.textColor=[UIColor whiteColor];
                [_demoDetailContentView addSubview:textField1];
                
                FZUITextField *textField2=[[FZUITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 35) effectObject:self];
                textField2.text=@"textField1";
                textField2.backgroundColor=[UIColor lightGrayColor];
                textField2.textColor=[UIColor whiteColor];
                [_demoDetailContentView addSubview:textField2];
                
                break;
            }case 1:{
                //uiview
                FZUIView *detailControlFZUIView=[[FZUIView alloc] initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH-30, 35) effectObject:self];
                detailControlFZUIView.viewTag=KFZUIViewTag_DetailControl;
                
                //name label
                FZUIViewElementData *nameLabelElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUILabel uiElementDataWidth:100.0];
                nameLabelElementData.fzUIViewElementDataText=@"name";
                nameLabelElementData.fzUIViewElementDataBgColor=[UIColor lightGrayColor];
                nameLabelElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
                //price label
                FZUIViewElementData *priceLabelElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUILabel uiElementDataWidth:0.0];
                priceLabelElementData.fzUIViewElementDataText=@"price";
                priceLabelElementData.fzUIViewElementDataBgColor=[UIColor darkGrayColor];
                priceLabelElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
                //add button
                FZUIViewElementData *addButtonElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUIButton uiElementDataWidth:50.0];
                addButtonElementData.fzUIViewElementDataText=@"+";
                addButtonElementData.fzUIViewElementDataBgColor=[UIColor orangeColor];
                addButtonElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
                //num label
                FZUIViewElementData *numLabelElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUILabel uiElementDataWidth:50.0];
                numLabelElementData.fzUIViewElementDataText=@"num";
                numLabelElementData.fzUIViewElementDataBgColor=[UIColor blueColor];
                numLabelElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
                //reduce Button
                FZUIViewElementData *reduceButtonElementData=[[FZUIViewElementData alloc] initWithUIEelementDataType:FZUIViewUIEelmentTypeUIButton uiElementDataWidth:50.0];
                reduceButtonElementData.fzUIViewElementDataText=@"-";
                reduceButtonElementData.fzUIViewElementDataBgColor=[UIColor orangeColor];
                reduceButtonElementData.fzUIViewElementDataTextColor=[UIColor whiteColor];
                
                NSArray *dataArray=[[NSArray alloc] initWithObjects:nameLabelElementData, priceLabelElementData,addButtonElementData,numLabelElementData,reduceButtonElementData,nil];
                
                [detailControlFZUIView buildViewUIElement:dataArray];
                [_demoDetailContentView addSubview:detailControlFZUIView];
                
                break;
            }case 2:{
                //clear all sub view
                [self removeSubViewFromDemoDetailContentView];
                break;
            }
        }
    }else if (fzUIViwObjectViewTag==KFZUIViewTag_DetailControl){
        switch (btnTag-KFZUIViewTag_DetailControl) {
            case 2:{
                NSLog(@"+");
                break;
            }case 4:{
                 NSLog(@"-");
                break;
            }
        }
    }
}

- (void)removeSubViewFromDemoDetailContentView{
    for (UIView *subView in _demoDetailContentView.subviews) {
        [subView removeFromSuperview];
    }
}

@end
