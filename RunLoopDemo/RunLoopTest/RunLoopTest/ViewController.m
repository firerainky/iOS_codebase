//
//  ViewController.m
//  RunLoopTest
//
//  Created by yons on 16/5/19.
//  Copyright © 2016年 yg. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "YGView.h"
#import "YGThread.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *defaultModeTimerCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *commonModesTimerCountLabel;

@property (weak, nonatomic) IBOutlet UITextView *textFeild;

@property (weak, nonatomic) YGView *myView;

@property (strong, nonatomic) YGThread *thread;

// 不带 *，因为 dispatch_source_t 是个类，内部已带 *
@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.textFeild.delegate = self;
    
    // 打印当前 RunLoop 的当前 mode
    //NSLog(@"viewDidLoad: %@", [NSRunLoop currentRunLoop].currentMode);
    
    //NSLog(@"%@", [NSRunLoop currentRunLoop]);
    
    // 通过 NS 的 API 获取 RunLoop
    // [NSRunLoop mainRunLoop];
    // [NSRunLoop currentRunLoop];
    
    // 通过 CF 的 API 获取 RunLoop
    // CFRunLoopGetMain();
    // CFRunLoopGetCurrent();
    
    // RunLoop 与 GCD
    //dispatch_async(dispatch_get_main_queue(), ^{
    //    NSLog(@"dispatch_async");
    //});
    
    // 查看子线程的 RunLoop
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //    [self someFunc];
    //});
    
    // 添加 timer 的两种方法
    // 1、这方法做了两件事：创建一个 timer，将其添加到当前 RunLoop 上。默认是添加到 DefaultMode 上。
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(defaultMode_run) userInfo:nil repeats:YES];
    
    // 2、手动将 timer 添加到当前 RunLoop 上，并指定模式为 CommonModes
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(commonModes_run) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 创建一个蓝色子视图
    YGView *v = [[YGView alloc] initWithFrame:CGRectMake(30, 250, 50, 50)];
    v.backgroundColor = [UIColor blueColor];
    [self.view addSubview:v];
    self.myView = v;
    
    // 这也是用到 timer
    //[self performSelector:@selector(someFunc) withObject:nil afterDelay:1];

    // 开始运行子线程
    self.thread = [[YGThread alloc] initWithTarget:self selector:@selector(execute) object:nil];
    [self.thread start];
    
}

/* 添加到主线程的 RunLoop 的 defaultMode 的 timer 中执行的方法 */
- (void)defaultMode_run {
    static int count = 0;
    count++;
    self.defaultModeTimerCountLabel.text = [NSString stringWithFormat:@"%d",count];
}

/* 添加到主线程的 RunLoop 的 commonModes 的 timer 中执行的方法 */
- (void)commonModes_run {
    static int count = 0;
    count++;
    self.commonModesTimerCountLabel.text = [NSString stringWithFormat:@"%d",count];
}

/* 测试更新 UI 的时间点 */
- (IBAction)moveMyViewBtnClick:(id)sender {
    
    CGRect frame = self.myView.frame;
    // 先向下移动
    frame.origin.y += 50;
    [UIView animateWithDuration:1 animations:^{
        self.myView.frame = frame;
        //[self.myView setNeedsDisplay];
    }];
    
    // 再向右移动
    frame.origin.x += 50;
    [UIView animateWithDuration:1 animations:^{
        self.myView.frame = frame;
        [self.myView setNeedsDisplay];
    }];
}

/* 给当前 RunLoop 添加一个 observer，监听 RunLoop 的状态变化 */
- (IBAction)addObserver:(id)sender {
    /*
     创建 observer：
     传入的参数：observer, 要监听 RunLoop 的哪些状态变化，是否重复，顺序，监听到状态变化的回调
     */
    CFRunLoopObserverRef observer =
    CFRunLoopObserverCreateWithHandler(
                                       CFAllocatorGetDefault(),
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       ^(CFRunLoopObserverRef observer,
                                         CFRunLoopActivity activity) {
                                           if (activity == kCFRunLoopEntry) {
                                               NSLog(@"RunLoop Entry");
                                           }
                                           if (activity == kCFRunLoopBeforeTimers) {
                                               NSLog(@"RunLoop BeforeTimers");
                                           }
                                           if (activity == kCFRunLoopBeforeSources) {
                                               NSLog(@"RunLoop BeforeSources");
                                           }
                                           if (activity == kCFRunLoopBeforeWaiting) {
                                               NSLog(@"RunLoop BeforeWaiting");
                                           }
                                           if (activity == kCFRunLoopExit) {
                                               NSLog(@"RunLoop Exit");
                                           }
                                       });
    // kCFAllocatorSystemDefault 默认的 observer
    // 添加观察者：监听 RunLoop 的状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

/* 常驻线程 */
- (void)execute {
    NSLog(@"execute in long lived thread:%@", [NSThread currentThread]);
    
    // 添加 source，保持 RunLoop 不退出
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    
    // 或者可以添加启动时间超长的 timer，保持 RunLoop 不退出
    //NSTimer *timer = [NSTimer timerWithTimeInterval:MAXFLOAT target:self selector:@selector(someFunc) userInfo:nil repeats:YES];
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] run];
}
- (IBAction)performSelectorInLongLivedThread:(id)sender {
    [self performSelector:@selector(execute) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"haha");
}

 /* GCD 的定时器：是比 timer 要准确的 */
- (IBAction)addGCDTimer {
    static int count = 0;
    
    // 获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 创建一个定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（什么时候开始，多久重复一次）
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_time_t interval = 1.0 * NSEC_PER_SEC;
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        count++;
        NSLog(@"GCD count: %d in %@", count, [NSThread currentThread]);
    });
    
    // 启动定时器
    dispatch_resume(self.timer);
}

/* 取消 GCD 定时器 */
- (IBAction)cancelGCDTimer:(id)sender {
    dispatch_cancel(self.timer);
    self.timer = nil;
}

// 查看子线程的 RunLoop
- (void)someFunc {
    NSLog(@"%@", [NSRunLoop currentRunLoop]);
    NSLog(@"%@", [NSThread currentThread]);
}

#pragma mark - UITextViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll: %@", [NSRunLoop currentRunLoop].currentMode);
}

@end





