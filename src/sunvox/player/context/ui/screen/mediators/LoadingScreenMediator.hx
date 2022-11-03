/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.context.ui.screen.mediators;

import robotlegs.bender.bundles.mvcs.Mediator;

class LoadingScreenMediator extends Mediator {
	//-----------------------------------------------------------------------------
	// Public :: Injection
	//-----------------------------------------------------------------------------
	@inject public var view:LoadingScreen;

	//-----------------------------------------------------------------------------
	// Overridden :: Methods
	//-----------------------------------------------------------------------------
	override function initialize() {
		super.initialize();
		view.onStartTriggered.add(view_onStartTriggered);
	}

	override function destroy() {
		view.onStartTriggered.remove(view_onStartTriggered);
		super.destroy();
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------
	private function view_onStartTriggered():Void {
		trace("LoadingScreenMediator.view_onStartTriggered()");
	}
}
