/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.app.config;

import robotlegs.bender.framework.api.IBundle;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.LogLevel;

class AppBundle implements IBundle {
	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	public function new() {}

	//-----------------------------------------------------------------------------
	// IBundle :: Methods
	//-----------------------------------------------------------------------------
	public function extend(context:IContext):Void {
		context.logLevel = LogLevel.DEBUG;

		context.install(GlobalExtension);
	}
}
