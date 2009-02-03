﻿package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;	import flash.filters.BitmapFilter;	import flash.filters.ColorMatrixFilter;	import flash.utils.Dictionary;		/**	 * This plugin will be used when tweening BitmapFilters.	 */	public class FilterTween extends AbstractTween {		internal static var filters : Dictionary = new Dictionary(true);				public static var key : Class = BitmapFilter;				private var _current : Object;		protected var _filter : BitmapFilter;		protected var _to : Object;		protected var _from : Object;		/** @private */		internal var displayObject : DisplayObject;		protected var filterList : Array;		public function FilterTween() {			_to = {};			_from = {};		}		override public function construct(instance : Object, applyToInstance : Object) : void {			inited = false;						_filter = instance as BitmapFilter;			displayObject = applyToInstance as DisplayObject;						if(_filter is ColorMatrixFilter) {				_current = ColorMatrixFilter(_filter).matrix;			} else {				_current = _filter;			}						filterList = filters[displayObject];						if(filterList == null || filterList.length != displayObject.filters.length) {				filterList = filters[displayObject] = displayObject.filters;			}						if(filterList.indexOf(_filter) == -1) filterList.push(_filter);		}		override public function set to(item : Object) : void {			_to = item;		}		override public function get to() : Object {			return _to;		}		override public function set from(item : Object) : void {			_from = item;		}		override public function get from() : Object {			return _from;		}		override public function get current() : Object {			return _current;		}		override public function get instance() : Object {			return (displayObject) ? displayObject : current;		}		override protected function match(item : AbstractTween) : Boolean {			return (item is FilterTween && (current == item.current || ((item as FilterTween).displayObject == null || (item as FilterTween).displayObject == displayObject)) );		}		override public function update(position : Number) : void {			var q : Number = 1 - position, propName : String, i : int = 0;						if(!inited && _propCount > 0) {				for(i = 0;i < _propCount; i++) {					propName = propNames[i];					_from[propName] = _current[propName];				}				inited = true;			}						for(i = 0;i < _propCount; i++) {				propName = propNames[i];								_current[propName] = _from[propName] * q + _to[propName] * position;								if(timeline.snapClosest) _current[propName] = Math.round(_current[propName]);			}						apply();		}		override protected function apply() : void {			if(displayObject == null) return;						if(_filter is ColorMatrixFilter) ColorMatrixFilter(_filter).matrix = _current as Array;						displayObject.filters = filterList;		}		override public function dispose() : void {			_filter = null;			_current = null;			displayObject = null;			filterList = null;						super.dispose();		}	}}