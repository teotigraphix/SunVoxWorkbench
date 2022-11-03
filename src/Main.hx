/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package;

import feathers.controls.Application;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.style.Theme;
import sunvox.player.app.ApplicationController;
import sunvox.player.context.ui.screen.LoadingScreen;
import sunvox.player.context.ui.theme.AppTheme;

class Main extends Application {
	private var applicationController:ApplicationController;
	private var loadingScreen:LoadingScreen;

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	public function new() {
		super();

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

		loadingScreen = new LoadingScreen();
		loadingScreen.layoutData = new VerticalLayoutData(100, 100);
		loadingScreen.onStartTriggered.add(function():Void {
			applicationController.startAsync();
		});

		addChild(loadingScreen);
	}

	private override function update():Void {
		super.update();
	}
	
	//-----------------------------------------------------------------------------
	// Internal :: Methods
	//-----------------------------------------------------------------------------

	private function preinitialize() {
		Theme.setTheme(new AppTheme());

		applicationController = ApplicationController.boot(this);
	}
}
