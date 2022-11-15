/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.app;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.enhancedLogging.impl.TraceLogTarget;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.impl.Context;
import signals.Signal;
import sunvox.app.bundles.SunVoxBundle;
import sunvox.extensions.engine.core.SunVoxContext;
import sunvox.player.app.config.AppBundle;
import sunvox.player.app.config.AppConfig;

class ApplicationContext {
	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private var _applicationController:ApplicationController;
	private var _rootContext:Context;

	//-----------------------------------------------------------------------------
	// API :: Signals
	//-----------------------------------------------------------------------------
	public var onAudioEngineStateChange:Signal = new Signal();

	//-----------------------------------------------------------------------------
	// API :: Properties
	//-----------------------------------------------------------------------------
	//-----------------------------------
	// logger
	//-----------------------------------
	private var _logger:ILogger;

	public var logger(default, never):ILogger;

	private function get_logger():ILogger {
		return _logger;
	}

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------

	/** */
	public function new(applicationController:ApplicationController) {
		_applicationController = applicationController;

		createContainerContext();
	}

	//-----------------------------------------------------------------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	/**
		Returns a class logger for client.

		@param client The logging client of this logger.
	 */
	public function getLogger(client:Dynamic):ILogger {
		return _rootContext.getLogger(client);
	}

	/** */
	public function startupAndRun():Void {
		var sunVoxContext:SunVoxContext = _rootContext.injector.getInstance(SunVoxContext);
		sunVoxContext.startAsync((success:Bool) -> {
			trace('Audio Engine loaded: ${success}');
		});
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------

	private function createContainerContext():Void {
		_rootContext = new Context();
		_rootContext.addLogTarget(new TraceLogTarget(_rootContext));

		_logger = _rootContext.getLogger(this);

		_logger.info("_rootContext.install()");

		_rootContext.install(MVCSBundle, AppBundle, SunVoxBundle).configure(AppConfig, new ContextView(_applicationController.root));

		_logger.info("_rootContext.initialize()");
		_rootContext.initialize();

		var applicationContext:ApplicationController = _rootContext.get_injector().getInstance(ApplicationController);
	}
}
