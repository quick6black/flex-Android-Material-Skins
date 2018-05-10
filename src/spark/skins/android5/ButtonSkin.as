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
	import flash.events.MouseEvent;
	import mx.core.DPIClassification;
	import mx.core.mx_internal;
	import mx.graphics.RectangularDropShadow;
	import spark.components.Group;
	import spark.core.SpriteVisualElement;
	import spark.skins.android5.supportClasses.InkRipple;
	import spark.skins.mobile.supportClasses.ButtonSkinBase;
	
	use namespace mx_internal;
	
	[Style(name="inkColor", type="uint", format="Color", inherit="yes", defaultValue="#999999")]
	
	public class ButtonSkin extends ButtonSkinBase
	{
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		protected var cornerRadius:int;	
		
		protected var roundedCornerRadius:int;
		
		private var dropShadowBlurX:Number;
		
		private var dropShadowBlurY:Number;
		
		private var dropShadowDistance:Number;
		
		protected var backgroundCornerRadius:Number;
		
		private var dropShadow:RectangularDropShadow;
		
		private var dropShadowAlpha:Number;
		
		private var backgroundFill:SpriteVisualElement;
		
		public var inkHolder:Group;
		
		private var currentRipple:InkRipple; 
		
		public function ButtonSkin()
		{
			super();
			
			dropShadowAlpha = 0.3;
			
			switch (applicationDPI)
			{			
				case DPIClassification.DPI_640:
				{			
					layoutGap = 20;
					measuredDefaultWidth = 128;
					measuredDefaultHeight = 144;
					cornerRadius = 10;	
					roundedCornerRadius = 80;
					dropShadowBlurX = 10;
					dropShadowBlurY = 10;
					dropShadowDistance = 5;
					layoutBorderSize = 4;
					break;
				}
				case DPIClassification.DPI_480:
				{		
					layoutGap = 15;
					measuredDefaultWidth = 96;
					measuredDefaultHeight = 108;
					cornerRadius = 8;
					roundedCornerRadius = 60;
					dropShadowBlurX = 8;
					dropShadowBlurY = 8;
					dropShadowDistance = 4;
					layoutBorderSize = 3;
					break;
				}
				case DPIClassification.DPI_320:
				{              
					layoutGap = 10;				
					measuredDefaultWidth = 172;
					measuredDefaultHeight = 72;
					roundedCornerRadius = 40;
					cornerRadius = 6;
					dropShadowBlurX = 6;
					dropShadowBlurY = 6;
					dropShadowDistance = 3;	
					layoutBorderSize = 2;
					break;
				}
				case DPIClassification.DPI_240:
				{		
					layoutGap = 7;
					measuredDefaultWidth = 110;
					measuredDefaultHeight = 45;
					cornerRadius = 4;	
					roundedCornerRadius = 30;
					dropShadowBlurX = 4;
					dropShadowBlurY = 4;
					dropShadowDistance = 2;
					layoutBorderSize = 2;
					break;
				}
				case DPIClassification.DPI_120:
				{			
					layoutGap = 4;				
					measuredDefaultWidth = 66;
					measuredDefaultHeight = 27;
					cornerRadius = 2;
					roundedCornerRadius = 15;
					dropShadowBlurX = 2;
					dropShadowBlurY = 2;
					dropShadowDistance = 1;
					layoutBorderSize = 1;
					break;
				}
				default:
				{        
					layoutGap = 5;
					
					measuredDefaultWidth = 88;
					measuredDefaultHeight = 36;
					cornerRadius = 3;
					roundedCornerRadius = 20;
					dropShadowBlurX = 3;
					dropShadowBlurY = 3;
					dropShadowDistance = 1;
					layoutBorderSize = 1;
					break;
				}
					
			}
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			setStyle("textAlign", "center");
			hostComponent.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			inkHolder = new Group();
			inkHolder.id = "inkHolder";	
			inkHolder.clipAndEnableScrolling = true;
			inkHolder.width = this.width;
			inkHolder.height = this.height;
			addChild(inkHolder);
			
		}
		
		/**
		 *  @private 
		 */
		override protected function commitCurrentState():void
		{   
			super.commitCurrentState();
			
			invalidateDisplayList();
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			
			setElementSize(inkHolder, unscaledWidth, unscaledHeight);
			setElementPosition(inkHolder, 0, 0);
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			var chromeColor:uint = getStyle("chromeColor");
			var downColor:uint = getStyle("downColor");
			var downAlpha:Number = getStyle("downAlpha");
			var backgroundAlphaValue:Number = getStyle("backgroundAlpha");
			if (getStyle("contentBackgroundBorder") == "raised")
			{
				if (currentState == "down")
				{	
					graphics.beginFill(downColor, downAlpha);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
					graphics.endFill();
					dropShadow = new RectangularDropShadow();
					dropShadow.angle = 90;
					dropShadow.distance = dropShadowDistance * 2;
					dropShadow.blurX = dropShadowBlurX;
					dropShadow.blurY = dropShadowBlurY;
					dropShadow.alpha = dropShadowAlpha;
					dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = cornerRadius;
					dropShadow.drawShadow(graphics, 0, 0, unscaledWidth, unscaledHeight); 
				}
				else
				{
					graphics.beginFill(chromeColor, backgroundAlphaValue);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
					graphics.endFill();
					dropShadow = new RectangularDropShadow();
					dropShadow.angle = 90;
					dropShadow.distance = dropShadowDistance;
					dropShadow.blurX = dropShadowBlurX;
					dropShadow.blurY = dropShadowBlurY;
					dropShadow.alpha = dropShadowAlpha;
					dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = cornerRadius;
					dropShadow.drawShadow(graphics, 0, 0, unscaledWidth, unscaledHeight); 
					destroyRipples();
				}
			}
			if (getStyle("contentBackgroundBorder") == "rounded")
			{
				if (currentState == "down")
				{	
					graphics.beginFill(downColor, downAlpha);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius);
					graphics.endFill();
					dropShadow = new RectangularDropShadow();
					dropShadow.angle = 90;
					dropShadow.distance = dropShadowDistance * 2;
					dropShadow.blurX = dropShadowBlurX;
					dropShadow.blurY = dropShadowBlurY;
					dropShadow.alpha = dropShadowAlpha;
					dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = roundedCornerRadius;
					dropShadow.drawShadow(graphics, 0, 0, unscaledWidth, unscaledHeight); 
				}
				else
				{
					graphics.beginFill(chromeColor, backgroundAlphaValue);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius);
					graphics.endFill();
					dropShadow = new RectangularDropShadow();
					dropShadow.angle = 90;
					dropShadow.distance = dropShadowDistance;
					dropShadow.blurX = dropShadowBlurX;
					dropShadow.blurY = dropShadowBlurY;
					dropShadow.alpha = dropShadowAlpha;
					dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = roundedCornerRadius;
					dropShadow.drawShadow(graphics, 0, 0, unscaledWidth, unscaledHeight); 
					destroyRipples();
				}
			}
			
			if (getStyle("contentBackgroundBorder") == "roundedempty")
			{
				if (currentState == "down")
				{	
					//rectangle border and background
					graphics.lineStyle(layoutBorderSize, downColor, 1);
					graphics.beginFill(chromeColor, 0);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius);
					graphics.endFill();
				}
				else
				{
					//rectangle border and background
					graphics.lineStyle(layoutBorderSize, chromeColor, 1);
					graphics.beginFill(chromeColor, 0);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius, roundedCornerRadius);
					graphics.endFill();
					destroyRipples();
				}
			}
			if (getStyle("contentBackgroundBorder") == "flat")
			{
				if (currentState == "down")
				{	
					graphics.beginFill(downColor, downAlpha);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
					graphics.endFill();
				}
				else
				{
					graphics.beginFill(chromeColor, 0);
					graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
					graphics.endFill();
					destroyRipples();
				}
			}	
		}
		
		protected function destroyRipples():void 
		{ 
			for(var i:int=0; i < inkHolder.numElements; i++) 
			{ 
				inkHolder.getElementAt(i)["destroy"](true); 
			} 
		}
		
		private function onDown(event:MouseEvent):void 
		{ 
			var inkColor:uint = getStyle("inkColor");
			if(currentRipple) 
				currentRipple.isMouseDown = false; 
			var rippleRadius:Number =  Math.sqrt(width*width+height*height); 
			currentRipple = new InkRipple(event["localX"], event["localY"], rippleRadius*2, inkColor, 1200); 
			currentRipple.owner = inkHolder; 
			inkHolder.addElement(currentRipple); 
		} 
	}
}