package spark.skins.android5 
{
	
	import mx.core.DPIClassification;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.TextInput;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalAlign;
	import spark.skins.android5.supportClasses.MobileSkin;

	public class NumericStepperSkin extends MobileSkin
	{
		public var incrementButton:Button;
		public var decrementButton:Button;
		public var textDisplay:TextInput;
		
		public function NumericStepperSkin()
		{
			super();
			switch (applicationDPI)
			{
				case DPIClassification.DPI_640:
				{
					measuredDefaultWidth = 432;
					measuredDefaultHeight = 144;
					break;
				}
				case DPIClassification.DPI_480:
				{
					measuredDefaultWidth = 324;
					measuredDefaultHeight = 108;
					break;
				}
				case DPIClassification.DPI_320:
				{
					measuredDefaultWidth = 216;
					measuredDefaultHeight = 72;
					break;
				}
				case DPIClassification.DPI_240:
				{
					measuredDefaultWidth = 135;
					measuredDefaultHeight = 45;
					break;
				}
				case DPIClassification.DPI_120:
				{
					measuredDefaultWidth = 81;
					measuredDefaultHeight = 27;
					break;
				}
				default:
				{
					measuredDefaultWidth = 108;
					measuredDefaultHeight = 36;
					break;
				}
			}

		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 0;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			var group:Group = new Group();
			group.layout = layout;
			group.width = measuredDefaultWidth;
			group.height = measuredDefaultHeight;
			addChild(group);
			
			decrementButton = new Button();
			decrementButton.styleName = "numericStepperBTN";
			decrementButton.height = decrementButton.width = measuredDefaultHeight;
			group.addElement(decrementButton);
			
			textDisplay = new TextInput;
			textDisplay.styleName = "numericStepper"; 
			textDisplay.editable = false;
			textDisplay.bottom = 0;
			textDisplay.height = textDisplay.width = measuredDefaultHeight;
			group.addElement(textDisplay);
			
			incrementButton = new Button();
			incrementButton.styleName = "numericStepperBTN";
			incrementButton.rotation = 180;
			incrementButton.height = incrementButton.width = measuredDefaultHeight;
			group.addElement(incrementButton);
		}		
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// super draws a transparent hit zone
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
		
		
	}
}