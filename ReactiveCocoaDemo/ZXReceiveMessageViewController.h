//
//  ZXReceiveMessageViewController.h
//  ReactiveCocoaDemo
//
//  Created by 张新 on 16/5/12.
//  Copyright © 2016年 zhangxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
@interface ZXReceiveMessageViewController : UIViewController
@property(nonatomic,strong)RACSubject *delegateSingle;
@end
