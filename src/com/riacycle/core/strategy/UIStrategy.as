package com.riacycle.core.strategy
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import com.riacycle.core.reflection.Field;

	public interface UIStrategy
	{
		function executeStragegy(obj:Object, dataProviders:Array, field:Field):UIComponent
	}
}