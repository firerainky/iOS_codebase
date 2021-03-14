//
//  main.m
//  RunLoopTest
//
//  Created by yons on 16/5/19.
//  Copyright © 2016年 yg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        int result = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        // 只要程序在运行，不会运行到下面这句
        NSLog(@"after UIApplicationMain");
        return result;
    }
}
