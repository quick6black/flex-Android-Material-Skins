////////////////////////////////////////////////////////////////////////////////
//
// Class is from https://github.com/rui-cruz/Spark-Material/blob/master/FlexSparkMaterial/src/spark/material/components/InkRipple.as
//  
////////////////////////////////////////////////////////////////////////////////

package spark.skins.android5.supportClasses
{
	import mx.events.EffectEvent;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.effects.Animate;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
	import spark.effects.easing.Sine;
	import spark.primitives.Ellipse;
		
	public class InkRipple extends Ellipse
	{
		public var isMouseDown:Boolean = true;
		
		private var growAnimation:Animate;
		private var alphaMotion:SimpleMotionPath;
		
		public function InkRipple(_x:Number, _y:Number, _size:Number=200, color:uint=0x999999, duration:Number=400)
		{
			super();
			
			x = _x;
			y = _y;
			width = 1;
			height = 1;
			fill = new SolidColor(color);
			alpha = .4;
			
			growAnimation = new Animate(this);
			growAnimation.easer = new Sine(0);
			growAnimation.disableLayout = false;
			growAnimation.suspendBackgroundProcessing = true;
			growAnimation.duration = duration;
			growAnimation.motionPaths = new Vector.<MotionPath>;
			
			var widthMotion:SimpleMotionPath = new SimpleMotionPath("width", 1, _size);
			var heightMotion:SimpleMotionPath = new SimpleMotionPath("height", 1, _size);
			var xMotion:SimpleMotionPath = new SimpleMotionPath("x", _x, _x-(_size*.5));
			var yMotion:SimpleMotionPath = new SimpleMotionPath("y", _y, _y-(_size*.5));
			alphaMotion = new SimpleMotionPath("alpha", .4, .2);
			
			growAnimation.motionPaths.push(widthMotion);
			growAnimation.motionPaths.push(heightMotion);
			growAnimation.motionPaths.push(xMotion);
			growAnimation.motionPaths.push(yMotion);
			growAnimation.motionPaths.push(alphaMotion);
						
			growAnimation.addEventListener(EffectEvent.EFFECT_END, onGrowed);
			growAnimation.play();
		}
		
		public function onGrowed(evt:EffectEvent):void
		{
			growAnimation.removeEventListener(EffectEvent.EFFECT_END, onGrowed);
			
			if(!isMouseDown && alpha > 0)
				destroy();
		}
		
		public function destroy(force:Boolean=false):void
		{
			isMouseDown = false;
			
			if(growAnimation.isPlaying && !force)
			{
				growAnimation.removeEventListener(EffectEvent.EFFECT_END, onGrowed);
				growAnimation.pause();
				alphaMotion.valueTo = 0;
			}
			else
			{
				growAnimation.duration = 400;
				growAnimation.motionPaths = new Vector.<MotionPath>;
				alphaMotion = new SimpleMotionPath("alpha", alpha, 0);
				growAnimation.motionPaths.push(alphaMotion);
			}
			
			growAnimation.addEventListener(EffectEvent.EFFECT_END, onTransparent);
			growAnimation.play();
		}
		
		public function onTransparent(evt:EffectEvent):void
		{
			growAnimation.removeEventListener(EffectEvent.EFFECT_END, onTransparent);
			if((owner as Group).getElementIndex(this) != -1)
				(owner as Group).removeElement(this);
		}
	}
}