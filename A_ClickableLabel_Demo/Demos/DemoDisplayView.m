//
//  DemoDisplayView.m
//  A_ClickableLabel_Demo
//
//  Created by Animax Deng on 2/11/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import "DemoDisplayView.h"
#import <CoreText/CoreText.h>

@implementation DemoDisplayView {
    NSAttributedString *_attributedText;
}

- (void)draw: (NSAttributedString*)attributedText {
    _attributedText = attributedText;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!_attributedText) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attributedText);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, (CFIndex)[_attributedText length]), path, NULL);
    if (frame == NULL) {
        CFRelease(path);
        return;
    }
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}
@end
