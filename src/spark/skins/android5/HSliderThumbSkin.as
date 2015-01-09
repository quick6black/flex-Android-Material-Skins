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

import mx.core.DPIClassification;

import spark.components.Button;
import spark.skins.mobile.supportClasses.MobileSkin;

/**
 *  Android 4.x specific ActionScript-based skin for the HSlider thumb skin part in mobile applications.
 *
 *  <p>Note that this particular implementation defines a hit zone which is larger than
 *  the visible thumb for better usability on mobile screens.</p>
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 2.5 
 *  @productversion Flex 4.5
 */

[Style(name="symbolColor", type="uint", format="Color", inherit="yes", theme="spark,mobile")]
[Style(name="selectionColor", type="uint", format="Color", inherit="yes")]


public class HSliderThumbSkin extends MobileSkin
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
     * 
     */
    public function HSliderThumbSkin()
    {
        super();
		
        // set the dimensions to use based on the screen density
        switch (applicationDPI)
        {
			case DPIClassification.DPI_640:
			{
				thumbImageWidth = 116;
				thumbImageHeight = 116;
				
				hitZoneOffset = 20;
				hitZoneSideLength = 160;
				
				break;              
			}
			case DPIClassification.DPI_480:
			{
				// Note provisional may need changes
				thumbImageWidth = 88;
				thumbImageHeight = 88;
				
				hitZoneOffset = 20;
				hitZoneSideLength = 130;
				
				break;
			}
            case DPIClassification.DPI_320:
            {
                thumbImageWidth = 58;
                thumbImageHeight = 58;
                
                hitZoneOffset = 10;
                hitZoneSideLength = 80;
                
                break;              
            }
			case DPIClassification.DPI_240:
			{
				thumbImageWidth = 44;
				thumbImageHeight = 44;
				
				hitZoneOffset = 10;
				hitZoneSideLength = 65;
				
				break;
			}
			case DPIClassification.DPI_120:
			{
				thumbImageWidth = 22;
				thumbImageHeight = 22;
				
				hitZoneOffset = 5;
				hitZoneSideLength = 33;
				
				break;
			}
            default:
            {
                // default DPI_160
                thumbImageWidth = 35;
                thumbImageHeight = 35;
                
                hitZoneOffset = 5;
                hitZoneSideLength = 40;
                
                break;
            }
                
        }
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    /** 
     * @copy spark.skins.spark.ApplicationSkin#hostComponent
     */
    public var hostComponent:Button;
    
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  Width of the overall thumb image
     *
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */    
    protected var thumbImageWidth:int;
    
    /**
     *  Height of the overall thumb image
     *
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */    
    protected var thumbImageHeight:int;
    
    /**
     *  Length of the sizes of the hitzone (assumed to be square)
     *
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */
    protected var hitZoneSideLength:int;
    
    /**
     *  Distance between the left edge of the hitzone and the left edge
     *  of the thumb
     *
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */
    protected var hitZoneOffset:int;
    
    /**
     *  @private
     *  Remember which state is currently being displayed 
     */    
    private var displayedState:String;
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private 
     */ 
    override protected function commitCurrentState():void
    {       
        displayedState = currentState;     
        invalidateDisplayList();
    }
    
    /**
     *  @private 
     */ 
    override protected function measure():void
    {
        measuredWidth = thumbImageWidth;
        measuredHeight = thumbImageHeight;
    }
    
    /**
     *  @private 
     */ 
    override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
    {
        super.layoutContents(unscaledWidth, unscaledHeight);
    }
    
    /**
     *  @private 
     */ 
    override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
    {
		var symbolColor:uint = getStyle("symbolColor");
		var selectionColor:uint = getStyle("selectioncolor");
        // put in a larger hit zone than the thumb
        graphics.beginFill(0xffffff, 0);
        graphics.drawRect(-hitZoneOffset, -hitZoneOffset, hitZoneSideLength, hitZoneSideLength);
        graphics.endFill();
		if (currentState == "down")
		{
			graphics.beginFill(selectionColor, .3);
			graphics.drawCircle(unscaledWidth/2, unscaledHeight/2, thumbImageHeight/2);
			graphics.endFill();
			graphics.beginFill(symbolColor, 1);
			graphics.drawCircle(unscaledWidth/2, unscaledHeight/2, thumbImageHeight/4);
			graphics.endFill();
		}
		if (currentState == "up")
		{
			graphics.beginFill(symbolColor, 1);
			graphics.drawCircle(unscaledWidth/2, unscaledHeight/2, thumbImageHeight/4 - 2);
			graphics.endFill();
		}
    }
}
}