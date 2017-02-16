////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package spark.skins.android5.supportClasses
{
	import spark.components.supportClasses.MobileGridHeader;
	import spark.utils.MultiDPIBitmapSource;

	public class MobileGridHeader extends spark.components.supportClasses.MobileGridHeader
	{
		[Embed(source="assets/640/up.png")]
		private var ascIcon640Cls:Class;
		
		[Embed(source="assets/640/down.png")]
		private var descIcon640Cls:Class;
		
		[Embed(source="assets/480/up.png")]
		private var ascIcon480Cls:Class;
		
		[Embed(source="assets/480/down.png")]
		private var descIcon480Cls:Class;
		
		[Embed(source="assets/320/up.png")]
		private var ascIcon320Cls:Class;
		
		[Embed(source="assets/320/down.png")]
		private var descIcon320Cls:Class;
		
		[Embed(source="assets/240/up.png")]
		private var ascIcon240Cls:Class;
		
		[Embed(source="assets/240/down.png")]
		private var descIcon240Cls:Class;
		
		[Embed(source="/assets/160/up.png")]
		private var ascIcon160Cls:Class;
		
		[Embed(source='/assets/160/down.png')]
		private var descIcon160Cls:Class;
		
		[Embed(source="/assets/120/up.png")]
		private var ascIcon120Cls:Class;
		
		[Embed(source='/assets/120/down.png')]
		private var descIcon120Cls:Class;
		
		public function MobileGridHeader()
		{
			super();
			descIconCls = new MultiDPIBitmapSource();
			descIconCls.source120dpi = descIcon120Cls;
			descIconCls.source160dpi = descIcon160Cls;
			descIconCls.source240dpi = descIcon240Cls;
			descIconCls.source320dpi = descIcon320Cls;
			descIconCls.source480dpi = descIcon480Cls;
			descIconCls.source640dpi = descIcon640Cls;
			ascIconCls = new MultiDPIBitmapSource();
			ascIconCls.source120dpi = ascIcon120Cls;
			ascIconCls.source160dpi = ascIcon160Cls;
			ascIconCls.source240dpi = ascIcon240Cls;
			ascIconCls.source320dpi = ascIcon320Cls;
			ascIconCls.source480dpi = ascIcon480Cls;
			ascIconCls.source640dpi = ascIcon640Cls;
			this.setStyle("iconPlacement", "left");
		}
		
	}
	
}
