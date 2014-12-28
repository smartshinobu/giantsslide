//
//  ViewController.m
//  giantsslide
//
//  Created by 田中忍 on 2014/12/28.
//  Copyright (c) 2014年 tanakashichan. All rights reserved.
//

#import "ViewController.h"
#import "Webreturn.h"

@interface ViewController (){
    NSString *urlstr;
    NSString *tag;
    NSDictionary *dic;
    NSArray *array;
    NSTimer *timer;
    int count;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    urlstr = @"https://api.instagram.com/v1/tags/tagname/media/recent?access_token=1546466429.b528a28.81831577fd6244249f0b0bd0a0ef1741";
    tag = @"ジャイアンツ";
    NSString *entag = [tag stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *starturl = [urlstr stringByReplacingOccurrencesOfString:@"tagname" withString:entag];
    count = 0;
    dic = [Webreturn JSONDictinaryData:starturl];
    array = [dic objectForKey:@"data"];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(slideshow) userInfo:nil repeats:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choice:(id)sender {
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
@end
