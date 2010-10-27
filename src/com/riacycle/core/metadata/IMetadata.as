package com.riacycle.core.metadata
{	
	import com.riacycle.core.reflection.Field;
	
	import mx.core.UIComponent;

	public interface IMetadata
	{
		function execute(component:Object,field:Field):void;
	}
}