//
//  NSArray+KY.m
//  CrashDemo
//
//  Created by Zheng Kanyan on 2021/3/11.
//

#import "NSArray+KY.h"
#import <objc/runtime.h>

@implementation NSArray (KY)

// dyld -> init -> libsystem -> libdispatch -> libobjc -> objc init
// hook 放在 load 里面是因为它执行时间早，register (map_images load_images)
+ (void)load {
//    Method m1 = class_getInstanceMethod(self, @selector(ky_objectAtIndexedSubscript:));
//    Method m2 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
//    method_exchangeImplementations(m1, m2);
}

- (id)ky_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self ky_objectAtIndexedSubscript:idx];
    } else {
        return @"越界了";
    }
}
@end
