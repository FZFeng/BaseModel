//
//  cSystemPlist.m
//  BaseModel
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 Fabius's Studio. All rights reserved.
//



#import "SystemPlist.h"

#define dbLogin            @"bLogin"
#define dsUrl              @"sUrl"
#define dsDishUrl          @"sDishUrl"
#define dsDishSetUrl       @"sDishSetUrl"
#define dsCompanyNum       @"sCompanyNum"
#define dsUser             @"sUser"
#define dsPwd              @"sPwd"
#define dsHeadLogoFileName @"headlogo.png"
#define dsTaken            @"sTaken"

#define dsMemberCode       @"sMemberCode"
#define dsMemberName       @"sMemberName"
#define dsDepartMentName   @"sDepartMentName"

#define dsSystemPlistPath [NSString stringWithFormat:@"%@/SystemPlist.plist",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject]

#define dsHeadLogoFolderPath [NSString stringWithFormat:@"%@/HeadLogo",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject]

@implementation SystemPlist

+(SystemPlist*)shared{
    static dispatch_once_t once = 0;
    static SystemPlist *Obj;
    dispatch_once(&once, ^{ Obj = [[SystemPlist alloc] init]; });
    return Obj;
}

#pragma mark 创建信息 登录用户信息的plist 和头像logo文件夹HeadLogo
+(void)CreateSystemPlist{
    if (![[NSFileManager defaultManager] fileExistsAtPath:dsSystemPlistPath]) {
        NSDictionary *dictInfo=@{dbLogin: @"NO",dsCompanyNum:@"",dsUrl:@"",dsDishUrl:@"",dsDishSetUrl:@"", dsUser:@"",dsPwd:@"",dsHeadLogoFileName:@"",dsTaken:@"",dsMemberCode:@"",dsMemberName:@"",dsDepartMentName:@""};
        [dictInfo writeToFile:dsSystemPlistPath atomically:YES];
    }
    
    //创建头文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:dsHeadLogoFolderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dsHeadLogoFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }

}

#pragma mark 初始化信息 登录用户信息的plist 清空头像logo文件夹HeadLogo文件
+(void)InitSystemPlist{
    //初始化systemplist
    NSDictionary *dictInfo=@{dbLogin: @"NO",dsCompanyNum:@"",dsUrl:@"",dsDishUrl:@"",dsDishSetUrl:@"",dsUser:@"",dsPwd:@"",dsHeadLogoFileName:@"",dsTaken:@"",dsMemberCode:@"",dsMemberName:@"",dsDepartMentName:@""};
    [dictInfo writeToFile:dsSystemPlistPath atomically:YES];

    //删除头像文件
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dsHeadLogoFolderPath,dsHeadLogoFileName] error:nil];
}

#pragma mark systemPlist文件是否存在
+(BOOL)ExistSystemPlist{
   return [[NSFileManager defaultManager] fileExistsAtPath:dsSystemPlistPath];
}

#pragma mark 返回systemPlist的NSMutableDictionary
-(NSMutableDictionary*)getSystemPlistDictionary{
    
    NSMutableDictionary *dictPlist;
    dictPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:dsSystemPlistPath];
    
    return dictPlist;
}

#pragma mark 设置值
-(void)setPlistValue:(NSString*)psValue sKey:(NSString*)psKey{
    
    NSMutableDictionary *dictPlist=[[SystemPlist shared] getSystemPlistDictionary];
    
    [dictPlist setObject:psValue forKey:psKey];
    //保存
    [dictPlist writeToFile:dsSystemPlistPath atomically:YES];

}
#pragma mark 获取值
-(NSString*)getPlistValue:(NSString*)psKey{
    NSMutableDictionary *dictPlist=[[SystemPlist shared] getSystemPlistDictionary];
    return  [dictPlist objectForKey:psKey];
}

#pragma mark 设置bLogin的属性
+(void)SetLogin:(BOOL)pbLogin{
    
    NSMutableDictionary *dictPlist=[[SystemPlist shared] getSystemPlistDictionary];
    
    NSString *sFlag=@"";
    if (pbLogin) {
        sFlag=@"YES";
    }else{
        sFlag=@"NO";
    }

    [dictPlist setObject:sFlag forKey:dbLogin];
    //保存
    [dictPlist writeToFile:dsSystemPlistPath atomically:YES];
    
}
+(BOOL)GetLogin{
    NSMutableDictionary *dictPlist=[[SystemPlist shared] getSystemPlistDictionary];
    
    BOOL sFlag;
    
    if ([[dictPlist objectForKey:dbLogin] isEqualToString:@"YES"]) {
        sFlag=YES;
    }else{
        sFlag=NO;
    }
    return sFlag;
}

//url
+(void)SetUrl:(NSString*)pUrl{
    [[SystemPlist shared] setPlistValue:pUrl sKey:dsUrl];
}
+(NSString*)GetUrl{
    return  [[SystemPlist shared] getPlistValue:dsUrl];
}

//Dishurl
+(void)SetDishUrl:(NSString*)pUrl{
    [[SystemPlist shared] setPlistValue:pUrl sKey:dsDishUrl];
}
+(NSString*)GetDishUrl{
    return  [[SystemPlist shared] getPlistValue:dsDishUrl];
}

//DisSethurl
+(void)SetDisSetUrl:(NSString*)pUrl{
    [[SystemPlist shared] setPlistValue:pUrl sKey:dsDishSetUrl];
}
+(NSString*)GetDisSetUrl{
    return  [[SystemPlist shared] getPlistValue:dsDishSetUrl];
}

//CompanyNum
+(void)SetCompanyNum:(NSString*)pCompanyNum{
    [[SystemPlist shared] setPlistValue:pCompanyNum sKey:dsCompanyNum];
}
+(NSString*)GetCompanyNum{
    return  [[SystemPlist shared] getPlistValue:dsCompanyNum];
}

//user
+(void)SetLoadUser:(NSString*)pLoadUser{
    [[SystemPlist shared] setPlistValue:pLoadUser sKey:dsUser];
}
+(NSString*)GetLoadUser{
    return  [[SystemPlist shared] getPlistValue:dsUser];
}

//pwd
+(void)SetLoadPwd:(NSString*)pLoadPwd{
    [[SystemPlist shared] setPlistValue:pLoadPwd sKey:dsPwd];
}
+(NSString*)GetLoadPwd{
   return  [[SystemPlist shared] getPlistValue:dsPwd];
}

//MemberName
+(void)SetMemberName:(NSString*)pMemberName{
    [[SystemPlist shared] setPlistValue:pMemberName sKey:dsMemberName];

}
+(NSString*)GetMemberName{
    return  [[SystemPlist shared] getPlistValue:dsMemberName];
}

//MemberCode
+(void)SetMemberCode:(NSString*)pMemberCode{
    [[SystemPlist shared] setPlistValue:pMemberCode sKey:dsMemberCode];
}
+(NSString*)GetMemberCode{

    return  [[SystemPlist shared] getPlistValue:dsMemberCode];
}

//departmentName
+(void)SetDepartmentName:(NSString*)pDepartmentName{
    [[SystemPlist shared] setPlistValue:pDepartmentName sKey:dsDepartMentName];
}
+(NSString*)GetDepartmentName{
    return  [[SystemPlist shared] getPlistValue:dsDepartMentName];
}

#pragma mark 保存头像到本地
+(void)SaveHeadLogoToLocalWithUrl:(NSString*)psHeadLogoUrl{
    
    if ([psHeadLogoUrl isEqualToString:@""]) return;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:psHeadLogoUrl]];
    UIImage * imageFromURL = [UIImage imageWithData:data];
    
    [UIImageJPEGRepresentation(imageFromURL, 1) writeToFile:[NSString stringWithFormat:@"%@/%@",dsHeadLogoFolderPath,dsHeadLogoFileName] options:NSAtomicWrite error:nil];
    
    //设置HeadLogo到systemplist
    //[[SystemPlist shared] setPlistValue:dsHeadLogoFileName sKey:dsHeadLogo];
}

+(void)SaveHeadLogoToLocalWithData:(NSData*)pData{
    if (pData.length==0) return;
    
    //创建文件并重命名
    [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/%@",dsHeadLogoFolderPath,dsHeadLogoFileName] contents:pData attributes:nil];
    
    //设置HeadLogo到systemplist
    //[[SystemPlist shared] setPlistValue:dsHeadLogoFileName sKey:dsHeadLogo];
}




@end
