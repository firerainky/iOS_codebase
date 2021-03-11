//
//  Student.h
//  underwater
//
//  Created by Zheng Kanyan on 2021/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

- (void)study: (NSString *)subject : (NSString *)bookName;

- (void)study: (NSString *)subject andRead: (NSString *)bookName;

@property (copy, nullable) NSString *name;
//@property (copy, readonly, nonnull) NSArray *allItems;

// 也可以将nullable, nonnull, null_unspecified, null_resettable三个修饰语前面加双下划线，用于修饰指针、参数、返回值等(null_resettable只能在属性括号中使用)
@property (copy, readonly) NSArray * __nonnull allItems;

@end

NS_ASSUME_NONNULL_END
