/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */
 
package sunvox.player.context.ui.theme;

import feathers.controls.Button;
import feathers.controls.ToggleButton;
import feathers.graphics.FillStyle;
import feathers.layout.VerticalLayout;
import feathers.skins.RectangleSkin;
import feathers.style.ITheme;
import feathers.text.TextFormat;
import openfl.display.GradientType;
import sunvox.player.context.ui.common.StartControl;
import sunvox.player.context.ui.screen.LoadingScreen;
import sunvox.player.context.ui.skin.CustomAnimatedSkin;

class CommonThemeFactory extends SubThemeFactory {
	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------

	/** */
	public function new(theme:ITheme) {
		super(theme);
	}

	//-----------------------------------------------------------------------------
	// Overriden :: Methods
	//-----------------------------------------------------------------------------

	override public function initialize() {
		super.initialize();

		register(Button, null, setButtonStyles);

		register(LoadingScreen, null, setLoadingScreenStyles);
		register(StartControl, null, setStartControlStyles);
	}

	//-----------------------------------------------------------------------------
	// Theme :: Methods
	//-----------------------------------------------------------------------------
	//-----------------------------------
	// Button
	//-----------------------------------

	private function setButtonStyles(button:Button):Void {
		set_AnimatedButtonSkinStyles(button, 16);
	}

	private function set_AnimatedButtonSkinStyles(button:Button, ?fontSize:Int = 16):Void {
		var skin = new CustomAnimatedSkin();

		button.backgroundSkin = skin;
		button.textFormat = new TextFormat("_sans", fontSize, 0xFFFFFF, true);
		button.setPadding(8);
	}

	private function set_AnimatedToggleButtonSkinStyles(button:ToggleButton, ?fontSize:Int = 16):Void {
		var skin = new CustomAnimatedSkin();

		button.backgroundSkin = skin;
		button.textFormat = new TextFormat("_sans", fontSize, 0xffffff, true);
		button.selectedTextFormat = new TextFormat("_sans", fontSize, 0x242424, true);
		button.disabledTextFormat = new TextFormat("_sans", fontSize, 0xCCCCCC, true);
		button.setPadding(8);
	}

	//-----------------------------------------------------------------------------
	// LoadingScreen - Theme :: Methods
	//-----------------------------------------------------------------------------
	//-----------------------------------
	// LoadingScreen
	//-----------------------------------

	public function setLoadingScreenStyles(screen:LoadingScreen):Void {
		var skin:RectangleSkin = new RectangleSkin();
		skin.fill = SolidColor(ThemeProperties.APP_BACKGROUND_COLOR, 1.0);
		screen.backgroundSkin = skin;

		var vl:VerticalLayout = new VerticalLayout();
		vl.horizontalAlign = CENTER;
		vl.verticalAlign = MIDDLE;
		screen.layout = vl;
	}

	//-----------------------------------
	// StartControl
	//-----------------------------------

	public function setStartControlStyles(control:StartControl):Void {
		set_AnimatedButtonSkinStyles(control, 32);
		control.setPadding(16);
	}

	//-----------------------------------------------------------------------------
	// Util :: Methods
	//-----------------------------------------------------------------------------

	private function getActiveThemeFill():FillStyle {
		var colors = [
			ThemeProperties.THEME_COLOR_SECONDARY_500,
			ThemeProperties.THEME_COLOR_SECONDARY_700
		];
		return Gradient(GradientType.LINEAR, colors, [1.0, 1.0], [0, 0xff], Math.PI / 2.0);
	}
}
