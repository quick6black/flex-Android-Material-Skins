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
	import spark.skins.android5.supportClasses.TabbedViewNavigatorTabBarTabSkinBase;
	
	[Style(name="downColor", type="uint", format="Color", inherit="yes")]
	[Style(name="selectColor", type="uint", format="Color", inherit="yes")]
	
	public class TabbedViewNavigatorButtonSkin extends TabbedViewNavigatorTabBarTabSkinBase
	{	
		public function TabbedViewNavigatorButtonSkin()
		{
			super();
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			var chromeColor:uint = getStyle("chromeColor");
			var downColor:uint = getStyle("downColor");
			var selectColor:uint = getStyle("selectColor");
			var downAlpha:Number = getStyle("downAlpha");
			var backgroundAlpha:Number = getStyle("backgroundAlpha");
			
			if (currentState == "down")
			{	
				graphics.beginFill(downColor, backgroundAlpha);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
			}
			if (currentState == "downAndSelected")
			{	
				graphics.beginFill(selectColor, backgroundAlpha);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
			}
			if (currentState == "upAndSelected")
			{
				graphics.beginFill(selectColor, backgroundAlpha);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
				destroyRipples();
			}
			if (currentState == "overAndSelected")
			{
				graphics.beginFill(downColor, backgroundAlpha);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
			}
			if (currentState == "up")
			{
				graphics.beginFill(chromeColor, backgroundAlpha);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
				destroyRipples();
			}
		}
	}
}