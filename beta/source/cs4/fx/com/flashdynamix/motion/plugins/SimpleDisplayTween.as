﻿package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;		/**	 * This plugin will be used when tweening DisplayObjects.	 */	public class SimpleDisplayTween extends AbstractTween {		public static var key : Class = DisplayObject;		
		private var _current : DisplayObject;		protected var _to : DisplayTweenObject;		protected var _from : DisplayTweenObject;
		public function SimpleDisplayTween() {			_to = new DisplayTweenObject();			_from = new DisplayTweenObject();		}
		override public function construct(instance : Object, applyToInstance : Object) : void {			inited = false;						_current = instance as DisplayObject;		}
		override public function set to(item : Object) : void {			_to = item as DisplayTweenObject;		}
		override public function get to() : Object {			return _to;		}
		override public function set from(item : Object) : void {			_from = item as DisplayTweenObject;		}
		override public function get from() : Object {			return _from;		}
		override public function get current() : Object {			return _current;		}
		override protected function match(item : AbstractTween) : Boolean {			return (item is SimpleDisplayTween && super.match(item));		}
		override public function update(position : Number) : void {			var q : Number = 1 - position;						if(!inited && _propCount > 0) {				_from.x = _current.x;				_from.y = _current.y;				//_from.alpha = _current.alpha;				_from.scaleX = _current.scaleX;				_from.scaleY = _current.scaleY;				/*_from.width = _current.width;				_from.height = _current.height;				_from.rotation = _current.rotation;*/								inited = true;			}						_current.x = _from.x * q + _to.x * position;			_current.y = _from.y * q + _to.y * position;			//_current.alpha = _from.alpha * q + _to.alpha * position;			_current.scaleX = _from.scaleX * q + _to.scaleX * position;			_current.scaleY = _from.scaleY * q + _to.scaleY * position;			/*_current.width = _from.width * q + _to.width * position;			_current.height = _from.height * q + _to.height * position;			_current.rotation = _from.rotation * q + _to.rotation * position;*/		}
		override public function dispose() : void {			_to = null;			_from = null;			_current = null;						super.dispose();		}	}}
internal dynamic class DisplayTweenObject {	public var x : Number;	public var y : Number;	public var z : Number;	public var alpha : Number;	public var width : Number;	public var height : Number;	public var scaleX : Number;	public var scaleY : Number;	public var scaleZ : Number;	public var rotation : Number;	public var rotationX : Number;	public var rotationY : Number;	public var rotationZ : Number;	public var currentFrame : Number;}