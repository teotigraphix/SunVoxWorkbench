/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */
 
package sunvox.player.context.ui.theme;

import feathers.style.ITheme;

class SubThemeFactory {
	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private var theme:AppTheme;

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------

	/** */
	public function new(theme:ITheme) {
		this.theme = cast(theme, AppTheme);
	}

	/** Register sub themes. */
	public function initialize():Void {}

	//-----------------------------------------------------------------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	private function register<T>(classType:Class<T>, variant:String, callback:T->Void):Void {
		theme.register(classType, variant, callback);
	}
}
