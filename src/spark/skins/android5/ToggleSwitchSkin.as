////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package spark.skins.android5
{
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import mx.core.DPIClassification;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.graphics.RectangularDropShadow;
	
	import spark.components.Group;
	import spark.components.ToggleSwitch;
	import spark.core.SpriteVisualElement;
	import spark.skins.android5.supportClasses.InkRipple;
	import spark.skins.mobile.supportClasses.MobileSkin;
	
	use namespace mx_internal;
	
	public class ToggleSwitchSkin extends MobileSkin
	{
		public function ToggleSwitchSkin()
		{
			super();	
			
			dropShadowAlpha = 0.3;
			
			switch(applicationDPI) 
			{	
				case DPIClassification.DPI_640:
				{
					layoutThumbWidth = 108;
					trackWidth = 140;
					trackHeight = 70;			
					trackCurve = 76;				
					
					dropShadowBlurX = 15;
					dropShadowBlurY = 15;
					dropShadowDistance = 5;
					
					break;
				}
				case DPIClassification.DPI_480:
				{
					layoutThumbWidth = 80;
					trackWidth = 108;
					trackHeight = 52;				
					trackCurve = 56;
					
					dropShadowBlurX = 12;
					dropShadowBlurY = 12;
					dropShadowDistance = 4;
					
					break;
				}		
				case DPIClassification.DPI_320:
				{
					layoutThumbWidth = 52;
					trackWidth = 70;
					trackHeight = 34;
					trackCurve = 38;
					
					dropShadowBlurX = 10;
					dropShadowBlurY = 10;
					dropShadowDistance = 3;	
					
					break;
				}
				case DPIClassification.DPI_240:
				{
					layoutThumbWidth = 40;
					trackWidth = 54;
					trackHeight = 26;
					trackCurve = 28;
					
					dropShadowBlurX = 8;
					dropShadowBlurY = 8;
					dropShadowDistance = 2;
					
					break;
				}
				case DPIClassification.DPI_120:
				{
					layoutThumbWidth = 20;
					trackWidth = 27;
					trackHeight = 13;
					trackCurve = 14;
					
					dropShadowBlurX = 4;
					dropShadowBlurY = 4;
					dropShadowDistance = 1;
					
					break;
				}
				default:
				{
					layoutThumbWidth = 26;								
					trackWidth = 35;
					trackHeight = 17;
					trackCurve = 18;
					
					dropShadowBlurX = 5;
					dropShadowBlurY = 5;
					dropShadowDistance = 1;	
					
					break;
				}
			}
		}
		
		//----------------------------------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------------------------------
		protected var trackWidth:Number;
		protected var trackHeight:Number;
		protected var trackCurve:Number;
		protected var layoutThumbWidth:Number;
		
		
		private var dropShadowBlurX:Number;		
		private var dropShadowBlurY:Number;		
		private var dropShadowDistance:Number;		
		private var dropShadow:RectangularDropShadow;		
		private var dropShadowAlpha:Number;	
		
		private var slidingContentBackground:SpriteVisualElement;
		private var slidingContentForeground:UIComponent;
		private var slidingContentOverlay:DisplayObject;
		
		private var contents:UIComponent;
		
		private var thumbContent:Sprite;
		public var thumb:IVisualElement;
		public var track:IVisualElement;
		
		public var inkHolder:Group;
		
		private var currentRipple:InkRipple; 
		
		override public function set currentState(value:String):void 
		{
			super.currentState = value;		
			invalidateDisplayList();
		}
		
		private var _hostComponent:ToggleSwitch;
		
		public function get hostComponent():ToggleSwitch 
		{
			return _hostComponent;
		}
		
		public function set hostComponent(value:ToggleSwitch):void 
		{		
			if (_hostComponent)
				_hostComponent.removeEventListener("thumbPositionChanged", thumbPositionChanged_handler);
			_hostComponent = value;
			if (_hostComponent)
				_hostComponent.addEventListener("thumbPositionChanged", thumbPositionChanged_handler);
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			drawTrack(unscaledWidth, unscaledHeight);
			drawThumb(unscaledWidth, unscaledHeight);
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			
			setElementSize(contents, unscaledWidth, layoutThumbWidth);
			setElementPosition(contents, 0, (unscaledHeight - layoutThumbWidth) / 2);
			
			layoutTrack(unscaledWidth, layoutThumbWidth);
		}
		
		override protected function measure():void 
		{
			measuredMinWidth = trackWidth;
			measuredMinHeight = layoutThumbWidth;
			
			measuredWidth = trackWidth;
			measuredHeight = layoutThumbWidth;
		}
		
		override protected function commitCurrentState():void 
		{
			if (currentState && currentState.indexOf("disabled") >= 0) 
			{ 
				alpha = 0.5;
			}
			else
			{
				alpha = 1.0;
			}
			if (currentState && currentState.indexOf("upAndSelected") >= 0) 
			{
				destroyRipples();
			}
			if (currentState && currentState.indexOf("downAndSelected") >= 0) 
			{
				destroyRipples();
			}
			if (currentState && currentState.indexOf("up") >= 0) 
			{
				destroyRipples();
			}
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			contents = new UIComponent();
			contents.blendMode = BlendMode.LAYER;
			addChild(contents);
			
			// SlidingContent: background, overlay, labels
			slidingContentBackground = new SpriteVisualElement();
			contents.addChild(slidingContentBackground);
			
			slidingContentForeground = new UIComponent();
			contents.addChild(slidingContentForeground);
			
			// Track
			track = new SpriteVisualElement();
			contents.addChild(SpriteVisualElement(track));
			
			// Thumb
			thumb = new SpriteVisualElement();
			contents.addChild(SpriteVisualElement(thumb));
			
			thumbContent = new Sprite();
			SpriteVisualElement(thumb).addChild(thumbContent);	
			
			//material animations
			inkHolder = new Group();
			inkHolder.id = "inkHolder";
			SpriteVisualElement(thumb).addChild(inkHolder);
		}
		
		private function drawTrack(skinWidth:Number, skinHeight:Number):void 
		{
			var graphics:Graphics = SpriteVisualElement(track).graphics;
			var trackColor:uint = getStyle("trackColor");
			var trackColorSelected:uint = getStyle("trackColorSelected");
			graphics.clear();		
			if(currentState.indexOf("AndSelected") != -1)
			{
				graphics.beginFill(trackColorSelected);   
			}
			else
			{
				graphics.beginFill(trackColor);    
			}		
			graphics.drawRoundRect(0, 0, trackWidth, trackHeight, trackCurve, trackCurve);
			graphics.endFill();
		}
		
		private function layoutTrack(skinWidth:Number, skinHeight:Number):void 
		{
			setElementSize(track, trackWidth, skinHeight);
			setElementPosition(track, 0,  skinHeight /2 - trackHeight /2);
		}
		
		private function drawThumb(skinWidth:Number, skinHeight:Number):void 
		{
			var graphics:Graphics = thumbContent.graphics;
			var thumbColor:uint = getStyle("thumbColor");
			var thumbColorSelected:uint = getStyle("thumbColorSelected");			
			graphics.clear();	
			if (currentState && currentState.indexOf("down") >= 0)
			{
				addRipple();	
			}
			if(currentState.indexOf("AndSelected") != -1)
			{
				graphics.beginFill(thumbColorSelected, 1); 
			}
				
			else
			{
				graphics.beginFill(thumbColor, 1); 
			}	
			graphics.drawCircle(0, skinHeight/2, layoutThumbWidth /2);
			graphics.endFill();
			dropShadow = new RectangularDropShadow();
			dropShadow.angle = 90;
			dropShadow.distance = dropShadowDistance;
			dropShadow.blurX = dropShadowBlurX;
			dropShadow.blurY = dropShadowBlurY;
			dropShadow.alpha = dropShadowAlpha;
			dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = layoutThumbWidth/2;
			dropShadow.drawShadow(graphics, 0 - skinHeight/2, 0, layoutThumbWidth, layoutThumbWidth);
			
			setElementSize(inkHolder, unscaledWidth, unscaledHeight);
			setElementPosition(inkHolder, 0 - unscaledWidth, layoutThumbWidth /2);
		}
		
		private function moveSlidingContent():void 
		{
			if (!hostComponent)
				return;
			var x:Number = (track.getLayoutBoundsWidth() - thumb.getLayoutBoundsWidth()) * hostComponent.thumbPosition + track.getLayoutBoundsX();
			var y:Number = thumb.getLayoutBoundsY();
			setElementPosition(slidingContentForeground, x, y);
		}
		
		private function thumbPositionChanged_handler(event:Event):void 
		{
			moveSlidingContent();
		}	
		
		protected function addRipple():void
		{
			var thumbColor:uint = 0x000000;
			var thumbColorSelected:uint = getStyle("thumbColorSelected");				
			if (inkHolder.numElements == 0)
			{
				var rippleRadius:Number =  Math.sqrt(width*width+height*height); 
				if (currentState.indexOf("AndSelected") != -1)
				{
					currentRipple = new InkRipple(0, 0, rippleRadius * 1.5, thumbColorSelected, 300); 
				}
				else
				{
					currentRipple = new InkRipple(0, 0, rippleRadius * 1.5, thumbColor, 300); 
				}	
				currentRipple.owner = inkHolder; 
				inkHolder.addElement(currentRipple); 
			}
			else
			{
				//do nothing
			}
		}
		
		protected function destroyRipples():void 
		{ 
			for(var i:int=0; i < inkHolder.numElements; i++) 
			{ 
				inkHolder.getElementAt(i)["destroy"](true); 
			} 
		}
	}
	
	
}