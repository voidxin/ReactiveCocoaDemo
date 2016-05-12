//
//  ZXCustomerViewController.m
//  ReactiveCocoaDemo
//
//  Created by 张新 on 16/5/12.
//  Copyright © 2016年 zhangxin. All rights reserved.
//

#import "ZXCustomerViewController.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "ZXReceiveMessageViewController.h"
@interface ZXCustomerViewController()
@property(nonatomic,strong)RACCommand *command;
@end
@implementation ZXCustomerViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    RACReplaySubject *replaySubject=[RACReplaySubject subject];
                                     
//    //发送信号
//    [replaySubject sendNext:@"fist"];
//    [replaySubject sendNext:@"second"];
//    
//    //订阅信号
//    [replaySubject subscribeNext:^(id x) {
//        NSString *text=x;
//        NSLog(@"第一个订阅者接收到的数据%@",text);
//    }];
//    
//    [replaySubject subscribeNext:^(id x) {
//        NSString *text=x;
//        NSLog(@"第二个订阅者接收到的数据%@",text);
//    }];
    //遍历数组
    [self printArray];
    //遍历字典
    [self printDictory];
    
   //commod
    [self createCommond];
    
    //代替delegate
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"下一个页面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@44);
        make.width.equalTo(@250);
    }];
    
    //
    UIButton *commondBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [commondBtn setTitle:@"commond" forState:UIControlStateNormal];
    commondBtn.rac_command=self.command;
    @weakify(self);
    [self.view addSubview:commondBtn];
    [commondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(15);
        make.height.equalTo(@44);
        make.width.equalTo(@250);
    }];
}

-(void)btnAction:(UIButton *)btn{
    ZXReceiveMessageViewController *receiveVC=[[ZXReceiveMessageViewController alloc]init];
    receiveVC.delegateSingle=[RACSubject subject];
    //订阅代理信号
    [receiveVC.delegateSingle subscribeNext:^(id x) {
        [btn setTitle:(NSString *)x forState:UIControlStateNormal];
    }];
    [self presentViewController:receiveVC animated:YES completion:nil];
}


#pragma mark 遍历数组
-(void)printArray{
    NSArray *arrs=@[@1,@2,@3,@4,@5];
    [arrs.rac_sequence.signal subscribeNext:^(NSNumber *number) {
        NSInteger num=[number integerValue];
        NSLog(@"%ld",num);
    }];
}
-(void)printDictory{
    NSDictionary *dict=@{@"name":@"zhangxin",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(NSString *key,NSString *value)=x;
        NSLog(@"%@ %@",key,value);
    }];
}

-(void)createCommond{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        NSLog(@"执行命令");
        
        // 创建空信号,必须返回信号
        //        return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    self.command=command;

}
@end
