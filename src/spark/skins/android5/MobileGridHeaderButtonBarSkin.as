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
	
	import spark.components.ButtonBarButton;
	import spark.components.DataGroup;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalAlign;
	import spark.skins.android5.ButtonBarSkin;
	import spark.skins.mobile.supportClasses.ButtonBarButtonClassFactory;
	
	public class MobileGridHeaderButtonBarSkin extends ButtonBarSkin
	{
		protected var flatheight:uint;	
		
		public function MobileGridHeaderButtonBarSkin()
		{
			super();
			
			switch (applicationDPI)
			{
				case DPIClassification.DPI_640:
				{
					flatheight = 9;
					break;
				}
				case DPIClassification.DPI_480:
				{
					flatheight = 7;				
					break;
				}
				case DPIClassification.DPI_320:
				{
					flatheight = 6;				
					break;
				}
				case DPIClassification.DPI_240:
				{		
					flatheight = 5;
					break;
				}
				case DPIClassification.DPI_120:
				{
					flatheight = 2;					
					break;
				}
				default:
				{
					flatheight = 3; 
					break;
				}
		}
		
		override protected function createChildren():void
		{
			if (!firstButton)
			{
				firstButton = new ButtonBarButtonClassFactory(ButtonBarButton);
				firstButton.skinClass = spark.skins.android5.ButtonBarButtonSkin;
			}
			
			if (!lastButton)
			{
				lastButton = new ButtonBarButtonClassFactory(ButtonBarButton);
				lastButton.skinClass = spark.skins.android5.ButtonBarButtonSkin;
			}
			
			if (!middleButton)
			{
				middleButton = new ButtonBarButtonClassFactory(ButtonBarButton);
				middleButton.skinClass = spark.skins.android5.ButtonBarButtonSkin;
			}
			
			// create the data group to house the buttons
			if (!dataGroup)
			{
				dataGroup = new DataGroup();
				var hLayout:HorizontalLayout = new HorizontalLayout();
				hLayout.gap = 0;
				hLayout.verticalAlign = VerticalAlign.CONTENT_JUSTIFY;
				hLayout.useVirtualLayout = false;
				
				dataGroup.layout = hLayout;
				addChild(dataGroup);
			}
		}
		
		/**
		 *  @private
		 */
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			// backgroundAlpha style is not supported by ButtonBar
			// TabbedViewNavigatorSkin sets a hard-coded value to support
			// overlayControls
			var backgroundAlphaValue:* = getStyle("backgroundAlpha");
			var backgroundAlpha:Number = (backgroundAlphaValue === undefined) ? 1 : getStyle("backgroundAlpha");
			
			graphics.beginFill(getStyle("chromeColor"), backgroundAlpha);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
			//add in bottom border
			graphics.lineStyle(flatheight, getStyle("borderColor"), 1, true); 
			graphics.drawRect(0, 0, unscaledWidth - 1, unscaledHeight - 1);
		}
	}
}

