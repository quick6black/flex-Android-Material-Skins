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
import flash.display.Sprite;

import mx.core.DPIClassification;

import spark.skins.mobile.supportClasses.ButtonSkinBase;

/**
 *  ActionScript-based skin for RadioButton controls in mobile applications. 
 * 
 * @see spark.components.RadioButton
 * 
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 2.5 
 *  @productversion Flex 4.5
 */
public class RadioButtonSkin extends ButtonSkinBase
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     */
    static private const exclusions:Array = ["labelDisplay"];
	
	//--------------------------------------------------------------------------
	//
	//  Member variables
	//
	//--------------------------------------------------------------------------

	protected var iconWidth:Number;
	protected var iconHeight:Number;
	protected var innerWidth:Number;
	protected var centerCircle:Number;	
	protected var outerWidth:Number;
	protected var icon:Sprite;
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
     * 
     */
    public function RadioButtonSkin()
    {
        super();
        
      
        layoutPaddingTop = 0;
        layoutPaddingBottom = 0;

		useIconStyle = false;
		useSymbolColor = true;
		useCenterAlignment = false;
        switch (applicationDPI)
        {
			case DPIClassification.DPI_640:
			{
				layoutPaddingLeft = 40;
				layoutPaddingRight = 40;
				layoutGap = 40;
				minWidth = 128;
				minHeight = 128;
				iconWidth = 128;
				iconHeight = 128;
				
				centerCircle = 36;
				outerWidth = 8;			
				innerWidth = 18;
				break;
			}
            case DPIClassification.DPI_480:
            {
				layoutPaddingLeft = 32;
				layoutPaddingRight = 32;
				layoutGap = 30;
				minWidth = 96;
				minHeight = 96;
				iconWidth = 96;
				iconHeight = 96;
                
				centerCircle = 26;
				outerWidth = 6;			
				innerWidth = 12;
                break;
            }
            case DPIClassification.DPI_320:
            {
                
				layoutPaddingLeft = 20;
				layoutPaddingRight = 20;
				layoutGap = 20;
				minWidth = 64;
				minHeight = 64;
				iconWidth = 64;
				iconHeight = 64;
				
				centerCircle = 18;
				outerWidth = 4;			
				innerWidth = 9;
                break;
            }
            case DPIClassification.DPI_240:
            {
				layoutPaddingLeft = 16;
				layoutPaddingRight = 16;
				layoutGap = 15;
				minWidth = 48;
				minHeight = 48;
				iconWidth = 48;
				iconHeight = 48;
				
				centerCircle = 13;
				outerWidth = 3;
				innerWidth = 6;
				
                break;
            }
			case DPIClassification.DPI_120:
			{
				layoutPaddingLeft = 8;
				layoutPaddingRight = 8;
				layoutGap = 6;
				minWidth = 24;
				minHeight = 24;
				iconWidth = 24;
				iconHeight = 24;
				
				centerCircle = 7;
				outerWidth = 1.5;
				innerWidth = 3;
				break;
			}
            default:
            {
				layoutPaddingLeft = 10;
				layoutPaddingRight = 10;
                layoutGap = 8;
                minWidth = 32;
                minHeight = 32;
				iconWidth = 32;
				iconHeight = 32;
               	
				centerCircle = 9;
				outerWidth = 2;
				innerWidth = 4.5;
                break;
            }
        }
    }
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
	override protected function createChildren():void
	{
		super.createChildren();
		
		icon = new Sprite();
		setIcon(icon);
		addChild(icon);
	}
	
    override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
    {
        // super draws a transparent hit zone
        super.drawBackground(unscaledWidth, unscaledHeight);
        // get the size and position of iconDisplay
        var currentIcon:DisplayObject = getIconDisplay();
 		//background
        graphics.beginFill(getStyle("chromeColor"), getStyle("backgroundAlpha"));
        graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
        graphics.endFill();
    }
    
	
	protected function drawRadioBtn(unscaledWidth:Number, unscaledHeight:Number):void
	{
		var selectColor:uint = getStyle("selectColor");
		var unselectColor:uint = getStyle("unselectColor");
		
		if (currentState == "up")
		{	
			icon.graphics.clear();
			icon.graphics.lineStyle(outerWidth, unselectColor, 1, true);
			icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
			icon.graphics.endFill();
		}
		if (currentState == "down")
		{	
			icon.graphics.clear();
			icon.graphics.beginFill(unselectColor, .3);
			icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/2);
			icon.graphics.endFill();
			
			icon.graphics.lineStyle(outerWidth, unselectColor, 1, true);
			icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
			icon.graphics.endFill();
		}			
		if (currentState == "upAndSelected")
		{	
			icon.graphics.clear();
			icon.graphics.beginFill(selectColor, 1);
			icon.graphics.drawCircle(centerCircle, centerCircle, innerWidth);
			icon.graphics.endFill();
			
			icon.graphics.lineStyle(outerWidth, 0x009688, 1, true);
			icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
			icon.graphics.endFill();
		}
		
		if (currentState == "downAndSelected")
		{	
			icon.graphics.clear();
			icon.graphics.beginFill(selectColor, .3);
			icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/2);
			icon.graphics.endFill();
			
			icon.graphics.beginFill(selectColor, 1);
			icon.graphics.drawCircle(centerCircle, centerCircle, innerWidth);
			icon.graphics.endFill();
			
			icon.graphics.lineStyle(outerWidth, selectColor, 1, true);
			icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
			icon.graphics.endFill();
		}
	}
    /**
     *  @private
     */
    override protected function get focusSkinExclusions():Array 
    {
        return exclusions;
    }
	
	override protected function commitCurrentState():void
	{
		super.commitCurrentState();

		if (currentState != null)
		{
			drawRadioBtn(unscaledWidth, unscaledHeight);
		}
	}
	
	override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.layoutContents(unscaledWidth, unscaledHeight);
	}
}
}