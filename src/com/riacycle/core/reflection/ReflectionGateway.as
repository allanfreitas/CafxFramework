package com.riacycle.core.reflection
{
	import mx.collections.ArrayCollection;
	
	import org.as3commons.reflect.Type;

	public interface ReflectionGateway
	{
		 
		function getClazz(obj:Object):Clazz;
		
		function getFields(obj:Object):ArrayCollection;
		
		function getAnnotations(obj:Object, field:String):ArrayCollection;
		
		function getAnnotationMaps(obj:Object, field:String,key:String):ArrayCollection;
		
	}
}