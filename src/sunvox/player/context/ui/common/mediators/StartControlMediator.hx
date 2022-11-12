/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.context.ui.common.mediators;

import feathers.events.TriggerEvent;
import robotlegs.bender.bundles.mvcs.Mediator;
import sunvox.player.app.ApplicationController;

class StartControlMediator extends Mediator {
	//-----------------------------------------------------------------------------
	// Public :: Injection
	//-----------------------------------------------------------------------------
	@inject public var __applicationController:ApplicationController;

	@inject public var view:StartControl;

	//-----------------------------------------------------------------------------
	// Overridden :: Methods
	//-----------------------------------------------------------------------------

	override function initialize() {
		super.initialize();
		refreshView();
		addViewListener(TriggerEvent.TRIGGER, view_triggeredHandler);
		__applicationController.onAudioEngineStateChange.add(applicationController_onAudioEngineStateChange);
	}

	override function destroy() {
		__applicationController.onAudioEngineStateChange.remove(applicationController_onAudioEngineStateChange);
		super.destroy();
	}

	//-----------------------------------------------------------------------------
	// View :: Handlers
	//-----------------------------------------------------------------------------

	private function view_triggeredHandler(event:TriggerEvent):Void {
		__applicationController.clientGuesture();
	}

	//-----------------------------------------------------------------------------
	// Context :: Handlers
	//-----------------------------------------------------------------------------

	private function applicationController_onAudioEngineStateChange():Void {
		refreshView();
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------

	private function refreshView():Void {
		var isRunning = __applicationController.hasUserActivity;
		view.enabled = !isRunning;
		view.text = isRunning ? "Audio Engine Started" : "Start Audio Engine";
	}
}
