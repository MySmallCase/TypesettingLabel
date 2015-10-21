//
//  TypesetModelLabel.h
//  TypesettingLabel
//
//  Created by MyMac on 15/10/21.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TypesetModelLabel : NSObject

/**
 *  带有样式的字符串
 */
@property (nonatomic,strong) NSAttributedString *attrString;

/**
 *  位置
 */
@property (nonatomic,assign) NSUInteger index;

/**
 *  快速实例化
 */
+ (instancetype)labelWithAttachment:(NSTextAttachment *)textAttachment index:(NSUInteger)index;


+ (NSArray *)sortLabelModels:(NSArray *)labelModels;

@end
