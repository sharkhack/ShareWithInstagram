//
//  ShareWithInstagram.m
//  ShareWithInstagram
//
//  Created by Azer Bulbul on 3/27/14.
//  Copyright (c) 2014 azer. All rights reserved.
//

#import "ShareWithInstagram.h"

FREContext ShareWInstagramCtx = nil;

@implementation ShareWithInstagram

static ShareWithInstagram *sharedInstance = nil;

+ (ShareWithInstagram *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [ShareWithInstagram sharedInstance];
}

- (id)copy
{
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (UIAlertView*) notInstalledAlert
{
    return [[UIAlertView alloc] initWithTitle:@"Instagram Not Installed!" message:@"Instagram must be installed on the device in order to post images" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
}

- (BOOL) isAvailable{
    return [Instagram isAppInstalled];
}
- (void) shareImage:(UIImage*) image withCaption:(NSString *)caption
{
    
    if ([Instagram isAppInstalled]){
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [Instagram postImage:image withCaption:caption inView:rootViewController.view];
        
        FREDispatchStatusEventAsync(ShareWInstagramCtx, (const uint8_t *)"INSTAGRAM", (const uint8_t *)"OK");
    }
    else{
        [self.notInstalledAlert show];
    }
}

@end


NSData *toNSDataByteArray(FREObject *ba)
{
    FREByteArray byteArray;
    FREAcquireByteArray(ba, &byteArray);
    
    NSData *d = [NSData dataWithBytes:(void *)byteArray.bytes length:(NSUInteger)byteArray.length];
    FREReleaseByteArray(ba);
    
    return d;
}

FREObject toBOOLToFREObject(BOOL boolean)
{
    FREObject result;
    FRENewObjectFromBool(boolean, &result);
    return result;
}
NSString * toFREObjectToNSString(FREObject object)
{
    uint32_t stringLength;
    const uint8_t *string;
    FREGetObjectAsUTF8(object, &stringLength, &string);
    return [NSString stringWithUTF8String:(char*)string];
}

FREObject isInstagramAvailable(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
    return toBOOLToFREObject([[ShareWithInstagram sharedInstance] isAvailable]);
}

FREObject shareToInstagram(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
    
    NSData *d = toNSDataByteArray(argv[0]);
    UIImage *image=[UIImage imageWithData:d];
    NSString *caption = toFREObjectToNSString(argv[1]);
    [[ShareWithInstagram sharedInstance] shareImage:image withCaption:caption];
    
    return nil;
}



void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
						uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    NSLog(@"Entering ContextInitializer()");
    
	*numFunctionsToTest = 2;
    
	FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 2);
	func[0].name = (const uint8_t*) "isInstagramAvailable";
	func[0].functionData = NULL;
    func[0].function = &isInstagramAvailable;
    
    func[1].name = (const uint8_t*) "shareToInstagram";
	func[1].functionData = NULL;
    func[1].function = &shareToInstagram;
    
	*functionsToSet = func;
    
    ShareWInstagramCtx = ctx;
    
    NSLog(@"Exiting ContextInitializer()");
    
}


void ContextFinalizer(FREContext ctx) {
    ShareWInstagramCtx = nil;
    return;
}

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet,
                    FREContextFinalizer* ctxFinalizerToSet) {
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
}

void ExtFinalizer(void* extData) {
    return;
}
