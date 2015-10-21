//
//  TypesetLabel.h
//  TypesettingLabel
//
//  Created by MyMac on 15/10/21.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  对齐方式
 */
typedef NS_ENUM(NSUInteger,TypesetLabelVerticalAlignment) {
    
    //顶部对齐
    TypesetLabellVerticalAlignmentTop = 0,
    
    //垂直居中
    TypesetLabellVerticalAlignmentMiddle,
    
    //底部对齐
    TypesetLabellVerticalAlignmentBottom
};


/**
 *  属性
 */
typedef NS_ENUM(NSUInteger,TypesetLabelAttr) {
    
    //颜色
    TypesetLabelAttrColor = 0,
    
    //字体
    TypesetLabelAttrFont,
    
    //斜体
    TypesetLabelAttrItalics,
    
    //字间距
    TypesetLabelAttrWordSpacing,
    
    //删除线
    TypesetLabelAttrDeleteLine,
    
    //下划线
    TypesetLabelAttrUnderLine
    
};

@interface TypesetLabel : UILabel

/**
 *  对齐方式
 */
@property (nonatomic,assign) TypesetLabelVerticalAlignment verticalAlignment;

/**
 *  首行缩进
 */
@property (nonatomic,assign) CGFloat firstLineIndent;

/**
 *  行间距
 */
@property (nonatomic,assign) CGFloat lineSpacing;

/**
 *  段落间距
 */
@property (nonatomic,assign) CGFloat paragraphSpacing;


/**
 *  添加属性
 */
- (void)addAttr:(TypesetLabelAttr)attr value:(id)value range:(NSRange)range;

/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image size:(CGSize)size offset:(UIOffset)offset location:(NSUInteger)location;


/**
 *  更新UILabel
 */
- (void)updateLabelStyle;


@end
