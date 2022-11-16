/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.context.playlist.api;

class PlayListListData {
	//-----------------------------------------------------------------------------
	// API :: Properties
	//-----------------------------------------------------------------------------
	//-----------------------------------
	// name
	//-----------------------------------
	private var _name:String;

	/**
		Doc `name`.
	 */
	public var name(get, null):String;

	private function get_name():String {
		return _name;
	}

	//-----------------------------------
	// url
	//-----------------------------------
	private var _url:String;

	/**
		Doc `url`.
	 */
	public var url(get, null):String;

	private function get_url():String {
		return _url;
	}

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------

	/** */
	public function new() {
		super();
	}
}
