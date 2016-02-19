//
//  A_AttributedStringBuilder.m
//
//  Created by Animax Deng on 2/9/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import "A_AttributedStringBuilder.h"

@implementation A_AttributedStringBuilder {
    NSMutableDictionary<NSString *, id> *attributed;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        attributed = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (A_AttributedStringBuilder *)createWithSystemFontSize:(CGFloat)size {
    A_AttributedStringBuilder *builder = [A_AttributedStringBuilder new];
    [builder setSystemFontSize:size];
    return builder;
}
+ (A_AttributedStringBuilder *)createWithFontName:(NSString *)name withSize:(CGFloat)size {
    A_AttributedStringBuilder *builder = [A_AttributedStringBuilder new];
    [builder setFontName:name withSize:size];
    return builder;
}
+ (A_AttributedStringBuilder *)createFromAttributes:(NSDictionary *)attributes {
    A_AttributedStringBuilder *builder = [A_AttributedStringBuilder new];
    [builder setAttributes:attributes];
    return builder;
}

- (A_AttributedStringBuilder *)setAttributes:(NSDictionary *)attributes {
    [attributed setValuesForKeysWithDictionary:attributes];
    return self;
}
- (A_AttributedStringBuilder *)setSystemFontSize:(CGFloat)size {
    UIFont *font = [UIFont systemFontOfSize:size];
    [attributed setObject:font forKey:NSFontAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setFontName:(NSString *)name withSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:name size:size];
    [attributed setObject:font forKey:NSFontAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setKern:(CGFloat)kern {
    [attributed setObject:@(kern) forKey:NSKernAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setParagraphStyle:(NSParagraphStyle *)style {
    [attributed setObject:style forKey:NSParagraphStyleAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setUnderline:(BOOL)underline {
    [attributed setObject:@(underline) forKey:NSUnderlineStyleAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setShadow:(NSShadow *)shadow{
    [attributed setObject:shadow forKey:NSShadowAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setObliqueness:(CGFloat)obliqueness {
    [attributed setObject:@(obliqueness) forKey:NSObliquenessAttributeName];
    return self;
}

- (A_AttributedStringBuilder *)setForegroundColor:(UIColor *)color {
    [attributed setObject:color forKey:NSForegroundColorAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setBackgroundColor:(UIColor *)color {
    [attributed setObject:color forKey:NSBackgroundColorAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setStrokeColor:(UIColor *)color {
    [attributed setObject:color forKey:NSStrokeColorAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setBaselineOffset:(CGFloat)offest {
    [attributed setObject:@(offest) forKey:NSBaselineOffsetAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setUnderlineColor:(UIColor *)color {
    [attributed setObject:color forKey:NSUnderlineColorAttributeName];
    return self;
}
- (A_AttributedStringBuilder *)setExpansion:(CGFloat)offest {
    [attributed setObject:@(offest) forKey:NSExpansionAttributeName];
    return self;
}


- (NSDictionary<NSString *, id> *)getStringAttributes {
    return [attributed copy];
}
- (NSAttributedString *)getAttributedString:(NSString *)string {
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:string attributes:attributed];
    return str;
}

@end
