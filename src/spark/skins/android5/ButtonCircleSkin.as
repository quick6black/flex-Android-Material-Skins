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
	
	import spark.skins.mobile.supportClasses.ButtonSkinBase;
	
	use namespace mx_internal;
	
	public class ButtonCircleSkin extends ButtonSkinBase
	{
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var dropShadowBlurX:Number;
		
		private var dropShadowBlurY:Number;
		
		private var dropShadowDistance:Number;
		
		private var dropShadow:RectangularDropShadow;
		
		private var dropShadowAlpha:Number;
		
		public function ButtonCircleSkin()
		{
			super();
			
			dropShadowAlpha = 0.4;
			
			switch (applicationDPI)
			{			
				case DPIClassification.DPI_640:
				{			
					layoutGap = 20;
					layoutPaddingLeft = 40;
					layoutPaddingRight = 40;
					layoutPaddingTop = 40;
					layoutPaddingBottom = 40;
					measuredDefaultWidth = 128;
					measuredDefaultHeight = 128;	
					
					dropShadowBlurX = 15;
					dropShadowBlurY = 15;
					dropShadowDistance = 8;
					
					break;
				}
				case DPIClassification.DPI_480:
				{		
					layoutGap = 15;
					layoutPaddingLeft = 30;
					layoutPaddingRight = 30;
					layoutPaddingTop = 30;
					layoutPaddingBottom = 30;
					measuredDefaultWidth = 96;
					measuredDefaultHeight = 96;
					
					dropShadowBlurX = 12;
					dropShadowBlurY = 12;
					dropShadowDistance = 6;
					
					break;
				}
				case DPIClassification.DPI_320:
				{              
					layoutGap = 10;
					layoutPaddingLeft = 20;
					layoutPaddingRight = 20;
					layoutPaddingTop = 20;
					layoutPaddingBottom = 20;
					measuredDefaultWidth = 72;
					measuredDefaultHeight = 72;
					
					dropShadowBlurX = 10;
					dropShadowBlurY = 10;
					dropShadowDistance = 6;	
					
					break;
				}
				case DPIClassification.DPI_240:
				{		
					layoutGap = 7;
					layoutPaddingLeft = 15;
					layoutPaddingRight = 15;
					layoutPaddingTop = 15;
					layoutPaddingBottom = 15;
					measuredDefaultWidth = 45;
					measuredDefaultHeight = 45;
					
					dropShadowBlurX = 8;
					dropShadowBlurY = 8;
					dropShadowDistance = 6;
					break;
				}
				case DPIClassification.DPI_120:
				{			
					layoutGap = 4;
					layoutPaddingLeft = 8;
					layoutPaddingRight = 8;
					layoutPaddingTop = 8;
					layoutPaddingBottom = 8;
					measuredDefaultWidth = 27;
					measuredDefaultHeight = 27;
					
					dropShadowBlurX = 4;
					dropShadowBlurY = 4;
					dropShadowDistance = 3;
					
					break;
				}
				default:
				{        
					layoutGap = 5;
					layoutPaddingLeft = 10;
					layoutPaddingRight = 10;
					layoutPaddingTop = 10;
					layoutPaddingBottom = 10;
					measuredDefaultHeight = 30;
					measuredDefaultWidth = 30;
					
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
			
			if (currentState == "down")
			{	
				dropShadow = new RectangularDropShadow();
				dropShadow.angle = 90;
				dropShadow.distance = dropShadowDistance * 2;
				dropShadow.blurX = dropShadowBlurX;
				dropShadow.blurY = dropShadowBlurY;
				dropShadow.alpha = dropShadowAlpha;
				dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = unscaledWidth/2;
				dropShadow.drawShadow(graphics,  0, 0, unscaledWidth, unscaledWidth); 
				graphics.beginFill(downColor, downAlpha);
				graphics.drawCircle(unscaledWidth/2, unscaledHeight/2, unscaledWidth/2);
				graphics.endFill();
			}
			else
			{
				dropShadow = new RectangularDropShadow();
				dropShadow.angle = 90;
				dropShadow.distance = dropShadowDistance;
				dropShadow.blurX = dropShadowBlurX;
				dropShadow.blurY = dropShadowBlurY;
				dropShadow.alpha = dropShadowAlpha;
				dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = unscaledWidth/2;
				dropShadow.drawShadow(graphics,  0, 0, unscaledWidth, unscaledWidth); 
				graphics.beginFill(chromeColor, backgroundAlphaValue);
				graphics.drawCircle(unscaledWidth/2, unscaledHeight/2, unscaledWidth/2);
				graphics.endFill();
			}
		}
		
	}
}