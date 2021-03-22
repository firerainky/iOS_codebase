//
//  ViewController.m
//  fishHookDemo
//
//  Created by Zheng Kanyan on 2021/3/22.
//

#import "ViewController.h"
#import "fishhook.h"

@interface ViewController ()

@end

@implementation ViewController

static void (*sys_nslog)(NSString *format, ...);
void new_nslog(NSString *format, ...) {
    format = [format stringByAppendingString:@"\nHoooooooooooooooooooked"];
    sys_nslog(format);
}

static int (*sys_printf)(const char * __restrict, ...);
int new_printf(const char * str, ...) {
    char new[80];
    strcat(new, str);
    return sys_printf(new);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Not yet.");
    
    // Hook NSLog
    struct rebinding rebind;
    rebind.name = "NSLog";
    rebind.replacement = new_nslog;
    rebind.replaced = (void *)&sys_nslog;
    
    // Hook printf
    struct rebinding rebindPrintf;
    rebindPrintf.name = "printf";
    rebindPrintf.replacement = new_printf;
    rebindPrintf.replaced = (void *)&sys_printf;
    
    struct rebinding rebindings[] = { rebind, rebindPrintf };
    
    // Do the hook
    rebind_symbols(rebindings, 2);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Hit the screen. %@", @"mylove");
    printf("Hit the screen with printf.\n");
}

@end
