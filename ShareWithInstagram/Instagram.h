//
//  Instagram.h
//  ShareWithInstagram
//
//  Created by Azer Bulbul on 3/27/14.
//  Copyright (c) 2014 azer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instagram : NSObject <UIDocumentInteractionControllerDelegate>

extern NSString* const aInstagramAppURLString;
extern NSString* const aInstagramOnlyPhotoFileName;

+ (void) setPhotoFileName:(NSString*)fileName;
+ (NSString*) photoFileName;

+ (BOOL) isAppInstalled;
+ (BOOL) isImageCorrectSize:(UIImage*)image;
+ (void) postImage:(UIImage*)image inView:(UIView*)view;
+ (void) postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view;
+ (void) postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view delegate:(id<UIDocumentInteractionControllerDelegate>)delegate;


@end
