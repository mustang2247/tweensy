package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;	import flash.geom.Point;	import com.flashdynamix.motion.plugins.AbstractTween;		/**	 * @author FlashDynamix	 */	public class PointTween extends AbstractTween {				public static var key : Class = Point;		private var _current : Point;		protected var _to : Point;		protected var _from : Point;		/** @private */		internal var displayObject : DisplayObject;		public function PointTween() {			_to = new Point();			_from = new Point();		}		override public function construct(currentObj : Object, updateObj : Object) : void {			inited = false;						_current = currentObj as Point;			displayObject = updateObj as DisplayObject;		}		override protected function set to(item : Object) : void {			_to = item as Point;		}		override protected function get to() : Object {			return _to;		}		override protected function set from(item : Object) : void {			_from = item as Point;		}		override protected function get from() : Object {			return _from;		}		override public function get current() : Object {			return _current;		}		override public function get instance() : Object {			return (displayObject) ? displayObject : current;		}		override protected function match(item : AbstractTween) : Boolean {			return (item is PointTween && (current == item.current || ((item as PointTween).displayObject == null || (item as PointTween).displayObject == displayObject)) );		}		override public function toTarget(toObj : Object) : void {			if(to is Point) {				var pt : Point = toObj as Point;							addTo("x", pt.x);				addTo("y", pt.y);			} else {				super.toTarget(toObj);			}		}		override public function fromTarget(fromObj : Object) : void {			if(from is Point) {				var pt : Point = fromObj as Point;							addFrom("x", pt.x);				addFrom("y", pt.y);			} else {				super.fromTarget(fromObj);			}		}		override public function update(position : Number) : void {			var q : Number = 1 - position;			var propName : String;			var i : int = 0;						if(!inited && _propCount > 0) {				if(displayObject) {					_current = new Point(displayObject.x, displayObject.y);				} else {					for(i = 0;i < _propCount; i++) {						propName = propNames[i];						_from[propName] = _current[propName];					}				}				inited = true;			}						for(i = 0;i < _propCount; i++) {				propName = propNames[i];								if(propName == "x") {					_current.x = _from.x * q + _to.x * position;				} else if(propName == "y") {					_current.y = _from.y * q + _to.y * position;				} else {					_current[propName] = _from[propName] * q + _to[propName] * position;				}								if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);			}						apply();		}		override protected function apply() : void {			if(displayObject == null) return;						displayObject.x = _current.x;			displayObject.y = _current.y;		}		override public function dispose() : void {			_to = null;			_from = null;			_current = null;			displayObject = null;						super.dispose();		}	}}