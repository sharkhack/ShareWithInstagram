# IOS Sharing With Instagram App ANE
===============

iOS sharing for Instagram - Adobe Air Native Extension

If your application creates photos and you'd like your users to share these photos using Instagram, you can use the Document Interaction API to open your photo in Instagram's sharing flow.

[iPhone-Hooks](http://instagram.com/developer/iphone-hooks/)

ENJOY! :)

Adobe Air Native Extension Help
http://help.adobe.com/en_US/air/build/WS597e5dadb9cc1e0253f7d2fc1311b491071-8000.html

The easiest way to integrate iOs Library is via [Xcode](https://developer.apple.com/xcode/).
And using ActionScript Mobile Library via [Apache Flex SDK](http://flex.apache.org/).

If you're still living in the Xcode (Objective-C style), add the following files to your project:

- `FlashRuntimeExtension.h`
- `ShareWithInstagram.h`
- `ShareWithInstagram.m`
- `Instagram.h`
- `Instagram.m`

See `ShareWithInstagram - SharedInstance` in the Objective-C Library project for details of how to use this class. In short, though:

        NSData *d = toNSDataByteArray(argv[0]);
        UIImage *image=[UIImage imageWithData:d];
        NSString *caption = toFREObjectToNSString(argv[1]);
        [[ShareWithInstagram sharedInstance] shareImage:image withCaption:caption];


ActionScript Flex Mobile Library Project functions:

- isInstagramInstalled : The installation instagram checks whether there
- shareWithInstagram : Open your image with instagram app for share (ByteArray and String Caption)

----

USAGE The Ane File:

        //Image ByteArray data Share with Instagram.
                 
        if(com.azer.ios.Share.getInstance().isInstagramInstalled())
        {
                var byte:ByteArray = new ByteArray();
                byte=YourBitmapData.encode(YourBitmapData.rect, new JPEGEncoderOptions(90), byte);
                com.azer.ios.Share.getInstance().addEventListener(StatusEvent.STATUS, onStatusHandler);
                com.azer.ios.Share.getInstance().postToInstagram(byte, "Your Caption Here");
        }

        function onStatusHandler(event:StatusEvent):void{
                // you call here :  com.azer.ios.Share.getInstance().dispose();
        }


-----

These classes are ARC enabled, but you can `-fobjc-arc` them to use in non-ARC projects (not required if you're using Xcode).

You must first save your file in PNG or JPEG (preferred) format and use the filename extension ".ig". Using the iOS Document Interaction APIs you can trigger the photo to be opened by Instagram. The Identifier for our Document Interaction UTI is com.instagram.photo, and it conforms to the public/jpeg and public/png UTIs. See the Apple documentation articles: Previewing and Opening Files and the UIDocumentInteractionController Class Reference for more information.

Alternatively, if you want to show only Instagram in the application list (instead of Instagram plus any other public/jpeg-conforming apps) you can specify the extension class igo, which is of type com.instagram.exclusivegram.

When triggered, Instagram will immediately present the user with our filter screen. The image is preloaded and sized appropriately for Instagram. Other than using the appropriate image format, described above, our only requirement is that the image is at least 612px tall and/or wide. For best results, Instagram prefers opening a JPEG that is 612px by 612px square. If the image is larger, it will be resized dynamically.

To include a pre-filled caption with your photo, you can set the annotation property on the document interaction request to an NSDictionary containing an NSString under the key "InstagramCaption". Note: this feature will be available on Instagram 2.1 and later.

An important note: If either dimension of the image is less than 612 pixels, Instagram will present an alert to the user saying we were unable to open the file. It's our current policy not to upscale or stretch images to our minimum dimension.

