/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.app;

import feathers.layout.VerticalLayoutData;
import openfl.display.DisplayObjectContainer;
import org.swiftsuspenders.utils.DescribedType;
import robotlegs.bender.framework.api.ILogger;
import signals.Signal;
import sunvox.api.Lib;
import sunvox.player.context.ui.screen.LoadingScreen;

@:keep
class ApplicationController implements DescribedType {
	private static var _applicationContext:ApplicationContext;

	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private var _logger:ILogger;

	private var loadingScreen:LoadingScreen;

	private var sunVoxConfig:String = null;
	private var sunVoxSampleRate:Int = 44100;
	private var sunVoxNumChannels:Int = 2;
	private var sunVoxFlags:Int = 0;

	//-----------------------------------------------------------------------------
	// API :: Signals
	//-----------------------------------------------------------------------------
	public var onAudioEngineStateChange:Signal = new Signal();

	//-----------------------------------------------------------------------------
	// API :: Properties
	//-----------------------------------------------------------------------------
	//-----------------------------------
	// root
	//-----------------------------------
	public var root(default, null):DisplayObjectContainer;

	//-----------------------------------
	// isAudioEngineRunning
	//-----------------------------------
	private var _hasUserActivity:Bool;

	/**	 */
	public var hasUserActivity(get, set):Bool;

	private function get_hasUserActivity():Bool {
		return _hasUserActivity;
	}

	private function set_hasUserActivity(value:Bool):Bool {
		if (_hasUserActivity == value)
			return _hasUserActivity;

		_hasUserActivity = value;

		onAudioEngineStateChange.dispatch();

		return _hasUserActivity;
	}

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	public function new() {}

	//-------------------------------------------------------Z----------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	/**
		Creates and adds the first preloading screen, then creates the root 
		`ApplicationContext` passing the root `DisplayObjectContainer`.

		@param root `Main`
	 */
	public function boot(root:Main):ApplicationContext {
		this.root = root;

		preload();

		_applicationContext = createApplicationContext();

		_logger = _applicationContext.getLogger(this);

		return _applicationContext;
	}

	/**
		Starts the audio bootstrap initialization.

		After the audio engine has been created and initialized, the application
		model with be created and started. Once the operations are complete, the
		`AUDIO_ENGINE_COMPLETE` signal will be broadcast.

		@event `AUDIO_ENGINE_COMPLETE` The audio engine
				has been initialized.
	 */
	public function startAsync():Void {
		initAudioEngineAsync();
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------

	private function preload():Void {
		trace("Preload");

		loadingScreen = new LoadingScreen();
		loadingScreen.layoutData = new VerticalLayoutData(100, 100);
		loadingScreen.onUserActivity.add(function():Void {
			startAsync();
		});

		root.addChild(loadingScreen);
	}

	private function createApplicationContext() {
		var context = new ApplicationContext(this);
		return context;
	}

	private function status(message:String):Void {
		trace(message);
	}

	private function initAudioEngineAsync():Void {
		if (hasUserActivity)
			return;

		// Global sound system init
		var ver:Int = Lib.sv_init(sunVoxConfig, sunVoxSampleRate, sunVoxNumChannels, sunVoxFlags);
		if (ver >= 0) {
			status("init ok");
			hasUserActivity = true;
		} else {
			status("init error");
			hasUserActivity = false;
		}

		if (hasUserActivity) {
			trace("AudioEngine loaded");
		} else {
			trace("AudioEngine not loaded");
		}
	}

	public function clientGuesture() {
		hasUserActivity = true;
		// XXX AppEvent.AUDIO_ENGINE_COMPLETE
	}
}
