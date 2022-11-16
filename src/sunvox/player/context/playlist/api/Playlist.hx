/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunsunvox.player.context.common.ui.api.vo;

class Playlist {
	public var uid:String;
	public var name:String;
	public var url:String;
	public var items:Array<PlayListListData>;

	public function new() {
		items = new Array<PlayListListData>();
	}
}
