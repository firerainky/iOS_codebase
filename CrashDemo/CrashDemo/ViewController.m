//
//  ViewController.m
//  CrashDemo
//
//  Created by Zheng Kanyan on 2021/3/11.
//

#import "ViewController.h"
#import <SCLAlertView.h>

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic) NSArray *arr;
@end

NSString *kSuccessTitle = @"Congratulations";
NSString *kErrorTitle = @"Connection error";
NSString *kNoticeTitle = @"Notice";
NSString *kWarningTitle = @"Warning";
NSString *kInfoTitle = @"Info";
NSString *kSubtitle = @"You've just displayed this awesome Pop Up View";
NSString *kButtonTitle = @"Done";
NSString *kAttributeTitle = @"Attributed string operation successfully completed.";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"aaa", @"bbb"];
    self.textView.delegate = self;
    NSLog(@"viewDidLoad: %@", [NSRunLoop currentRunLoop].currentMode);
    // Do any additional setup after loading the view.
}

- (IBAction)makeException:(id)sender {
    NSLog(@"%@", self.arr[2]);
}

- (IBAction)showAlert:(id)sender {
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    SCLButton *button = [alert addButton:@"First Button" target:self selector:@selector(firstButton)];

    button.buttonFormatBlock = ^NSDictionary* (void)
    {
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];

        buttonConfig[@"backgroundColor"] = [UIColor whiteColor];
        buttonConfig[@"textColor"] = [UIColor blackColor];
        buttonConfig[@"borderWidth"] = @2.0f;
        buttonConfig[@"borderColor"] = [UIColor greenColor];

        return buttonConfig;
    };

    [alert addButton:@"Second Button" actionBlock:^(void) {
        NSLog(@"Second button tapped");
    }];

//    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];

    [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:kButtonTitle duration:0.0f];
}

- (void)firstButton
{
    NSLog(@"First button tapped");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch: %@", [NSRunLoop currentRunLoop].currentMode);
}

#pragma mark - UITextViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll: %@", [NSRunLoop currentRunLoop].currentMode);
}

@end
