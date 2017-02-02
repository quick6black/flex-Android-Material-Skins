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
import spark.components.ButtonBar;
import spark.components.ButtonBarButton;
import spark.components.DataGroup;
import spark.components.supportClasses.ButtonBarHorizontalLayout;
import spark.skins.android5.ButtonBarButtonSkin;
import spark.skins.mobile.supportClasses.MobileSkin;
import spark.skins.mobile.supportClasses.ButtonBarButtonClassFactory;

/**
 *  The Android 5.x specific skin class for the Spark ButtonBar component.
 *
 *  @see spark.components.ButtonBar
 *
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 2.5
 *  @productversion Flex 4.5
 */

public class ButtonBarSkin extends MobileSkin
{
    public function ButtonBarSkin()
    {
        super();
    }

    public var hostComponent:ButtonBar;
    public var firstButton:ButtonBarButtonClassFactory;
    public var lastButton:ButtonBarButtonClassFactory;
    public var middleButton:ButtonBarButtonClassFactory;
    public var dataGroup:DataGroup;

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
        if (!dataGroup)
        {
            dataGroup = new DataGroup();
            var hLayout:ButtonBarHorizontalLayout = new ButtonBarHorizontalLayout();
            hLayout.gap = 0;
            dataGroup.layout = hLayout;
            addChild(dataGroup);
        }
    }
    
	override protected function commitCurrentState():void
    {
        alpha = (currentState == "disabled") ? 0.5 : 1;
    }
    
    override protected function measure():void
    {
        measuredWidth = dataGroup.measuredWidth;
        measuredHeight = dataGroup.measuredHeight;     
        measuredMinWidth = dataGroup.measuredMinWidth;
        measuredMinHeight = dataGroup.measuredMinHeight;
    }
    
    override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
    {
        super.layoutContents(unscaledWidth, unscaledHeight);
        
        setElementPosition(dataGroup, 0, 0);
        setElementSize(dataGroup, unscaledWidth, unscaledHeight);
    }
}
}