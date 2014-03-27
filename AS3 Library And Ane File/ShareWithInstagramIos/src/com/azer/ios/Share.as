//  Created by Azer Bulbul on 12/29/13.
//  Copyright (c) 2013 Azer Bulbul. All rights reserved.
package com.azer.ios
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.utils.ByteArray;
	
	public class Share extends EventDispatcher implements IEventDispatcher
	{
		
		private static var _instance : Share;
		
		private static var ext:ExtensionContext = null;
		
		public function Share()
		{
			if (!_instance)
			{
				if(ext == null){
				ext = ExtensionContext.createExtensionContext("com.azer.ios.instagram",null);
				}
				_instance = this;
			}
		}
		
		/**
		 * Image ByteArray data Share with Instagram.
		 * Exapmle:
		 * if(com.azer.ios.Share.getInstance().isInstagramInstalled()){
		 * 		var byte:ByteArray = new ByteArray();
		 *		byte=YourBitmapData.encode(YourBitmapData.rect, new JPEGEncoderOptions(90), byte);
		 *		com.azer.ios.Share.getInstance().addEventListener(StatusEvent.STATUS, onStatusHandler);
		 * 		com.azer.ios.Share.getInstance().postToInstagram(byte, "Your Caption Here");
		 * }
		 * 
		 * @author Azer BULBUL https://github.com/sharkhack
		 * */
		public static function getInstance() : Share
		{
			return _instance ? _instance : new Share();
		}
		
		/**
		 * The installation instagram checks whether there
		 * 
		 * @author Azer BULBUL https://github.com/sharkhack
		 */
		public function isInstagramInstalled():Boolean{
			return ext.call("isInstagramAvailable");
		}
		
		/**
		 * Open your image with instagram app for share
		 * 
		 * @param byte is your BitmapData to ByteArray
		 * @param caption will be the description of the image is for your share.
		 * 
		 * @author Azer BULBUL https://github.com/sharkhack
		 */
		public function shareWithInstagram(byte:ByteArray,caption:String = ""):void{
			ext.addEventListener( StatusEvent.STATUS, statusHandler);
			ext.call('shareToInstagram',byte,caption);
		}
		
		/**
		 * dispose extension context
		 **/
		public function dispose():void{
			ext.removeEventListener( StatusEvent.STATUS, statusHandler);
			try{
				ext.dispose();
			} catch(e:*){}
			ext = null;
			_instance = null;
			
		}
		
		private function statusHandler(e:StatusEvent):void
		{
			dispatchEvent(e);
		}
		
	}
}