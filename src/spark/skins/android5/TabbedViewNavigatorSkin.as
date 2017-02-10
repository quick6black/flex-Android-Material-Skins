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

import spark.components.ButtonBar;
import spark.components.Group;
import spark.components.TabbedViewNavigator;
import spark.components.supportClasses.ButtonBarBase;
import spark.skins.mobile.supportClasses.MobileSkin;

public class TabbedViewNavigatorSkin extends MobileSkin
{
	public var hostComponent:TabbedViewNavigator;
	public var contentGroup:Group;
	public var tabBar:ButtonBarBase;
	private var _isOverlay:Boolean;
	private var tabBarHeight:Number; 
	
    public function TabbedViewNavigatorSkin()
    {
        super();
		switch (applicationDPI)
		{			
			case DPIClassification.DPI_640:
			{			
				tabBarHeight = 224;
				break;
			}
			case DPIClassification.DPI_480:
			{		
				tabBarHeight = 168;
				break;
			}
			case DPIClassification.DPI_320:
			{              
				tabBarHeight = 112;
				break;
			}
			case DPIClassification.DPI_240:
			{		
				tabBarHeight = 84;
				break;
			}
			case DPIClassification.DPI_120:
			{			
				tabBarHeight = 42;
				break;
			}
			default:
			{        
				tabBarHeight = 56;
				break;
			}
		}
    }


    override protected function createChildren():void
    {
        if (!contentGroup)
        {
            contentGroup = new Group();
            contentGroup.id = "contentGroup";
            addChild(contentGroup);
        }     
        if (!tabBar)
        {
            tabBar = new ButtonBar();
            tabBar.id = "tabBar";
            tabBar.requireSelection = true;
            addChild(tabBar);
        }
    }
    
    override protected function commitCurrentState():void
    {
        super.commitCurrentState();
        
        _isOverlay = (currentState.indexOf("Overlay") >= 1);
        
        // Force a layout pass on the components
        invalidateProperties();
        invalidateSize();
        invalidateDisplayList();
    }
    
    override protected function measure():void
    {
        super.measure();
        
        measuredWidth = Math.max(tabBar.getPreferredBoundsWidth(), contentGroup.getPreferredBoundsWidth());
        
        if (currentState == "portraitAndOverlay" || currentState == "landscapeAndOverlay")
        {
            measuredHeight = Math.max(tabBar.getPreferredBoundsHeight(), contentGroup.getPreferredBoundsHeight());
        }
        else
        {
            measuredHeight = tabBar.getPreferredBoundsHeight() + contentGroup.getPreferredBoundsHeight();
        }
    }

    override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
    {
        super.layoutContents(unscaledWidth, unscaledHeight);       
        
		var tabLocation:String = getStyle("tabLocation");
        if (tabBar.includeInLayout)
        {
            tabBar.setLayoutBoundsSize(unscaledWidth, tabBarHeight);
			if (tabLocation == "top")
			{
				tabBar.setLayoutBoundsPosition(0, 43);
			}
			else 
			{ 
				tabBar.setLayoutBoundsPosition(0, unscaledHeight - tabBarHeight);
			}
            tabBarHeight = tabBar.getLayoutBoundsHeight();   
            // backgroundAlpha is not a declared style on ButtonBar
            // TabbedViewNavigatorButtonBarSkin implements for overlay support
            var backgroundAlpha:Number = (_isOverlay) ? 0.75 : 1;
            tabBar.setStyle("backgroundAlpha", 0);
        }
        
        if (contentGroup.includeInLayout)
        {
            var contentGroupHeight:Number = (_isOverlay) ? unscaledHeight : Math.max(unscaledHeight - tabBarHeight, 0);
            contentGroup.setLayoutBoundsSize(unscaledWidth, contentGroupHeight);
			if (tabLocation == "top")
			{
            	contentGroup.setLayoutBoundsPosition(0, 43, false);
			}
			else
			{
				contentGroup.setLayoutBoundsPosition(0, 0);
			}
        }
    }
}
}