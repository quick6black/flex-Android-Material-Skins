package spark.skins.android5
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.material.components.InkRipple;
	import spark.skins.spark.DefaultItemRenderer;
	
	public class LabelItemRenderer extends spark.skins.spark.DefaultItemRenderer
	{
		public var inkHolder:Group;
		
		public function LabelItemRenderer()
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.maxDisplayedLines = 1;
			labelDisplay.setStyle("paddingLeft", 15);
			labelDisplay.setStyle("paddingRight", 15);
			labelDisplay.setStyle("paddingTop", 15);
			labelDisplay.setStyle("paddingBottom", 10);
			
			
			if(!inkHolder)
			{
				inkHolder = new Group();
				inkHolder.clipAndEnableScrolling = true;
				addChild(DisplayObject(inkHolder));
			}
		}
		
		protected var currentRipple:InkRipple;
		
		
		private function mouseEventHandler(event:MouseEvent):void
		{			
			if(currentRipple)
				currentRipple.isMouseDown = false;
			
			if(event.type == MouseEvent.MOUSE_DOWN)
			{			
				var rippleRadius:Number = Math.sqrt(width*width+height*height);
				currentRipple = new InkRipple(event["localX"], event["localY"], rippleRadius*2, getStyle("inkColor"), 1200);
				currentRipple.owner = inkHolder;
				inkHolder.addElement(currentRipple);
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);
				addEventListener(MouseEvent.MOUSE_UP, mouseEventHandler);
				systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
			}
			else if(event.type == MouseEvent.MOUSE_UP)
			{
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, event.localX, event.localY, event.relatedObject,event.ctrlKey));
				addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);
				destroyRipples();
				systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
			}
		}
		
		private function systemManager_mouseUpHandler(event:Event):void
		{
			if (event.target == this) return;
			
			destroyRipples();
		}
		
		protected function destroyRipples():void
		{
			for(var i:int=0; i < inkHolder.numElements; i++)
			{
				inkHolder.getElementAt(i)["destroy"](true);
			}
		}
		
		override protected function measure():void
		{
			super.measure();
			
			// label has padding of 3 on left and right and padding of 5 on top and bottom.
			measuredWidth = labelDisplay.getPreferredBoundsWidth() + 15;
			measuredHeight = labelDisplay.getPreferredBoundsHeight() + 3;
			
			measuredMinWidth = labelDisplay.getMinBoundsWidth() + 15;
			measuredMinHeight = labelDisplay.getMinBoundsHeight() + 3;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(selected && getStyle("selectedItemTextColor") != undefined)
				labelDisplay.setStyle("color", getStyle("selectedItemTextColor"));
			else
				labelDisplay.setStyle("color", getStyle("color"));
			
			labelDisplay.setLayoutBoundsPosition(0,0);
			inkHolder.setActualSize(unscaledWidth, unscaledHeight);
		}
	}	
}
