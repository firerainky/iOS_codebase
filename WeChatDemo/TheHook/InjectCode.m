//
//  InjectCode.m
//  TheHook
//
//  Created by Zheng Kanyan on 2021/3/20.
//

#import "InjectCode.h"
#import <objc/runtime.h>

@implementation InjectCode
+ (void)load {
    
//    Method registerMethod = class_getInstanceMethod( objc_getClass("WCAccountLoginControlLogic"), @selector(onFirstViewRegister));
//    Method registerHooker = class_getInstanceMethod(self, @selector(theRegister));
//    method_exchangeImplementations(registerMethod, registerHooker);
//    [self replaceMethods];
    [self setGetMethods];
    
    // 通过addMethod 的方式来添加方法
//    class_addMethod(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(theLogin), theLogin, "v@:");
//    BOOL didAddMethod = class_addMethod(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(theLogin), class_getMethodImplementation(self, @selector(theLogin)), "v@:");
//    if (didAddMethod) {
//        Method loginMethod = class_getInstanceMethod(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(onNext));
//        Method loginHooker = class_getInstanceMethod(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(theLogin));
//    //    Method loginHooker = class_getInstanceMethod(self, @selector(theLogin));
//        method_exchangeImplementations(loginMethod, loginHooker);
//    }
}

+ (void)replaceMethods {
    loginMethod = class_getMethodImplementation(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(onNext));
    class_replaceMethod(
                        objc_getClass("WCAccountNewPhoneVerifyViewController"),
                        @selector(onNext),
                        theLogin,
                        "v@:");
}

+ (void)setGetMethods {
    loginMethod = method_getImplementation(class_getInstanceMethod(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(onNext)));
    method_setImplementation(class_getInstanceMethod(objc_getClass("WCAccountNewPhoneVerifyViewController"), @selector(onNext)), theLogin);
}

- (void)theRegister {
    NSLog(@"\n\n\n\n🍺🍺🍺🍺\n\n\n\n");
}

IMP (*loginMethod)(id self, SEL _cmd);

void theLogin(id self, SEL _cmd) {
    NSString *pwdText = [[[self valueForKey:@"_textFieldPwdItem"] valueForKey:@"m_textField"] valueForKey:@"text"];
    NSLog(@"Current PWD: %@", pwdText);
    loginMethod(self, _cmd);
}

- (void)theLogin {
    NSString *pwdText = [[[self valueForKey:@"_textFieldPwdItem"] valueForKey:@"m_textField"] valueForKey:@"text"];
    NSLog(@"Current PWD: %@", pwdText);
    [self performSelector:@selector(theLogin)];
}
@end
