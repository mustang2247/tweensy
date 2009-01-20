/**.______                                                         __        __     /\__  _\                                                      /'__`\    /'__`\   \/_/\ \/ __  __  __     __     __    ___     ____  __  __    /\ \/\ \  /\_\L\ \  ...\ \ \/\ \/\ \/\ \  /'__`\ /'__`\/' _ `\  /',__\/\ \/\ \   \ \ \ \ \ \/_/_\_<_ ....\ \ \ \ \_/ \_/ \/\  __//\  __//\ \/\ \/\__, `\ \ \_\ \   \ \ \_\ \__/\ \L\ \.....\ \_\ \___x___/'\ \____\ \____\ \_\ \_\/\____/\/`____ \   \ \____/\_\ \____/......\/_/\/__//__/   \/____/\/____/\/_/\/_/\/___/  `/___/> \   \/___/\/_/\/___/ ......................................................./\___/                    .......................................................\/__/ ................. Tweening since 1998 .................................................................................. */package com.flashdynamix.motion {
	/**	 * The Tweensy Class contains a collection of tweens specified by property tweens for an Object instance.	 * Using the TweensyGroup Class though is the recommended implementation for property tweening, while	 * the Tweensy Class offers most of the functionality of TweensyGroup via a list of static methods and properties for coding convenience.	 * <BR><BR>	 * A tween can be executed in one of the following manners:	 * <ul>	 * <li>to - allows for defining where the animation is going 'to' from its current position<BR>	 * e.g. <code>Tweensy.to(item, {x:50, y:100});</code>	 * </li>	 * <li>from - allows for defining where the animation is coming 'from' and will be going to its current position<BR>	 * e.g. <code>Tweensy.from(item, {x:200, y:150});</code>	 * </li>	 * <li>fromTo - allows for defining where the animation is coming 'from' and going 'to'<BR>	 * e.g. <code>Tweensy.fromTo(item, {x:200, y:150}, {x:50, y:100});</code>	 * </li>	 * </ul>	 * 	 * @see com.flashdynamix.motion.TweensyGroup	 * @see com.flashdynamix.motion.TweensyTimeline	 */	public class Tweensy {
		private static var tween : TweensyGroup = new TweensyGroup(true, false, TIME);
		public static const version : Number = 0.2;
		/**		 * Sets the refreshType to use the current frames per second of the SWF allowing for time based animations.		 * 		 * @see com.flashdynamix.motion.Tweensy#refreshType		 */		public static const TIME : String = "time";		/**		 * Sets the refreshType to use the current seconds per frame on each ENTER_FRAME allowing for frame based animations.		 * 		 * @see com.flashdynamix.motion.Tweensy#refreshType		 */		public static const FRAME : String = "frame";
		/**		 * Adds a to based tween using the properties defined in the target Object.		 * 		 * @param instance The instance Object to be tweened or multiple instances if using the type Array e.g. <code>[item1, item2]</code>		 * @param to An Object containing the properties you would like to tween to e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param duration The time in secs you would like the tween to run.		 * @param ease The ease equation you would like to use, by default this is Quintic.easeOut or the ease equation defined in TweensyTimeline.defaultTween.		 * @param delayStart The delay you would like to use at the beginning of the tween and every subsequent REPLAY of a tween.		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time		 * the tween occurs. This occurs with tweening ColorTransforms, Matrices, SoundTransforms, BitmapFilters.<BR>		 * For example <code>Tweensy.to(new DropShadowFilter(), {alpha:0}, 0.5, null, 0, myDisplayItem);</code><BR>		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.		 * @param onComplete The onComplete event handler you would like to fire once the tween is complete.		 * @param onCompleteParams The params applied to the onComplete handler.		 * 		 * @return An instance to the TweensyTimeline which can used to manage this tween.		 * 		 * @see com.flashdynamix.motion.TweensyTimeline		 */
		public static function to(instance : Object, to : Object, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, update : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			return tween.to(instance, to, duration, ease, delayStart, update, onComplete, onCompleteParams);		}
		/**		 * Adds a from based tween using the properties defined in the from Object.		 * 		 * @param instance The instance Object to be tweened or multiple instances if using the type Array e.g. <code>[item1, item2]</code>		 * @param from An Object containing the properties you would like to tween from e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param duration The time in secs you would like the tween to run.		 * @param ease The ease equation you would like to use, by default this is Quintic.easeOut or the ease equation defined in TweensyTimeline.defaultTween.		 * @param delayStart The delay you would like to use at the beginning of the tween and every subsequent REPLAY of a tween.		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time		 * the tween occurs.This occurs with tweening ColorTransforms, Matrices, SoundTransforms, BitmapFilters.<BR>		 * For example <code>Tweensy.from(new DropShadowFilter(), {alpha:0}, 0.5, null, 0, myDisplayItem);</code><BR>		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.		 * @param onComplete The onComplete event handler you would like to fire once the tween is complete.		 * @param onCompleteParams The params applied to the onComplete handler.		 *		 * @return An instance of the TweensyTimeline which can used to manage this tween.		 * 		 * @see com.flashdynamix.motion.TweensyTimeline		 */
		public static function from(instance : Object, from : Object, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, update : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			return tween.from(instance, from, duration, ease, delayStart, update, onComplete, onCompleteParams);		}
		/**		 * Adds a from to based tween using the properties defined in the from and to Objects.		 * 		 * @param instance The instance Object to be tweened or multiple instances if using the type Array e.g. <code>[item1, item2]</code>		 * @param from An Object containing the properties you would like to tween from e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param to An Object containing the properties you would like to tween to e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param duration The time in secs you would like the tween to run.		 * @param ease The ease equation you would like to use, by default this is Quintic.easeOut or the ease equation defined in TweensyTimeline.defaultTween.		 * @param delayStart The delay you would like to use at the beginning of the tween and every subsequent REPLAY of a tween.		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time		 * the tween occurs.This occurs with tweening ColorTransforms, Matrices, SoundTransforms, BitmapFilters.<BR>		 * For example <code>Tweensy.fromTo(new DropShadowFilter(), {alpha:1}, {alpha:0}, 0.5, null, 0, myDisplayItem);</code><BR>		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.		 * @param onComplete The onComplete event handler you would like to fire once the tween is complete.		 * @param onCompleteParams The params applied to the onComplete handler.		 *		 * @return An instance of the TweensyTimeline which can used to manage this tween.		 * 		 * @see com.flashdynamix.motion.TweensyTimeline		 */
		public static function fromTo(instance : Object, from : Object, to : Object, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, update : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			return tween.fromTo(instance, from, to, duration, ease, delayStart, update, onComplete, onCompleteParams);		}		/**		 * Updates a tween for the instance Object to the new target positions defined in the to Object.		 */		public static function updateTo(instance : Object, to : Object) : void {			tween.updateTo(instance, to);		}
		/**		 * Adds a TweensyTimeline to the Tweensy class.		 * This can be useful if you want to prepare an animation and the items in it but not necessarily		 * have it Tweening straight away.		 * 		 * @return An instance to the TweensyTimeline.		 */
		public static function add(timeline : TweensyTimeline) : TweensyTimeline {			return tween.add(timeline);		}
		/**		 * Removes a TweensyTimeline from the Tweensy class.		 * This will stop this timeline from being updated but can be re-added to the Tweensy class resuming that animation.		 * 		 * @return An instance to the TweensyTimeline.		 */		public static function remove(timeline : TweensyTimeline) : void {			tween.remove(timeline);		}
		/**		 * Allows for removing tweens which have been executed by the Tweensy Class. <BR>		 * Tweens can be stopped via an instance or tween props by the following methods :		 * <ul>		 * <li>stop(instance); - stops all property tweens for this instance.</li>		 * <li>stop(instance, "x", "y"); - stops all x,y property tweens for this instance.</li>		 * <li>stop([instance1, instance2]); - stops all property tweens for these instances.</li>		 * <li>stop([instance1, instance2], "x", "y"); - stops all x,y property tweens for these instances.</li>		 * <li>stop(null, "x", "y"); - stops all x,y property tweens.</li>		 * <li>stop(); - stops all tweens, although it is recommeded to use the stopAll method as this is more efficient.</li>		 * </ul>		 * 		 */
		public static function stop(instance : * = null, ...props : Array) : void {			var args : Array = [instance].concat(props);			tween.stop.apply(null, args);		}
		/**		 * Stops all tweens which have been executed by the Tweensy Class.		 */
		public static function stopAll() : void {			tween.stopAll();		}
		/**		 * Pauses all tweens which have been executed by the Tweensy Class.		 */
		public static function pause() : void {			tween.pause();		}
		/**		 * Resumes all tweens which have been executed by the Tweensy Class.		 */
		public static function resume() : void {			tween.resume();		}
		/**		 * Prepares the Tweensy Library for garbage collection by disposing its Object Pools and making it 		 * no longer usable in the Flash application.		 */		public static function empty() : void {			TweensyGroup.empty();					TweensyTimeline.empty();		}		public static function set snapToClosest(flag : Boolean) : void {			tween.snapToClosest = flag;		}		/**		 * Whether the timelines contained within the TweensyGroup class will snap tweened properties to the closest whole number.		 */		public static function get snapToClosest() : Boolean {			return tween.snapToClosest;		}		public static function set smartRotate(flag : Boolean) : void {			tween.smartRotate = flag;		}		/**		 * Whether the timelines contained within the TweensyGroup class will use smart rotation or not.<BR>		 * Using smart rotation will ensure that when tweening the 'rotation' property it will turn in the shortest rotation direction.<BR>		 * This fixes what may otherwise appear as a visual glitch even though mathimatically it is correct.		 */		public static function get smartRotate() : Boolean {			return tween.smartRotate;		}		public static function set autoHide(flag : Boolean) : void {			tween.autoHide = flag;		}		public static function get autoHide() : Boolean {			return tween.autoHide;		}
		/**		 * Whether the Tweensy Class is currently paused.		 */
		public static function get paused() : Boolean {			return tween.paused;		}
		public static function set secondsPerFrame(spf : Number) : void {			tween.secondsPerFrame = spf;		}
		/**		 * Defines how many seconds per frame are added to to each on an ENTER_FRAME when TweensyGroup Class's refreshType is of the Tweensy.FRAME mode.<BR>		 * This property and feature is intended as an alternative to the Tweensy.TIME (time based animation) mode which can result in jumpy effects.		 * This is because by using Tweensy.Time rfreshType it ensures that your animation will accurately finish in the time you specify.		 * Instead Tweensy.FRAME ensures that every frame is rendered for the duration of your animation.		 * e.g. If your FLA frame rate is 30 frames per second then set secondsPerFrame to 1 second for every 30 frames (1/30).		 * 		 * @see com.flashdynamix.motion.Tweensy#refreshType		 * @see com.flashdynamix.motion.Tweensy#FRAME 		 */
		public static function get secondsPerFrame() : Number {			return tween.secondsPerFrame;		}		public static function set refreshType(type : String) : void {			tween.refreshType = type;		}
		/**		 * Sets the timing system currently in use by the Tweensy Class.<BR>		 * @param type Can be either :		 * <ul>		 * <li>Tweensy.TIME</li>		 * <li>Tweensy.FRAME</li>		 * </ul>		 * @see com.flashdynamix.motion.Tweensy#FRAME 	 		 * @see com.flashdynamix.motion.Tweensy#TIME		 * @see com.flashdynamix.motion.TweensyGroup#secondsPerFrame		 */
		public static function get refreshType() : String {			return tween.refreshType;		}		/**		 * Total number of animations in progress for the Tweensy class.		 */		public static function get timelines() : int {			return tween.timelines;		}		/**		 * Whether the Tweensy Class has any TweensyTimeline animations.		 */		public static function get hasTimelines() : Boolean {			return tween.hasTimelines;		}
		public function toString() : String {			return "Tweensy " + Tweensy.version + " {timelines:" + timelines + "}";		}	}}