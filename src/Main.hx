/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package;

import feathers.controls.Application;
import feathers.layout.VerticalLayout;
import feathers.style.Theme;
import lime.utils.Log;
import sunvox.player.app.ApplicationController;
import sunvox.player.context.ui.theme.AppTheme;

class Main extends Application {
	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private var _applicationController:ApplicationController;

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	public function new() {
		super();

		// TODO BUG ???? Where is the Shader logging being activated in Lime?
		Log.level = lime.utils.LogLevel.NONE;

		trace("   Main");

		_applicationController = new ApplicationController();

		preinitialize();
	}

	//-----------------------------------------------------------------------------
	// Overriden :: Methods
	//-----------------------------------------------------------------------------

	private override function initialize():Void {
		super.initialize();

		stage.color = 0x242424;

		var vl = new VerticalLayout();
		layout = vl;
	}

	private override function update():Void {
		super.update();
	}

	//-----------------------------------------------------------------------------
	// Internal :: Methods
	//-----------------------------------------------------------------------------

	private function preinitialize() {
		Theme.setTheme(new AppTheme());

		_applicationController.boot(this);
	}
}
