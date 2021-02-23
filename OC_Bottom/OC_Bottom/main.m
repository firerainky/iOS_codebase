//
//  main.m
//  OC_Bottom
//
//  Created by Zheng Kanyan on 2021/2/23.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSObject *obj = [[NSObject alloc] init];
        
        NSLog(@"NSObject class size: %zd", class_getInstanceSize([NSObject class]));
        NSLog(@"NSObject object size: %zd", malloc_size((__bridge const void *)obj));
        NSLog(@"Hello, World!");
    }
    return 0;
}
