/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */
 
package sunvox.player.context.ui.theme;

import feathers.themes.ClassVariantTheme;

class AppTheme extends ClassVariantTheme {
	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private var subThemes:Array<SubThemeFactory>;

	private var customThemeColor:Null<Int>;
	private var customDarkThemeColor:Null<Int>;

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------

	/** */
	public function new(?themeColor:Int, ?darkThemeColor:Int) {
		super();

		this.customThemeColor = themeColor;
		this.customDarkThemeColor = darkThemeColor;

		subThemes = new Array<SubThemeFactory>();

		initialize();
	}

	//-----------------------------------------------------------------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	public function register<T>(classType:Class<T>, variant:String, callback:T->Void):Void {
		styleProvider.setStyleFunction(classType, variant, callback);
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------

	private function addSubTheme(subTheme:SubThemeFactory):Void {
		subThemes.push(subTheme);
	}

	private function initialize():Void {
		addSubTheme(new CommonThemeFactory(this));

		for (i in 0...subThemes.length) {
			subThemes[i].initialize();
		}
	}
}
