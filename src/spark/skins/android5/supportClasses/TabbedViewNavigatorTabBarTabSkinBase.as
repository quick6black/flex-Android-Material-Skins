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

package spark.skins.android5.supportClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.text.TextLineMetrics;
	
	import mx.core.DPIClassification;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	
	import spark.components.ButtonBarButton;
	import spark.components.IconPlacement;
	import spark.components.supportClasses.ButtonBase;
	import spark.components.supportClasses.ViewNavigatorBase;
	import spark.skins.android5.ButtonBarButtonSkin;
	import spark.skins.mobile.ButtonSkin;
	
	use namespace mx_internal;
	
	/**
	 *  ButtonBarButton skin base class for TabbedViewNavigator ButtonBarButtons.
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 2.5 
	 *  @productversion Flex 4.5
	 */
	public class TabbedViewNavigatorTabBarTabSkinBase extends ButtonBarButtonSkin
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		public function TabbedViewNavigatorTabBarTabSkinBase()
		{
			super();
			
			useCenterAlignment = false;
			
			switch (applicationDPI)
			{
				case DPIClassification.DPI_640:
				{
					layoutPaddingTop = 24;
					layoutPaddingBottom = 24;
					layoutPaddingLeft = 24;
					layoutPaddingRight = 24;
					break;
				}
				case DPIClassification.DPI_480:
				{
					// Note provisional may need changes
					layoutPaddingTop = 18;
					layoutPaddingBottom = 18;
					break;
				}
				case DPIClassification.DPI_320:
				{
					layoutPaddingTop = 12;
					layoutPaddingBottom = 20;
					break;
				}
				case DPIClassification.DPI_240:
				{
					layoutPaddingTop = 9;
					layoutPaddingBottom = 15;
					break;
				}
				case DPIClassification.DPI_120:
				{
					// Note provisional may need changes
					layoutPaddingTop = 4.5;
					layoutPaddingBottom = 7.5;
					break;
				}
				default:
				{
					// default DPI_160
					layoutPaddingTop = 6;
					layoutPaddingBottom = 10;
					layoutPaddingLeft = 12;
					layoutPaddingRight = 12;
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
		override public function set hostComponent(value:ButtonBase):void
		{
			if (hostComponent)
			{
				hostComponent.removeEventListener(FlexEvent.DATA_CHANGE, dataChanged);
			}
			
			super.hostComponent = value;
			
			// look for enabled in hostComponent data
			if (hostComponent)
			{
				hostComponent.addEventListener(FlexEvent.DATA_CHANGE, dataChanged);
				dataChanged();
			}
		}
		
		/**
		 *  @private
		 */
		override protected function commitDisabled():void
		{
			var alphaValue:Number = (currentState.indexOf("disabled") >= 0) ? 0.25 : 1;
			
			labelDisplay.alpha = alphaValue;
			//labelDisplayShadow.alpha = alphaValue;
			
			var icon:DisplayObject = getIconDisplay();
			
			if (icon != null)
				icon.alpha = alphaValue;
		}
		
		/**
		 *  @private
		 */
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// omit super.drawBackground() to drawRect instead
			// use transparent ButtonBarButtons to support ViewNavigatorBase#overlayControls
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
		
		/**
		 *  @private
		 *  Set enabled on ButtonBarButton host component based on ViewNavigator
		 *  enabled value.
		 */
		private function dataChanged(event:Event=null):void
		{
			var buttonBarButtonHost:ButtonBarButton = ButtonBarButton(hostComponent);
			
			// TabbedViewNavigator dataProvider for ButtonBar is
			// navigators:Vector.<ViewNavigatorBase>
			if (buttonBarButtonHost.data && (buttonBarButtonHost.data is ViewNavigatorBase))
			{
				var viewNavigator:ViewNavigatorBase = ViewNavigatorBase(buttonBarButtonHost.data);
				viewNavigator.addEventListener("enabledChanged", dataEnabledChanged);
				
				dataEnabledChanged();
			}
		}
		
		/**
		 *  @private
		 *  Update enabled state when ViewNavigator enabled value changes.
		 */
		private function dataEnabledChanged(event:Event=null):void
		{
			hostComponent.enabled = ViewNavigatorBase(ButtonBarButton(hostComponent).data).enabled;
		}
	}
}