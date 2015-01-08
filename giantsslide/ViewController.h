//
//  ViewController.h
//  giantsslide
//
//  Created by 田中忍 on 2014/12/28.
//  Copyright (c) 2014年 tanakashichan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)choice:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

