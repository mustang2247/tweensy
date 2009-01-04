package com.flashdynamix.motion.plugins {
	import com.flashdynamix.motion.TweensyTimeline;	

	/**
	 * This abstract tween class provides necessary functionality to the typed plugin
	 * tweens.
	 */
	public class AbstractTween {

		public var inited : Boolean = false;
		public var timeline : TweensyTimeline;
		
		protected var propNames : Object = {};
		protected var _propCount : int = 0;

		public function AbstractTween() {
		}

		public function construct(...params : Array) : void {
			inited = false;
		}

		public function get key() : Object {
			return null;
		}

		protected function set to(item : Object) : void {
		}

		protected function get to() : Object {
			return null;
		}

		protected function set from(item : Object) : void {
		}

		protected function get from() : Object {
			return null;
		}

		protected function get current() : Object {
			return null;
		}

		protected function get properties() : Number {
			return _propCount;
		}

		public function get hasAnimations() : Boolean {
			return (_propCount > 0);
		}

		public function add(propName : String, target : *, isFrom : Boolean) : void {
			if(isFrom) {
				to[propName] = current[propName];
				current[propName] = translate(propName, target);
			} else {
				to[propName] = translate(propName, target);
			}
			
			if(!propNames[propName]) {
				propNames[propName] = true;
				_propCount++;
			}
		}

		public function remove(propName : String) : void {
			if(propNames[propName] == null) return;
			
			delete propNames[propName];
			_propCount--;
		}

		public function has(propName : String) : Boolean {
			return (propNames[propName] != null);
		}

		public function toTarget(item : Object) : void {
			for(var propName:String in item) {
				add(propName, item[propName], false);
			}
		}

		public function fromTarget(item : Object) : void {
			for(var propName:String in item) {
				add(propName, item[propName], true);
			}
		}

		public function updateTo(position : Number, item : Object) : void {
			for(var propName:String in item) {
				if(has(propName)) {
					var target : Number = item[propName];
					var change : Number = (target - current[propName]) * (1 / (1 - position));
					
					from[propName] = target - change;
					to[propName] = target;
				}
			}
		}

		public function removeOverlap(item : AbstractTween) : void {
			if(item.key == key) {
				for(var propName:String in item.propNames) remove(propName);
			}
		}

		public function stop(...props : Array) : void {
			var len : int = props.length;
			var i : int;
			
			for(i = 0;i < len; i++) remove(props[i]);
		}

		public function stopAll() : void {
			for(var propName:String in propNames) remove(propName);
		}

		public function update(position : Number) : void {
		}

		public function swapToFrom() : void {
			var toCopy : Object = to;
			
			to = from;
			from = toCopy;
		}

		public function apply() : void {
		}

		public function clear() : void {
			stopAll();
			timeline = null;
		}

		public function dispose() : void {
			propNames = null;
			timeline = null;
		}

		protected function translate(propName : String, value : *) : Number {
			
			var current : Number = current[propName];
			var target : Number;
			
			if(value is String) {
				var values : Array = String(value).split(",");
				if(values.length == 1) {
					target = current + parseFloat(value);
				} else {
					var start : Number = parseFloat(values[0]), end : Number = parseFloat(values[1]);
					target = current + start + (Math.random() * (end - start));
				}
			} else {
				target = value;
			}
			
			return target;
		}

		protected function smartRotate(currentAngle : Number, targetAngle : Number) : Number {
			var pi : Number = 180;
			var pi2 : Number = pi * 2;
				
			currentAngle = (Math.abs(currentAngle) > pi2) ? (currentAngle < 0) ? currentAngle % pi2 + pi2 : currentAngle % pi2 : currentAngle;

			targetAngle = (Math.abs(targetAngle) > pi2) ? (targetAngle < 0) ? targetAngle % pi2 + pi2 : targetAngle % pi2 : targetAngle;
			targetAngle += (Math.abs(targetAngle - currentAngle) < pi) ? 0 : (targetAngle - currentAngle > 0) ? -pi2 : pi2;
			
			return targetAngle;
		}
	}
}