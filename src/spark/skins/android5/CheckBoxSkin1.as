package spark.skins.android5
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.core.DPIClassification;
	
	import spark.skins.mobile.supportClasses.ButtonSkinBase;
	
	public class CheckBoxSkin1 extends ButtonSkinBase
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		static private const exclusions:Array = ["labelDisplay", "labelDisplayShadow"];
		
		/* Define the symbol fill items that should be colored by the "symbolColor" style. */
		static private const symbols:Array = [];
		
		protected var icon:Sprite;
		protected var checkField:TextField;
		protected var checkSize:Number;
		protected var layoutCornerEllipseSize:uint;
		
		public function CheckBoxSkin1()
		{
			super();
			layoutPaddingLeft = 0;
			layoutPaddingRight = 0;
			layoutPaddingTop = 0;
			layoutPaddingBottom = 0;
			
			// Instruct the super class to ignore the "icon" style.
			// Instead, we're going to use the protected members
			// (initialized in the sub-classes):
			useIconStyle = false;
			useSymbolColor = true;
			useCenterAlignment = false;
			
			switch (applicationDPI)
			{
				case DPIClassification.DPI_640:
				{
					layoutGap = 32;
					minWidth = 128;
					minHeight = 128;
					layoutCornerEllipseSize = 28;
					
					break;
				}
				case DPIClassification.DPI_480:
				{
					layoutGap = 24;
					minWidth = 96;
					minHeight = 96;
					layoutCornerEllipseSize = 20;
					
					break;
				}
				case DPIClassification.DPI_320:
				{
					layoutGap = 16;
					minWidth = 64;
					minHeight = 64;
					layoutCornerEllipseSize = 20;
					
					break;
				}
				case DPIClassification.DPI_240:
				{
					layoutGap = 12;
					minWidth = 48;
					minHeight = 48;
					layoutCornerEllipseSize = 10;
					
					break;
				}
				case DPIClassification.DPI_120:
				{
					layoutGap = 6;
					minWidth = 24;
					minHeight = 24;
					layoutCornerEllipseSize = 8;
					
					break;
				}
				default:
				{
					layoutGap = 8;
					minWidth = 32;
					minHeight = 32;
					layoutCornerEllipseSize = 10;
					
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
		override protected function get symbolItems():Array
		{
			return symbols;
		}
		
		/**
		 *  @private 
		 */
		override protected function commitCurrentState():void
		{
			super.commitCurrentState();
			
			// check for selected or not selected
			if (currentState != null)
			{
				drawCheck(unscaledWidth, unscaledHeight);
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// Base size is 20x20
			// Since we are mobile we are making it a bit bigger (26x26).
			checkSize = minHeight - 2;
			icon = new Sprite();
			icon.graphics.beginFill(0x009688);
			icon.graphics.drawRoundRect(0, 0, checkSize, checkSize, layoutCornerEllipseSize, layoutCornerEllipseSize);
			icon.graphics.endFill();
			icon.x = icon.y = 1;
			
			checkField = new TextField();
			//checkField.defaultTextFormat = new TextFormat("Arial", 21, 0x000000);
			checkField.embedFonts = true;
			checkField.text = "Chedck";
			checkField.autoSize = TextFieldAutoSize.CENTER;
			checkField.x = 3.5;
			checkField.y = 5;
			checkField.cacheAsBitmap = true;
			setIcon(icon);
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			checkSize = unscaledHeight - 2;
			drawCheck(unscaledWidth, unscaledHeight);
			checkField.scaleX = checkField.scaleY = checkSize / minHeight;
			checkField.x = 3.5 * checkField.scaleX;
			checkField.y = 5 * checkField.scaleX;
			
			super.layoutContents(unscaledWidth, unscaledHeight);
		}
		
		/**
		 *  @private 
		 */
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			// Draw a transparent hit area
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
			
			drawCheck(unscaledWidth, unscaledHeight);
		}
		
		protected function drawCheck(unscaledWidth:Number, unscaledHeight:Number):void
		{
			icon.graphics.clear();
			var fillColor:uint;
			if (currentState.indexOf("Selected") > -1) 
			{
				fillColor = 0xFFFFFF;
				
				if (checkField.parent == null) 
				{
					icon.addChild(checkField);
				}
				
			} 
			else if (currentState == "down") 
			{
				fillColor = 0xFFFF00;
				if (checkField.parent == null) 
				{
					icon.addChild(checkField);
				}
			} 
			else 
			{
				fillColor = 0xFF00FF;				
				if (checkField.parent != null) 
				{
					checkField.parent.removeChild(checkField);
				}
				
			}
			
			icon.graphics.beginFill(fillColor);
			icon.graphics.drawRoundRect(0, 0, checkSize, checkSize, layoutCornerEllipseSize, layoutCornerEllipseSize);
			icon.graphics.endFill();
		}
		
		/**
		 *  @private
		 */
		override protected function get focusSkinExclusions():Array 
		{
			return exclusions;
		}
	}
}