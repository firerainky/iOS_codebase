//
//  main.m
//  OC_Bottom
//
//  Created by Zheng Kanyan on 2021/2/23.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

#import "AspectProxy.h"
#import "AuditingInvoker.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSObject *obj = [[NSObject alloc] init];
        
        NSLog(@"NSObject class size: %zd", class_getInstanceSize([NSObject class]));
        NSLog(@"NSObject object size: %zd", malloc_size((__bridge const void *)obj));
        NSLog(@"Hello, World!");
        
        id student = [[Student alloc] init];
        
        [Student respondsToSelector:@selector(study::)];

        // 设置代理中注册的选择器数组
        NSValue *selValue1 = [NSValue valueWithPointer:@selector(study:andRead:)];
        NSArray *selValues = @[selValue1];
        // 创建AuditingInvoker
        AuditingInvoker *invoker = [[AuditingInvoker alloc] init];
        // 创建Student对象的代理studentProxy
        id studentProxy = [[AspectProxy alloc] initWithObject:student selectors:selValues andInvoker:invoker];
        
        // 使用指定的选择器向该代理发送消息---例子1
        [studentProxy study:@"Computer" andRead:@"Algorithm"];
        
        // 使用还未注册到代理中的其他选择器，向这个代理发送消息！---例子2
        [studentProxy study:@"mathematics" :@"higher mathematics"];
        
        // 为这个代理注册一个选择器并再次向其发送消息---例子3
        [studentProxy registerSelector:@selector(study::)];
        [studentProxy study:@"mathematics" :@"higher mathematics"];
    }
    return 0;
}
