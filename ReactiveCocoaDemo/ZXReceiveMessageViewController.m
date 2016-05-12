//
//  ZXReceiveMessageViewController.m
//  ReactiveCocoaDemo
//
//  Created by 张新 on 16/5/12.
//  Copyright © 2016年 zhangxin. All rights reserved.
//

#import "ZXReceiveMessageViewController.h"
#import "Masonry.h"
@implementation ZXReceiveMessageViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    //
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"发送消息" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(receiveMessageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@44);
        make.width.equalTo(@100);
    }];

}
-(void)receiveMessageAction{
    if (self.delegateSingle) {
        [self.delegateSingle sendNext:@"哈哈我是第二个页面传过来的title"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
