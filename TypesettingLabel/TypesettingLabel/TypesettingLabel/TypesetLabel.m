//
//  TypesetLabel.m
//  TypesettingLabel
//
//  Created by MyMac on 15/10/21.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "TypesetLabel.h"
#import "TypesetModelLabel.h"

@interface TypesetLabel ()

/**
 *  带有样式的string
 */
@property (nonatomic,strong) NSMutableAttributedString *attrStringM;

/**
 *  样式
 */
@property (nonatomic,strong) NSMutableParagraphStyle *style;

/**
 *  附件
 */
@property (nonatomic,strong) NSMutableArray *attatchmentsM;

@end

@implementation TypesetLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    
    self.verticalAlignment = TypesetLabellVerticalAlignmentMiddle;
    
    self.numberOfLines = 0;
}

#pragma mark - 方法体
- (void)addAttrWithName:(NSString *)name value:(id)value range:(NSRange)range{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.attrStringM addAttribute:name value:value range:range];
        self.attributedText = self.attrStringM;
    });
}


- (void)addAttr:(TypesetLabelAttr)attr value:(id)value range:(NSRange)range{
    switch (attr) {
        case TypesetLabelAttrColor: //颜色
            [self setColor:value range:range];
            break;
        case TypesetLabelAttrFont://字体
            [self setFont:value range:range];
            break;
        case TypesetLabelAttrItalics: //斜体
            [self setAttrItalics:value range:range];
            break;
        case TypesetLabelAttrWordSpacing: //字间距
            [self setKern:value range:range];
            break;
        case TypesetLabelAttrDeleteLine://删除线
            [self setDeleteLineWithColor:value range:range];
            break;
        case TypesetLabelAttrUnderLine: //下划线
            [self setUnderLineWithColor:value range:range];
            break;
        default:
            break;
    }
}

- (void)addImage:(UIImage *)image size:(CGSize)size offset:(UIOffset)offset location:(NSUInteger)location{
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    //设置图片
    attachment.image = image;
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(self.font.lineHeight, self.font.lineHeight);
    }
    
    //设置大小
    attachment.bounds = (CGRect){CGPointMake(offset.horizontal, offset.vertical),size};
    
    TypesetModelLabel *labelModel = [TypesetModelLabel labelWithAttachment:attachment index:location];
    
    [self.attatchmentsM addObject:labelModel];

}

- (void)updateLabelStyle{
    if (self.attrStringM == nil) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.attrStringM addAttribute:NSParagraphStyleAttributeName value:self.style range:NSMakeRange(0, self.attrStringM.length)];
        
        //添加图片控件
        if (self.attatchmentsM.count != 0) {
            //排序
            NSArray *sortedLabelModels = [TypesetModelLabel sortLabelModels:self.attatchmentsM];
            
            [sortedLabelModels enumerateObjectsUsingBlock:^(TypesetModelLabel *labelModel, NSUInteger idx, BOOL *stop) {
                
                NSAttributedString *attrString = labelModel.attrString;
                NSUInteger index = labelModel.index + idx;
                [self.attrStringM insertAttributedString:attrString atIndex:index];
                
            }];
            
        }
        self.attributedText = self.attrStringM;
    });
    
}





#pragma mark - 重写方法
- (void)drawTextInRect:(CGRect)rect{
    
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    
    [super drawTextInRect:actualRect];
    
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch (self.verticalAlignment) {
        case TypesetLabellVerticalAlignmentTop: {
            textRect.origin.y = bounds.origin.y;
            break;
        }
        case TypesetLabellVerticalAlignmentBottom: {
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        }
        default: {
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) * 0.5;
            break;
        }
    }
    return textRect;
    
}


#pragma mark - getter and setter
- (void)setText:(NSString *)text{
    [super setText:text];
    
    self.attrStringM = [[NSMutableAttributedString alloc] initWithString:text];
    
    self.attributedText = self.attrStringM;
    
}

- (NSMutableArray *)attatchmentsM{
    if (!_attrStringM) {
        _attatchmentsM = [NSMutableArray array];
    }
    return _attatchmentsM;
}

- (void)setVerticalAlignment:(TypesetLabelVerticalAlignment)verticalAlignment{
    _verticalAlignment = verticalAlignment;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    
}

- (NSMutableParagraphStyle *)style{
    if (!_style) {
        _style = [[NSMutableParagraphStyle alloc] init];
        
        self.lineSpacing = 0; //设置行间距
        
        self.paragraphSpacing = 0;  //设置段落间距
        
        self.firstLineIndent = 0; //首行缩进
        
        CGFloat height = self.font.pointSize;
        _style.maximumLineHeight=height;
        _style.lineHeightMultiple=0;
        
    }
    return _style;
}

//首行缩进
- (void)setFirstLineIndent:(CGFloat)firstLineIndent{
    _firstLineIndent = firstLineIndent;
    self.style.firstLineHeadIndent = firstLineIndent;
}

//行间距
- (void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
    self.style.lineSpacing = lineSpacing;
}

//段落之间的间距
- (void)setParagraphSpacing:(CGFloat)paragraphSpacing{
    _paragraphSpacing = paragraphSpacing;
    self.style.paragraphSpacing = paragraphSpacing;
}


//颜色
- (void)setColor:(UIColor *)color range:(NSRange)range{
    [self addAttrWithName:NSForegroundColorAttributeName value:color range:range];
}

//字体
- (void)setFont:(UIFont *)font range:(NSRange)range{
    [self addAttrWithName:NSFontAttributeName value:font range:range];
}

//斜体
- (void)setAttrItalics:(id)italics range:(NSRange)range{
    [self addAttrWithName:NSObliquenessAttributeName value:italics range:range];
}

//字间距
- (void)setKern:(id)kern range:(NSRange)range{
    [self addAttrWithName:NSKernAttributeName value:kern range:range];
}

//删除线
- (void)setDeleteLineWithColor:(UIColor *)color range:(NSRange)range{
    [self addAttrWithName:NSStrikethroughStyleAttributeName value:@(YES) range:range];
    [self addAttrWithName:NSStrikethroughColorAttributeName value:color range:range];
}

//下划线
- (void)setUnderLineWithColor:(UIColor *)color range:(NSRange)range{
    [self addAttrWithName:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    [self addAttrWithName:NSUnderlineColorAttributeName value:color range:range];
}


@end
