//
//  Invoke.h
//  objc
//
//  Created by Zheng Kanyan on 2021/2/26.
//

#ifndef Invoke_h
#define Invoke_h

#import <Foundation/Foundation.h>

@protocol Invoker <NSObject>

@required
// 在调用对象方法前，执行对功能的横切
- (void)preInvoke:(NSInvocation *)inv withTarget:(id)target;
@optional
// 在调用对象中的方法后，执行对功能的横切
- (void)postInvoke:(NSInvocation *)inv withTarget:(id)target;

@end

#endif /* Invoke_h */
