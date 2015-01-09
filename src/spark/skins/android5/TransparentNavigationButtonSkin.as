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
import flash.display.DisplayObject;
import flash.display.Graphics;

import mx.core.DPIClassification;
import mx.core.mx_internal;

import spark.skins.mobile.supportClasses.ButtonSkinBase;

/**
 *  The default skin class for buttons in the navigation area of the Spark ActionBar component 
 *  in mobile applications.  
 * 
 *  @langversion 3.0
 *  @playerversion AIR 2.5 
 *  @productversion Flex 4.5
 */
public class TransparentNavigationButtonSkin extends spark.skins.mobile.supportClasses.ButtonSkinBase
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
     *  @playerversion AIR 2.5 
     *  @productversion Flex 4.5
     * 
     */
    public function TransparentNavigationButtonSkin()
    {
        super();
        
        switch (applicationDPI)
        {
			case DPIClassification.DPI_640:
			{
				layoutGap = 20;	
				layoutPaddingLeft = 20;
				layoutPaddingRight = 20;
				layoutPaddingTop = 20;
				layoutPaddingBottom = 20;			
				measuredDefaultWidth = 172;
				measuredDefaultHeight = 172;
			
				break;
			}
			case DPIClassification.DPI_480:
			{
				layoutGap = 14;	
				layoutPaddingLeft = 16;
				layoutPaddingRight = 16;
				layoutPaddingTop = 0;
				layoutPaddingBottom = 0;			
				measuredDefaultWidth = 130;
				measuredDefaultHeight = 130;
	
				break;
			}
			case DPIClassification.DPI_320:
			{
				layoutGap = 10;	
				layoutPaddingLeft = 10;
				layoutPaddingRight = 10;
				layoutPaddingTop = 10;
				layoutPaddingBottom = 10;			
				measuredDefaultWidth = 86;
				measuredDefaultHeight = 86;
				
				break;
			}
			case DPIClassification.DPI_240:
			{	
				layoutGap = 7;	
				layoutPaddingLeft = 8;
				layoutPaddingRight = 8;
				layoutPaddingTop = 8;
				layoutPaddingBottom = 8;			
				measuredDefaultWidth = 65;
				measuredDefaultHeight = 65;
	
				break;
			}
			case DPIClassification.DPI_120:
			{
				layoutGap = 4;	
				layoutPaddingLeft = 4;
				layoutPaddingRight = 4;
				layoutPaddingTop = 4;
				layoutPaddingBottom = 4;			
				measuredDefaultWidth = 32;
				measuredDefaultHeight = 32;
				
				break;
			}	
			default:
			{
				// default DPI_160
				layoutGap = 5;	
				layoutPaddingLeft = 5;
				layoutPaddingRight = 5;
				layoutPaddingTop = 5;
				layoutPaddingBottom = 5;			
				measuredDefaultWidth = 43;
				measuredDefaultHeight = 43;
		
				break;
			}
        }
    }
	
	override protected function commitCurrentState():void
	{   
		super.commitCurrentState();	
		// update borderClass and background
		invalidateDisplayList();
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
			graphics.beginFill(downColor,downAlpha);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
		else
		{
			graphics.beginFill(chromeColor, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
	}
}
}