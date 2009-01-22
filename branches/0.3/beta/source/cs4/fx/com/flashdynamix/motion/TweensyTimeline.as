﻿/**
.______                                                         __        __     
/\__  _\                                                      /'__`\    /'__`\   
\/_/\ \/ __  __  __     __     __    ___     ____  __  __    /\ \/\ \  /\_\L\ \  
...\ \ \/\ \/\ \/\ \  /'__`\ /'__`\/' _ `\  /',__\/\ \/\ \   \ \ \ \ \ \/_/_\_<_ 
....\ \ \ \ \_/ \_/ \/\  __//\  __//\ \/\ \/\__, `\ \ \_\ \   \ \ \_\ \__/\ \L\ \
.....\ \_\ \___x___/'\ \____\ \____\ \_\ \_\/\____/\/`____ \   \ \____/\_\ \____/
......\/_/\/__//__/   \/____/\/____/\/_/\/_/\/___/  `/___/> \   \/___/\/_/\/___/ 
......................................................./\___/                    
.......................................................\/__/ 
................. Tweening since 1998 ......................
............................................................
 */
package com.flashdynamix.motion {
	import com.flashdynamix.motion.plugins.AbstractTween;
	import com.flashdynamix.motion.plugins.TweensyPluginList;	

	/**
	 * TweensyTimeline groups instances of tweens which are animating for the same duration. It's important
	 * to know that these Tweens can be animating their own unique properties and from to targets
	 * 
	 * TweensyTimelines are especially efficient for bulk tweening (1000+ Objects) because of their
	 * capability of grouping instances with a common timeline. 
	 * 
	 * The TweensyTimeline Class has events for:
	 * <ul>
	 * <li>onComplete - When all tweens in the TweensyTimeline Class are done</li>
	 * <li>onUpdate - When all animations in the TweensyTimeline Class have been updated.</li>
	 * <li>onRepeat - When the animation REPLAYs in the TweensyTimeline Class.</li>
	 * </ul>
	 * These events allow for predefined params to be applied when they are executed.
	 * Tweensy favours this method as it allows for predefining the event and the params it requires
	 * without all the fussiness of Event listeners.
	 */
	public class TweensyTimeline {
		/**
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public static const YOYO : String = "yoyo";
		/**
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public static const REPLAY : String = "replay";
		/**
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public static const LOOP : String = "loop";
		/**
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public static const NONE : String = null;
		/**
		 * The default tween which will be used when none is provided using a to, from and fromTo method.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#ease TweensyTimeline.ease
		 */
		public static var defaultTween : Function = easeOut;
		private static var defaultArgs : Array = [0, 0, 1, 0];
		/**
		 * Defines the ease equation you would like to use. By default this is Quintic.easeOut or the defaultTween.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#defaultTween
		 */
		public var ease : Function = defaultTween;
		/**
		 * Defines the delay in seconds at the start of the animation.<BR>
		 * By default this value is 0 seconds.
		 */
		public var delayStart : Number = 0;
		/**
		 * Defines the delay in seconds at the end of the animation.<BR>
		 * By default this value is 0 seconds.
		 */
		public var delayEnd : Number = 0;
		/**
		 * Defines the repeat type for the animation. By default this is TweensyTimeline.NONE<BR><BR>
		 * Options include :
		 * <ul>
		 * <li>TweensyTimeline.NONE</li>
		 * <li>TweensyTimeline.YOYO</li>
		 * <li>TweensyTimeline.REPLAY</li>
		 * <li>TweensyTimeline.LOOP</li>
		 * </ul>
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatCount
		 * @see com.flashdynamix.motion.TweensyTimeline#NONE
		 * @see com.flashdynamix.motion.TweensyTimeline#YOYO
		 * @see com.flashdynamix.motion.TweensyTimeline#REPLAY
		 * @see com.flashdynamix.motion.TweensyTimeline#LOOP
		 */
		public var repeatType : String;
		/**
		 * The number of repeats to use. If -1 is used then the animation will repeat indefinitely.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public var repeats : int = -1;
		/**
		 * The count of the number of repeats which have occured.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public var repeatCount : int = 0;
		/**
		 * This contains a list of ease Functions to use on each repeat for the tween animation.<BR>
		 * i.e. [Quintic.easeIn, Quintic.easeOut]<BR>
		 * This will then use each of these ease Functions on each repeat.<BR>
		 * By default this is null when this property is null this functionality is ignored.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatType
		 */
		public var repeatEase : Array;
		/**
		 * Whether the timelines contained within the TweensyTimeline class will use smart rotation or not.<BR>
		 * Smart rotation will make the rotation turn in the direction which is the shortest in degrees 
		 * fixing what may otherwise appear as a visual glitch even though mathimatically it is correct.
		 */
		public var smartRotate : Boolean = true;
		/**
		 * Whether the tweens contained within the TweensyTimeline class will snap tweened properties to the closest whole number.
		 */
		public var snapToClosest : Boolean = false;
		public var autoHide : Boolean = false;

		/**
		 * Parameters applied to the onUpdate Function.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#onUpdate
		 */
		public var onUpdateParams : Array;
		/**
		 * Parameters applied to the onComplete Function.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#onComplete
		 */
		public var onCompleteParams : Array;
		/**
		 * Parameters applied to the onRepeat Function.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#onRepeat
		 */
		public var onRepeatParams : Array;

		/** @private */
		internal var manager : TweensyGroup;
		/** @private */
		internal var next : TweensyTimeline;
		/** @private */
		internal var previous : TweensyTimeline;

		private var _onComplete : Function;		private var _onRepeat : Function;		private var _onUpdate : Function;
		private var hasEvents : Boolean = false;
		private var _instances : Array = []; 
		private var _tweens : int = 0;
		private var _time : Number = 0;
		private var _paused : Boolean = false;
		private var args : Array = defaultArgs.concat();
		private var _duration : Number;
		private var list : Array;
		private var disposed : Boolean = false;

		public function TweensyTimeline() {
			list = [];
		}

		/**
		 * Adds a to based tween to the properties defined in the target Object.
		 * 
		 * @param instance The instance Object to be tweened or multiple _instances if using the type Array e.g. <code>timeline.to([item1, item2], {x:50, y:50});</code>
		 * @param to An Object containing the properties you would like to tween to e.g. <code>{x:50, y:25}</code>
		 * or this can be relative e.g. {x:'50', y:'-25'} or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>
		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time
		 * the tween occurs.<BR>
		 * For example <code>timeline.to(new DropShadowFilter(), {alpha:0}, myDisplayItem);</code><BR>
		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.
		 */
		public function to(instance : Object, toObj : Object, update : Object = null) : void {
			add(instance, update).toTarget(toObj);
		}

		/**
		 * Adds a from based tween to the properties defined in the target Object.
		 * 
		 * @param instance The instance Object to be tweened or multiple _instances if using the type Array e.g. <code>timeline.from([item1, item2], {x:50, y:50})</code>;
		 * @param from An Object containing the properties you would like to tween from e.g. <code>{x:50, y:25}</code>
		 * or this can be relative e.g. {x:'50', y:'-25'} or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>
		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time
		 * the tween occurs.<BR>
		 * For example <code>timeline.from(new DropShadowFilter(), {alpha:0}, myDisplayItem);</code><BR>
		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.
		 */
		public function from(instance : Object, fromObj : Object, update : Object = null) : void {
			add(instance, update).fromTarget(fromObj);
		}

		/**
		 * Adds a from to based tween to the properties defined in the target Object.
		 * 
		 * @param instance The instance Object to be tweened or multiple _instances if using the type Array e.g. <code>timeline.fromTo([item1, item2], {x:50, y:50});</code>
		 * @param from An Object containing the properties you would like to tween from e.g. <code>{x:50, y:25}</code>
		 * or this can be relative e.g. {x:'50', y:'-25'} or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>
		 * @param to An Object containing the properties you would like to tween to e.g. <code>{x:50, y:25}</code>
		 * or this can be relative e.g. {x:'50', y:'-25'} or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>
		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time
		 * the tween occurs.<BR>
		 * For example <code>timeline.fromTo(new DropShadowFilter(), {alpha:0}, {alpha:1}, myDisplayItem)</code><BR>
		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>
		 */
		public function fromTo(instance : Object, fromObj : Object, toObj : Object, update : Object = null) : void {
			add(instance, update).fromToTarget(fromObj, toObj);
		}

		/**
		 * Updates a tween for the instance Object to the new target properties defined in the to Object.<BR>
		 * The value of this instance depends on wether the 'update' param is used i.e.<BR>
		 * <code>timeline.to(new DropShadowFilter(), {alpha:0}, myDisplayItem);</code> the instance parameter will be myDisplayItem.<BR>
		 * <code>timeline.to(new DropShadowFilter(), {alpha:0});</code> the instance parameter will be the filter
		 */
		public function updateTo(instance : Object, to : Object) : void {
			var position : Number = ease.apply(null, args);
			
			var tween : AbstractTween;
			for each(tween in list) {
				if(tween.instance == instance) tween.updateTo(position, to);
			}
		}

		/**
		 * Allows for removing tweens via an instance or tween props by the following methods :
		 * <ul>
		 * <li><code>timeline.stop(instance);</code> - stops all property tweens for this instance.</li>
		 * <li><code>timeline.stop(instance, "x", "y");</code> - stops all x,y property tweens for this instance.</li>
		 * <li><code>timeline.stop([instance1, instance2]);</code> - stops all property tweens for these _instances.</li>
		 * <li><code>timeline.stop([instance1, instance2], "x", "y");</code> - stops all x,y property tweens for these _instances.</li>
		 * <li><code>timeline.stop(null, "x", "y");</code> - stops all x,y property tweens.</li>
		 * <li><code>timeline.stop();</code> - stops all tweens though it is recommended to use the stopAll method as this is more efficient.</li>
		 * </ul>
		 */
		public function stop(instance : * = null, ...props : Array) : void {
			var _instances : Array = (instance is Array) ? instance : (instance == null) ? null : [instance];
			var tween : AbstractTween;
			var i : int;
			
			for (i = _tweens - 1;i >= 0; i--) {
				
				tween = list[i];
				
				if(_instances == null || _instances.indexOf(tween.instance) != -1) {
					tween.stop.apply(null, props);
					if(!tween.hasAnimations) remove(tween);
				}
			}
			
			if(!hasTweens && manager) manager.remove(this);
		}

		public function stopAll() : void {
			var tween : AbstractTween;

			for each(tween in list) remove(tween);
			
			if(manager) manager.remove(this);
		}

		/**
		 * Updates the TweensyTimeline by the specified amout of time in seconds.<BR>
		 * This function is intended for use by the Tweensy class which is controlling this timeline animation.<BR>
		 * Though calling this function will update the timeline independtly of the mananger allowing for custom control
		 * over timelines.
		 * 
		 * @return Whether the TweensyTimeline animation has finished playing.
		 */
		public function update(secs : Number) : void {
			if(paused) return;
			
			_time += secs;
			var played : Number = _time - delayStart, done : Boolean = false, position : Number, tween : AbstractTween;
			
			if(played > 0) {
				
				done = finished;
				args[0] = (played > _duration) ? _duration : played;
				position = ease.apply(null, args);
				
				for each(tween in list) tween.update(position);
				
				if(hasEvents) {
					if(onUpdate != null) {
						onUpdate.apply(null, onUpdateParams);
						done = finished;
					}
				
					if(done) {
						if(onComplete != null) {
							onComplete.apply(null, onCompleteParams);
							done = finished;
						}
					}
				}
				
				if(done) {
					if(canRepeat) {
						if(repeatType == YOYO) {
							yoyo();
						} else if(repeatType == REPLAY) {
							replay();
						} else if(repeatType == LOOP) {
							loop();
						}
						
						if(hasEvents && onRepeat != null) {
							onRepeat.apply(null, onRepeatParams);
							done = finished && !canRepeat;
						}
					} else {
						manager.remove(this);
					}
				}
			}
		}

		/**
		 * Pauses a playing TweensyTimeline
		 */
		public function pause() : void {
			if(paused) return;
			
			_paused = true; 
		}

		/**
		 * Resumes a paused TweensyTimeline
		 */
		public function resume() : void {
			if(!paused) return;
			
			_paused = false;
		}

		/**
		 * Forces a timeline tween to loop the animation.<BR>
		 * A looped animation will swap the delays (delayStart & delayEnd) so that the to and from animations have the same delays.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatCount
		 * @see com.flashdynamix.motion.TweensyTimeline#NONE
		 * @see com.flashdynamix.motion.TweensyTimeline#YOYO
		 * @see com.flashdynamix.motion.TweensyTimeline#REPLAY
		 * @see com.flashdynamix.motion.TweensyTimeline#LOOP
		 */
		public function loop() : void {
			var tween : AbstractTween;
			for each(tween in list) tween.swapToFrom();
			
			var oldStart : Number = delayStart;
			delayStart = delayEnd;
			delayEnd = oldStart;
			
			doRepeat();
		}

		/**
		 * Forces a timeline tween to do a yoyo animation.<BR>
		 * A yoyo will use the same delayStart and delayEnd on the to and fro animation.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatCount
		 * @see com.flashdynamix.motion.TweensyTimeline#NONE
		 * @see com.flashdynamix.motion.TweensyTimeline#YOYO
		 * @see com.flashdynamix.motion.TweensyTimeline#REPLAY
		 * @see com.flashdynamix.motion.TweensyTimeline#LOOP
		 */
		public function yoyo() : void {
			var tween : AbstractTween;
			for each(tween in list) tween.swapToFrom();
			
			doRepeat();
		}

		/**
		 * Plays a timeline animation at its start position on each repeat.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#repeats
		 * @see com.flashdynamix.motion.TweensyTimeline#repeatCount
		 * @see com.flashdynamix.motion.TweensyTimeline#NONE
		 * @see com.flashdynamix.motion.TweensyTimeline#YOYO
		 * @see com.flashdynamix.motion.TweensyTimeline#REPLAY
		 * @see com.flashdynamix.motion.TweensyTimeline#LOOP
		 */
		public function replay() : void {
			var tween : AbstractTween;
			for each(tween in list) tween.update(0);
			
			doRepeat();
		}

		/**
		 * Defines whether the TweensyTimeline repeats.
		 */
		public function get canRepeat() : Boolean {
			return (repeatType != NONE && (repeats == -1 || repeatCount < repeats));
		}

		public function set position(index : Number) : void {
			update((index * totalDuration) - _time);
		}

		/**
		 * Seeks and returns the animation to a position from 0 to 1, start to end.
		 */
		public function get position() : Number {
			return (_time / totalDuration);
		}

		/**
		 * Determines whether or not the TweensyTimeline animation has finished.
		 */
		public function get finished() : Boolean {
			return (_time >= totalDuration);
		}

		/**
		 * The total duration of the TweensyTimeline animation in seconds.<BR>
		 * This is the sum of delayStart, duration and delayEnd.
		 */
		public function get totalDuration() : Number {
			return (delayStart + _duration + delayEnd);
		}

		public function set time(seconds : Number) : void {
			update(seconds-_time);
		}

		/**
		 * The time in seconds the TweensyTimeline has been running for
		 */
		public function get time() : Number {
			return _time;
		}

		public function set duration(secs : Number) : void {
			args[3] = secs;
			_duration = secs;
		}

		/**
		 * Sets and gets the current tween duration for the TweensyTimeline in seconds.
		 */
		public function get duration() : Number {
			return _duration;
		}

		/**
		 * Sets the ease params. These params are used on Back, Bounce and Elastic ease functions.<BR>
		 * These parameters lessen or exaggerate the effect of these particular ease functions.<BR>
		 * i.e. [0.7] will lessen the effect of a Back equation
		 */
		public function set easeParams(value : Array) : void {
			args = args.slice(0, 4).concat(value);
		}

		/**
		 * Whether the TweensyTimeline is paused.
		 */
		public function get paused() : Boolean {
			return (_paused);
		}

		/**
		 * This is when the animation is after the delay start and before its delay end.
		 * 
		 * @return Whether the TweensyTimeline is playing. 
		 */
		public function get playing() : Boolean {
			return (_time > delayStart && _time < delayEnd);
		}

		/**
		 * Number of tweens added to the TweensyTimeline Class.
		 */
		public function get tweens() : int {
			return _tweens;
		}

		/**
		 * Whether the TweensyTimeline has any animations.
		 */
		public function get hasTweens() : Boolean {
			return (_tweens > 0);
		}

		public function get instances() : Array {
			return _instances;
		}

		/**
		 * Executed on each update to the TweensyTimeline animation.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#onUpdateParams
		 */
		public function set onUpdate(func : Function) : void {
			hasEvents = (func == null) ? false : true;
			_onUpdate = func;
		}

		public function get onUpdate() : Function {
			return _onUpdate;
		}

		/**
		 * Executed when the TweensyTimeline animation is complete.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#onCompleteParams
		 */
		public function set onComplete(func : Function) : void {
			hasEvents = (func == null) ? false : true;
			_onComplete = func;
		}

		public function get onComplete() : Function {
			return _onComplete;
		}

		/**
		 * Executed when the TweensyTimeline animation repeats.
		 * 
		 * @see com.flashdynamix.motion.TweensyTimeline#onRepeatParams
		 */
		public function set onRepeat(func : Function) : void {
			hasEvents = (func == null) ? false : true;
			_onRepeat = func;
		}

		public function get onRepeat() : Function {
			return _onRepeat;
		}

		/** @private */
		internal function removeOverlap(timeline : TweensyTimeline) : void {
			if(this != timeline && intersects(timeline)) {
				
				var tweenA : AbstractTween;
				var tweenB : AbstractTween;
				var i : int;
				
				for each(tweenA in timeline.list) {
					for (i = _tweens - 1;i >= 0; i--) {
						tweenB = list[i];
						tweenB.removeOverlap(tweenA);
						if(!tweenB.hasAnimations) remove(tweenB);
					}
				}
				
				if(!hasTweens) manager.remove(this);
			}
		}

		/** @private */
		internal function clear() : void {
			var tween : AbstractTween;

			for each(tween in list) {
				tween.clear();
				TweensyPluginList.checkIn(tween);
			}
			
			next = null;
			previous = null;
			args = defaultArgs.concat();
			manager = null;

			onUpdate = null;
			onUpdateParams = null;
			onComplete = null;
			onCompleteParams = null;
			onRepeat = null;
			onRepeatParams = null;
			_onComplete = null;
			
			_tweens = 0;
			_instances.length = 0;
			list.length = 0;
			ease = defaultTween;
			delayStart = 0;
			delayEnd = 0;
			repeatType = NONE;
			repeats = -1;
			repeatEase = null;
			disposed = false;
			_time = 0;
			_paused = false;
			repeatCount = 0;
		}

		private function add(instanceObj : Object, updateObj : Object = null) : AbstractTween {
			var tween : AbstractTween = TweensyPluginList.checkOut(instanceObj);
			
			tween.timeline = this;
			tween.construct(instanceObj, updateObj);
			
			_instances[_instances.length] = tween.instance;
			
			list[_tweens++] = tween;
			
			if(manager) manager.addInstance(tween.instance, this);
			
			return tween;
		}

		private function remove(tween : AbstractTween) : void {
			tween.clear();
			TweensyPluginList.checkIn(tween);
			
			_instances.splice(_instances.indexOf(tween.instance));
			
			list.splice(list.indexOf(tween), 1);
			
			_tweens--;
			
			if(manager) manager.removeInstance(tween.instance, this);
		}

		private function intersects(timeline : TweensyTimeline) : Boolean {
			return (timeline.delayStart < (totalDuration - time));
		}

		private function doRepeat() : void {
			_time = 0;
			repeatCount++;
			
			if(repeatEase) ease = repeatEase[repeatCount % repeatEase.length];
		}

		public static function empty() : void {
			TweensyPluginList.empty();
		}

		private static function easeOut(t : Number, b : Number, c : Number, d : Number) : Number {
			return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
		}

		/**
		 * Disposes the TweensyTimeline Class instance ready for garbage collection.
		 */
		public function dispose() : void {
			if(disposed) return;
			
			disposed = true;
			
			stopAll();
			
			next = null;
			previous = null;
			args = null;
			list = null;
			manager = null;
			ease = null;
			repeatEase = null;
			
			onUpdate = null;
			onUpdateParams = null;
			onComplete = null;
			onCompleteParams = null;
			onRepeat = null;
			onRepeatParams = null;
		}

		public function toString() : String {
			return "TweensyTimeline " + Tweensy.version + " {tweens:" + _tweens + "}";
		}
	}
}