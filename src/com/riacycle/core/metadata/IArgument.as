package com.riacycle.core.metadata
{
	import com.riacycle.core.reflection.Annotation;
	
	import mx.core.UIComponent;

	public interface IArgument
	{
		function setNext(arg:IArgument):void;
		function execute(component:Object,annotation:Annotation):void;
	}
}