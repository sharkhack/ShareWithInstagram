//
//  ShareWithInstagram.h
//  ShareWithInstagram
//
//  Created by Azer Bulbul on 3/27/14.
//  Copyright (c) 2014 azer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "Instagram.h"

@interface ShareWithInstagram : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UIAlertViewDelegate>

+ (ShareWithInstagram *)sharedInstance;

- (BOOL) isAvailable;
- (void) shareImage:(UIImage*) image withCaption:(NSString*)caption;
@end

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
						uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void ContextFinalizer(FREContext ctx);

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet,
                    FREContextFinalizer* ctxFinalizerToSet);

void ExtFinalizer(void* extData);