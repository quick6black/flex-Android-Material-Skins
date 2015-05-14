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
	import mx.core.DPIClassification;
	import mx.core.mx_internal;
	import mx.graphics.RectangularDropShadow;
	
	import spark.core.SpriteVisualElement;
	import spark.skins.mobile.supportClasses.ButtonSkinBase;
	
	use namespace mx_internal;
	
	public class ButtonSkin extends ButtonSkinBase
	{
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var circleRadius:int;
		
		protected var cornerRadius:int;	
		
		private var dropShadowBlurX:Number;
		
		private var dropShadowBlurY:Number;
		
		private var dropShadowDistance:Number;
		
		protected var backgroundCornerRadius:Number;
		
		private var dropShadow:RectangularDropShadow;
		
		private var dropShadowAlpha:Number;
		
		private var backgroundFill:SpriteVisualElement;
		
		public function ButtonSkin()
		{
			super();
			
			dropShadowAlpha = 0.3;
			
			switch (applicationDPI)
			{			
				case DPIClassification.DPI_640:
				{			
					layoutGap = 20;
					layoutPaddingLeft = 60;
					layoutPaddingRight = 60;
					layoutPaddingTop = 40;
					layoutPaddingBottom = 40;
					measuredDefaultWidth = 128;
					measuredDefaultHeight = 144;
					circleRadius = 80;
					cornerRadius = 10;	
					
					dropShadowBlurX = 15;
					dropShadowBlurY = 15;
					dropShadowDistance = 8;
					
					break;
				}
				case DPIClassification.DPI_480:
				{		
					layoutGap = 15;
					layoutPaddingLeft = 45;
					layoutPaddingRight = 45;
					layoutPaddingTop = 30;
					layoutPaddingBottom = 30;
					measuredDefaultWidth = 96;
					measuredDefaultHeight = 108;
					circleRadius = 60;
					cornerRadius = 8;
					
					dropShadowBlurX = 12;
					dropShadowBlurY = 12;
					dropShadowDistance = 6;
					
					break;
				}
				case DPIClassification.DPI_320:
				{              
					layoutGap = 10;
					layoutPaddingLeft = 30;
					layoutPaddingRight = 30;
					layoutPaddingTop = 20;
					layoutPaddingBottom = 20;
					measuredDefaultWidth = 172;
					measuredDefaultHeight = 72;
					circleRadius = 40;
					
					cornerRadius = 6;
					dropShadowBlurX = 10;
					dropShadowBlurY = 10;
					dropShadowDistance = 6;	
					
					break;
				}
				case DPIClassification.DPI_240:
				{		
					layoutGap = 7;
					layoutPaddingLeft = 23;
					layoutPaddingRight = 23;
					layoutPaddingTop = 15;
					layoutPaddingBottom = 15;
					measuredDefaultWidth = 110;
					measuredDefaultHeight = 45;
					circleRadius = 30;
					cornerRadius = 4;	
					
					dropShadowBlurX = 8;
					dropShadowBlurY = 8;
					dropShadowDistance = 6;
					break;
				}
				case DPIClassification.DPI_120:
				{			
					layoutGap = 4;
					layoutPaddingLeft = 12;
					layoutPaddingRight = 12;
					layoutPaddingTop = 8;
					layoutPaddingBottom = 8;
					measuredDefaultWidth = 66;
					measuredDefaultHeight = 27;
					cornerRadius = 2;
					
					dropShadowBlurX = 4;
					dropShadowBlurY = 4;
					dropShadowDistance = 3;
					
					break;
				}
				default:
				{        
					layoutGap = 5;
					layoutPaddingLeft = 15;
					layoutPaddingRight = 15;
					layoutPaddingTop = 10;
					layoutPaddingBottom = 10;	
					measuredDefaultWidth = 88;
					measuredDefaultHeight = 36;
					cornerRadius = 3;
					
					dropShadowBlurX = 5;
					dropShadowBlurY = 5;
					dropShadowDistance = 1;
					
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
				}
			}	
		}
	}
}