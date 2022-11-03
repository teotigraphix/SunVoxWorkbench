/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */
 
package sunvox.player.context.ui.skin;

import feathers.controls.ToggleButton;
import feathers.controls.ToggleButtonState;
import feathers.skins.ProgrammaticSkin;
import motion.Actuate;
import motion.easing.Sine;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;
import sunvox.player.context.ui.theme.ThemeProperties;

class CustomAnimatedSkin extends ProgrammaticSkin {
	//-----------------------------------------------------------------------------
	// Variables
	//-----------------------------------------------------------------------------

	private var ORIGINAL_MASK_SIZE = 10.0;

	private var _ripple:Shape;
	private var _rippleMask:Shape;
	private var _targetScale:Float;
	private var _isActive:Bool = false;

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	public function new() {
		super();

		_rippleMask = new Shape();
		addChild(_rippleMask);

		_ripple = new Shape();
		_ripple.mask = _rippleMask;
		_ripple.alpha = 0.0;
		_ripple.graphics.beginFill(0xffffff, 0.25);
		_ripple.graphics.drawCircle(0.0, 0.0, ORIGINAL_MASK_SIZE / 2.0);
		_ripple.graphics.endFill();
		addChild(_ripple);

		filters = [new DropShadowFilter(4.0, 60, 0, 0.9, 10.0, 10.0)];
	}

	//-----------------------------------------------------------------------------
	// Overridden :: Methods
	//-----------------------------------------------------------------------------

	override private function onAddUIContext():Void {
		uiContext.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
	}

	override private function onRemoveUIContext():Void {
		uiContext.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
	}

	override private function update():Void {
		var state = _stateContext.currentState;

		var isHover = _stateContext.currentState == ToggleButtonState.HOVER;
		var isDown = _stateContext.currentState == ToggleButtonState.DOWN;

		var fillColor = (isHover || isDown) ? ThemeProperties.THEME_COLOR_PRIMARY_200 : ThemeProperties.THEME_COLOR_PRIMARY_500;

		// trace(_stateContext.currentState);

		if (!uiContext.enabled) {
			fillColor = ThemeProperties.THEME_COLOR_GREY_DISABLED;
		} else if (Std.isOfType(uiContext, ToggleButton)) {
			var toggleButton:ToggleButton = cast(uiContext, ToggleButton);
			fillColor = toggleButton.selected ? ThemeProperties.THEME_COLOR_SECONDARY_500 : ThemeProperties.THEME_COLOR_PRIMARY_500;
		}

		// draw the main shape
		graphics.clear();
		graphics.beginFill(fillColor);
		graphics.drawRoundRect(0.0, 0.0, actualWidth, actualHeight, 10.0);
		graphics.endFill();

		// the mask has the same rounded rectangle shape as the button
		_rippleMask.graphics.clear();
		_rippleMask.graphics.beginFill(0xff00ff);
		_rippleMask.graphics.drawRoundRect(0.0, 0.0, actualWidth, actualHeight, 10.0);
		_rippleMask.graphics.endFill();
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------

	private function hideOverlay():Void {
		Actuate.stop(_ripple, ["scaleX", "scaleY", "alpha"]);
		_ripple.scaleX = _targetScale;
		_ripple.scaleY = _targetScale;
		_ripple.alpha = 1.0;
		// hide the ripple overlay by fading it out
		Actuate.tween(this._ripple, 0.2, {alpha: 0.0}).ease(Sine.easeOut);
	}

	//-----------------------------------------------------------------------------
	// Private :: Handlers
	//-----------------------------------------------------------------------------

	private function mouseDownHandler(event:MouseEvent):Void {
		if (!uiContext.enabled)
			return;

		Actuate.stop(_ripple, ["scaleX", "scaleY", "alpha"]);

		_ripple.scaleX = 0.0;
		_ripple.scaleY = 0.0;
		_ripple.alpha = 0.5;
		_ripple.x = mouseX;
		_ripple.y = mouseY;

		_isActive = true;

		var virtualWidth = actualWidth + (2.0 * Math.abs((actualWidth / 2.0) - mouseX));
		var virtualHeight = actualHeight + (2.0 * Math.abs((actualHeight / 2.0) - mouseY));
		var newMaskSize = Math.sqrt((virtualWidth * virtualWidth) + (virtualHeight * virtualHeight));
		_targetScale = newMaskSize / ORIGINAL_MASK_SIZE;
		// reveal the ripple overlay by scaling it up and fading it in
		Actuate.tween(_ripple, 0.2, {scaleX: _targetScale, scaleY: _targetScale, alpha: 1.0})
			.ease(Sine.easeOut)
			.onComplete(downTween_onComplete);

		stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
	}

	private function stage_mouseUpHandler(event:MouseEvent):Void {
		stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		if (_isActive) {
			// the tween is still running, so we must wait
			_isActive = false;
			return;
		}
		hideOverlay();
	}

	private function downTween_onComplete():Void {
		if (_isActive) {
			// the mouse is still down, so we must wait
			_isActive = false;
			return;
		}
		hideOverlay();
	}
}
