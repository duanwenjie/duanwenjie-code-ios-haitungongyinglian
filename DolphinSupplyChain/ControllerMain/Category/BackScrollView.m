//
//  BackScrollView.m
//  Distribution
//
//  Created by DIOS on 14-11-28.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "BackScrollView.h"

@implementation BackScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.dragging) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{


    if (!self.dragging) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
    
}

@end
