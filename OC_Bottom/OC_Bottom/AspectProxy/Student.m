//
//  Student.m
//  underwater
//
//  Created by Zheng Kanyan on 2021/2/24.
//

#import "Student.h"

@implementation Student

- (void)study: (NSString *)subject : (NSString *)bookName {
    NSLog(@"Invoking method on %@ object with selector %@", [self class], NSStringFromSelector(_cmd));
}

- (void)study: (NSString *)subject andRead: (NSString *)bookName {
    NSLog(@"Invoking method on %@ object with selector %@", [self class], NSStringFromSelector(_cmd));
}
@end
