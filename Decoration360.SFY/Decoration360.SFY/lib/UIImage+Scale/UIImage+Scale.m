//
//  UIImage+Scale.m
//  Parker125
//
//  Created by Wu Zhiyong on 1/6/13.
//  Copyright (c) 2013 BST. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
@end
