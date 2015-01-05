//
//  ViewController.m
//  giantsslide
//
//  Created by 田中忍 on 2014/12/28.
//  Copyright (c) 2014年 tanakashichan. All rights reserved.
//

#import "ViewController.h"
#import "Webreturn.h"

@interface ViewController ()<UIActionSheetDelegate>{
    NSString *urlstr;
    NSString *tag;
    NSDictionary *dic;
    NSArray *array;
    NSTimer *timer;
    NSArray *playary;
    int count;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    tag = @"読売ジャイアンツ";
    playary = [NSArray arrayWithObjects:@"澤村拓一",@"大竹寛",@"杉内俊哉",@"菅野智之",@"内海哲也",@"宮國椋丞",@"西村健太朗",@"山口鉄也",@"小林誠司",@"阿部慎之助",@"井端弘和",@"坂本勇人",@"片岡治大",@"村田修一",@"長野久義",@"亀井善行",@"鈴木尚広",@"高橋由伸",@"松本哲也",@"橋本到",@"矢野謙次", @"ジャビット",nil];
    [self slidebefore];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choice:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc]init];
    as.delegate = self;
    as.title = @"選択してください";
    for (int i = 0; i < [playary count]; i++) {
        [as addButtonWithTitle:[playary objectAtIndex:i]];
    }
    [as showInView:self.view];
}

-(void)slideshow{
    NSDictionary *infodic = [array objectAtIndex:count];
    NSString *typestr = [infodic objectForKey:@"type"];
    if ([typestr isEqualToString:@"image"]) {
        NSDictionary *imgdic = [[infodic objectForKey:@"images"] objectForKey:@"standard_resolution"];
        NSString *imgurl = [imgdic objectForKey:@"url"];
        self.imageview.image = [Webreturn WebImage:imgurl];
    }
    if (count == [array count] - 1) {
        count = 0;
        NSString *next = [[dic objectForKey:@"pagination"]objectForKey:@"next_url"];
        NSLog(@"%@",next);
        if (next != nil) {
            dic = [Webreturn JSONDictinaryData:next];
            array = [dic objectForKey:@"data"];
        }
    }else{
        count++;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    tag = [playary objectAtIndex:buttonIndex];
    [timer invalidate];
    timer = nil;
    [self slidebefore];
}

-(void)slidebefore{
    urlstr = @"https://api.instagram.com/v1/tags/tagname/media/recent?access_token=1546466429.b528a28.81831577fd6244249f0b0bd0a0ef1741";
    NSString *entag = [tag stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *starturl = [urlstr stringByReplacingOccurrencesOfString:@"tagname" withString:entag];
    count = 0;
    dic = [Webreturn JSONDictinaryData:starturl];
    array = [dic objectForKey:@"data"];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(slideshow) userInfo:nil repeats:YES];
}
@end
