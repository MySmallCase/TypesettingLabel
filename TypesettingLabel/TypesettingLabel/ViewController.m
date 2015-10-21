//
//  ViewController.m
//  TypesettingLabel
//
//  Created by MyMac on 15/10/21.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "TypesetLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TypesetLabel *label = [[TypesetLabel alloc] init];
    label.frame = CGRectMake(30, 60, 300, 30);
    label.backgroundColor = [UIColor redColor];
    label.text = @"原价:￥3999";
    
    
    
    label.verticalAlignment = TypesetLabellVerticalAlignmentMiddle;
    [self.view addSubview:label];
    
//    [label addAttr:TypesetLabelAttrDeleteLine value:label.textColor range:NSMakeRange(3, label.text.length - 3)];
    
    [label addAttr:TypesetLabelAttrFont value:[UIFont systemFontOfSize:22.0f] range:NSMakeRange(3, label.text.length - 3)];
    [label addAttr:TypesetLabelAttrColor value:[UIColor blueColor] range:NSMakeRange(3, label.text.length - 3)];
    
    [label updateLabelStyle];
    
}

@end
