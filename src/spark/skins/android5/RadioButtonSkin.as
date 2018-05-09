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
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.effects.Animate;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
	import spark.effects.easing.Sine;
	import spark.material.components.InkRipple;
	import spark.primitives.Ellipse;
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
	
	[Style(name="inkColor", type="uint", format="Color", inherit="yes", defaultValue="#999999")]
	
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
		
		public var inkHolder:Group;
		
		public var centerCircles:Group;
		private var currentRipple:InkRipple; 
		
		private var ellipse:Ellipse = new Ellipse();		
		private var growAnimation:Animate;
		
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
					layoutGap = 12;
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
					layoutGap = 8;
					minWidth = 32;
					minHeight = 32
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
			
			inkHolder = new Group();
			inkHolder.id = "inkHolder";
			
			centerCircles = new Group();
			centerCircles.id = "centerCircles";
			
			icon = new Sprite();
			setIcon(icon);	
			
			addChild(inkHolder);		
			addChild(icon);
			addChild(centerCircles);
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			setElementPosition(centerCircles, centerCircle, unscaledHeight /2);
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// super draws a transparent hit zone
			super.drawBackground(unscaledWidth, unscaledHeight);
			// get the size and position of Display
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
			var disabledColor:uint = getStyle("disabledColor");
			
			if (currentState == "up")
			{	
				icon.graphics.clear();
				icon.graphics.lineStyle(outerWidth, unselectColor, 1, true);
				icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
				icon.graphics.endFill();
				centerCircles.removeAllElements();
			}
			if (currentState == "down")
			{	
				icon.graphics.clear();			
				icon.graphics.lineStyle(outerWidth, unselectColor, 1, true);
				icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
				icon.graphics.endFill();
				addRipples();
			}			
			if (currentState == "upAndSelected")
			{	
				if (centerCircles.numElements == 0)
				{			
					ellipse.alpha = 0;
					ellipse.horizontalCenter = 0;
					ellipse.verticalCenter = 0;
					ellipse.fill = new SolidColor(selectColor);
					centerCircles.addElement(ellipse);			
					
					growAnimation = new Animate(ellipse);
					growAnimation.easer = new Sine(0);
					growAnimation.disableLayout = false;
					growAnimation.suspendBackgroundProcessing = true;
					growAnimation.duration = 200;
					growAnimation.motionPaths = new Vector.<MotionPath>;
					
					var widthMotion:SimpleMotionPath = new SimpleMotionPath("width", 0, centerCircle - 1);
					var heightMotion:SimpleMotionPath = new SimpleMotionPath("height", 0, centerCircle - 1);
					var alphaMotion:SimpleMotionPath = new SimpleMotionPath("alpha", 0, 1);
					var xMotion:SimpleMotionPath = new SimpleMotionPath("x", icon.x, icon.x-(unscaledWidth*.5));
					var yMotion:SimpleMotionPath = new SimpleMotionPath("y", icon.y, icon.y-(unscaledHeight*.5));
					growAnimation.motionPaths.push(widthMotion);
					growAnimation.motionPaths.push(heightMotion);
					growAnimation.motionPaths.push(alphaMotion);
					growAnimation.motionPaths.push(xMotion);
					growAnimation.motionPaths.push(yMotion);
					growAnimation.play();
				}	
				
				icon.graphics.lineStyle(outerWidth, selectColor, 1, true);
				icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
				icon.graphics.endFill();
				destroyRipples();			
			}
			
			if (currentState == "downAndSelected")
			{	
				icon.graphics.lineStyle(outerWidth, selectColor, 1, true);
				icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
				icon.graphics.endFill();
				addRipples();
			}
			if (currentState == "disabledAndSelected")
			{	
				icon.graphics.clear();
				icon.graphics.beginFill(disabledColor, .5);
				icon.graphics.drawCircle(centerCircle, centerCircle, innerWidth);
				icon.graphics.endFill();
				
				icon.graphics.lineStyle(outerWidth, disabledColor, .5, true);
				icon.graphics.drawCircle(centerCircle, centerCircle, iconWidth/4);
				icon.graphics.endFill();
			}
			if (currentState == "disabled")
			{	
				icon.graphics.clear();
				icon.graphics.lineStyle(outerWidth, disabledColor, .5, true);
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
		
		protected function destroyRipples():void 
		{ 
			for(var i:int=0; i < inkHolder.numElements; i++) 
			{ 
				inkHolder.getElementAt(i)["destroy"](true); 
			} 
		}
		
		private function addRipples():void 
		{ 
			var inkColor:uint = getStyle("inkColor");
			var rippleRadius:Number =  Math.sqrt(width*width+height*height);   
			var inkX:Number = icon.x - (layoutBorderSize /2) + icon.width /2
			var inkY:Number = icon.y - (layoutBorderSize /2) + icon.height /2
			if (inkHolder.numElements == 0)
			{
				currentRipple = new InkRipple(inkX, inkY, minWidth * 1.5, inkColor, 400); 
				currentRipple.owner = inkHolder; 
				inkHolder.addElement(currentRipple); 
			}
		} 
	}
}