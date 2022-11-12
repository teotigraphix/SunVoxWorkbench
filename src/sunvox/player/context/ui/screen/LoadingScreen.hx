/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.context.ui.screen;

import feathers.controls.LayoutGroup;
import feathers.events.TriggerEvent;
import openfl.events.Event;
import robotlegs.signal.Signal;
import sunvox.player.context.ui.common.StartControl;

@:styleContext
class LoadingScreen extends LayoutGroup {
	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private var startControl:StartControl;

	//-----------------------------------------------------------------------------
	// API :: Signals
	//-----------------------------------------------------------------------------
	public var onUserActivity:Signal = new Signal();

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------

	public function new() {
		super();
	}
	
	//-----------------------------------------------------------------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	public function setText(value:String) {
		startControl.text = value;
	}

	//-----------------------------------------------------------------------------
	// Overriden :: Methods
	//-----------------------------------------------------------------------------

	override private function initialize():Void {
		super.initialize();

		startControl = new StartControl();
		startControl.addEventListener(TriggerEvent.TRIGGER, startControl_triggerHandler);

		addChild(startControl);
	}

	override private function update():Void {
		super.update();

		var stateChanged = isInvalid(STATE);

		if (stateChanged) {
			commitState();
		}
	}

	//-----------------------------------------------------------------------------
	// Protected :: Methods
	//-----------------------------------------------------------------------------

	private function commitState() {
		startControl.enabled = _enabled;
	}

	//-----------------------------------------------------------------------------
	// Private :: Handlers
	//-----------------------------------------------------------------------------

	private function startControl_triggerHandler(event:Event):Void {
		onUserActivity.dispatch();
	}
}
