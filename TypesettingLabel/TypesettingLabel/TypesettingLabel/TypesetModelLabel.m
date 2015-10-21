//
//  TypesetModelLabel.m
//  TypesettingLabel
//
//  Created by MyMac on 15/10/21.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "TypesetModelLabel.h"

@implementation TypesetModelLabel


/**
 *  实例化
 */
+ (instancetype)labelWithAttachment:(NSTextAttachment *)textAttachment index:(NSUInteger)index{
    
    TypesetModelLabel *labelModel = [[TypesetModelLabel alloc] init];
    
    labelModel.attrString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    labelModel.index = index;
    
    return labelModel;
}


/**
 *  排序
 */
+ (NSArray *)sortLabelModels:(NSArray *)labelModels{

    NSArray *sortedLabelModels = [labelModels sortedArrayUsingComparator:^NSComparisonResult(TypesetModelLabel *labelModel1, TypesetModelLabel *labelModel2) {
        
        if (labelModel1.index < labelModel2.index) {
            return NSOrderedAscending;
        }
        
        if (labelModel1.index < labelModel2.index) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
        
    }];
    
    return sortedLabelModels;
    
}

@end
